import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/image_thumbnail.dart';
import 'package:ytmusic/src/widgets/track_list_tile.dart';
import 'package:ytmusic/src/y_player/enums/y_player_status.dart';
import 'package:ytmusic/src/y_player/y_player_controller.dart';
import 'package:ytmusic/src/y_player/y_player_main.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    super.key,
    this.playlists,
    this.tracks,
    this.startTrack,
  });

  final List<PlaylistFull>? playlists;
  final List<PlaylistTrack>? tracks;
  final int? startTrack;

  @override
  Widget build(BuildContext context) {
    List<PlaylistTrack> tracks;
    if (playlists != null) {
      tracks = playlists!.expand((p) => p.tracks).toList();
    } else {
      tracks = this.tracks!;
    }
    final startTrack = this.startTrack ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(local(context).playerPageTitle),
      ),
      body: PlayerQueueWidget(
        tracks: tracks,
        startTrack: startTrack,
      ),
    );
  }
}

class PlayerQueueWidget extends StatefulWidget {
  const PlayerQueueWidget({
    super.key,
    required this.tracks,
    required this.startTrack,
  });

  final int startTrack;

  final List<PlaylistTrack> tracks;

  @override
  PlayerQueueWidgetState createState() => PlayerQueueWidgetState();
}

class PlayerQueueWidgetState extends State<PlayerQueueWidget> {
  int trackIndex = 0;

  PlaylistTrack get currentTrack => widget.tracks[trackIndex];

  @override
  void initState() {
    trackIndex = widget.startTrack;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlayerWidget(
          trackIndex: trackIndex,
          tracks: widget.tracks,
          onNext: _onNext,
          onPrevious: _onPrevious,
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            left: 8,
            right: 8,
          ),
          child: Text('${(trackIndex + 1).toString().padLeft(widget.tracks.length.toString().length, '0')} / ${widget.tracks.length}'),
        ),
        Expanded(
          child: ScrollablePositionedList.builder(
            initialScrollIndex: trackIndex,
            itemCount: widget.tracks.length,
            itemBuilder: (context, index) => TrackListTile(
              track: widget.tracks[index],
              selected: index == trackIndex,
            ),
          ),
        ),
      ],
    );
  }

  void _onNext() {
    if (trackIndex < widget.tracks.length - 1) {
      setState(() => trackIndex += 1);
    }
  }

  void _onPrevious() {
    if (trackIndex > 0) {
      setState(() => trackIndex -= 1);
    }
  }
}

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({
    super.key,
    required this.trackIndex,
    required this.tracks,
    required this.onNext,
    required this.onPrevious,
  });

  final int trackIndex;

  final List<PlaylistTrack> tracks;

  final VoidCallback onNext;

  final VoidCallback onPrevious;

  PlaylistTrack get track => tracks[trackIndex];

  @override
  PlayerWidgetState createState() => PlayerWidgetState();
}

class PlayerWidgetState extends State<PlayerWidget> {
  int _lastPosition = 0;

  YPlayerController? _playerController;

  final Completer<YPlayerController> _playerCompleter = Completer();

  final StreamController<Duration> _progressController = StreamController<Duration>();

  StreamSink<Duration> get _progressSink => _progressController.sink;

  Stream<Duration> get _progressStream => _progressController.stream;

  bool get firstTrack => widget.trackIndex == 0;

  bool get lastTrack => widget.trackIndex == widget.tracks.length - 1;

  @override
  dispose() {
    _progressController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 0,
          height: 0,
          child: YPlayer(
            autoPlay: false,
            youtubeUrl: 'https://www.youtube.com/watch?v=${widget.track.videoId}',
            onProgressChanged: (position, duration) {
              if (_lastPosition != position.inSeconds) {
                _lastPosition = position.inSeconds;
                _progressSink.add(position);
              }
            },
            onControllerReady: (controller) {
              _playerController = controller;
              _playerCompleter.complete(_playerController);
            },
          ),
        ),
        FutureBuilder(
            future: _playerCompleter.future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AudioPlayer(
                  track: widget.track,
                  stream: _progressStream,
                  controller: snapshot.data!,
                  canGoNext: !lastTrack,
                  canGoPrevious: !firstTrack,
                  onNext: widget.onNext,
                  onPrevious: widget.onPrevious,
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Skeletonizer(
                    enabled: true,
                    child: AudioPlayer(),
                  ),
                ),
              );
            }),
      ],
    );
  }
}

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({
    super.key,
    this.controller,
    this.stream,
    this.track,
    this.onNext,
    this.onPrevious,
    this.canGoNext,
    this.canGoPrevious,
  });

  final PlaylistTrack? track;

  final Stream<Duration>? stream;

  final YPlayerController? controller;

  final VoidCallback? onNext;

  final VoidCallback? onPrevious;

  final bool? canGoNext;

  final bool? canGoPrevious;

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  late bool _processing;

  bool get paused => _status == YPlayerStatus.paused;

  bool get playing => _status == YPlayerStatus.playing;

  bool get stopped => _status == YPlayerStatus.stopped;

  bool get error => _status == YPlayerStatus.error;

  Duration get _duration => widget.controller?.duration ?? Duration();

  Duration get _position => widget.controller?.position ?? Duration();

  YPlayerStatus get _status => widget.controller?.status ?? YPlayerStatus.paused;

  @override
  void initState() {
    super.initState();
    _processing = widget.controller == null;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
        var value = _duration.inSeconds > 0 ? _position.inSeconds / _duration.inSeconds : 0.0;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: ImageThumbnail(
                        future: widget.track != null ? Services.music.loadAlbum(widget.track!) : _loadFakeTrack(),
                        target: widget.track?.album,
                        trackThumbSize: 96,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.track?.title ?? 'xxxxxx xx xxxxx xxxxxx',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4, bottom: 6),
                            child: Text(
                              widget.track != null ? 'by ${widget.track!.artist.name}' : 'xxxxxx xx xxxxx xxxxxx',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Text(
                            widget.track?.album.name ?? 'xxxxxx xx xxxxx xxxxxx',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  LinearProgressIndicator(
                    value: value,
                    minHeight: 10,
                  ),
                  ElevatedButton(
                    onPressed: !_processing ? _toggle : null,
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(0),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: Icon(
                      paused ? Icons.play_circle : Icons.pause_circle,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${_toText(_position)} / ${_toText(_duration)}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        PlayerButton(
                          icon: Icons.arrow_circle_left_outlined,
                          onPressed: !_processing && (widget.canGoPrevious ?? false) ? () => _move(false) : null,
                        ),
                        PlayerButton(
                          icon: Icons.stop_circle_outlined,
                          onPressed: playing && !_processing ? _stop : null,
                        ),
                        PlayerButton(
                          icon: Icons.arrow_circle_right_outlined,
                          onPressed: !_processing && (widget.canGoNext ?? false) ? () => _move(true) : null,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String _toText(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _move(bool next) {
    if (playing) {
      setState(() {
        _processing = true;
      });
      widget.controller!.stop().then((_) {
        setState(() {
          if (next) {
            widget.onNext!();
          } else {
            widget.onPrevious!();
          }
          _processing = false;
        });
      });
    } else {
      if (next) {
        widget.onNext!();
      } else {
        widget.onPrevious!();
      }
    }
  }

  void _stop() {
    setState(() {
      _processing = true;
    });
    widget.controller!.stop().then((_) {
      setState(() => _processing = false);
    });
  }

  void _toggle() {
    setState(() => _processing = true);
    Future.microtask(() async {
      if (paused || stopped) {
        await widget.controller!.play();
      } else {
        await widget.controller!.pause();
      }
    }).then((_) {
      setState(() => _processing = false);
    });
  }

  Future<AlbumBasic> _loadFakeTrack() async {
    await Future.delayed(Duration(seconds: 1));
    return AlbumBasic(albumId: emptyAlbumId, name: emptyAlbumName);
  }
}

class PlayerButton extends StatelessWidget {
  const PlayerButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: IconButton(
          iconSize: 36,
          icon: Icon(icon),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(0),
            foregroundColor: Colors.blueAccent,
          )),
    );
  }
}
