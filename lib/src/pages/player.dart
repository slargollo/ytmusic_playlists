import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';
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
      body: Column(
        children: [
          PlayerQueueWidget(
            tracks: tracks,
            startTrack: startTrack,
          ),
        ],
      ),
    );
  }
}

class PlayerQueueWidget extends StatefulWidget {
  const PlayerQueueWidget({super.key, required this.tracks, required this.startTrack});

  final List<PlaylistTrack> tracks;
  final int startTrack;

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
    return PlayerWidget(
      track: currentTrack,
    );
  }
}

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key, required this.track});

  final PlaylistTrack track;

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
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CircularProgressIndicator(),
                ),
              );
            })
      ],
    );
  }
}

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key, required this.controller, required this.stream, required this.track});

  final PlaylistTrack track;

  final Stream<Duration> stream;

  final YPlayerController controller;

  @override
  AudioPlayerState createState() => AudioPlayerState();
}

class AudioPlayerState extends State<AudioPlayer> {
  Duration get duration => widget.controller.duration;

  bool get paused => _status == YPlayerStatus.paused;

  bool get playing => _status == YPlayerStatus.playing;

  bool get stopped => _status == YPlayerStatus.stopped;

  bool get error => _status == YPlayerStatus.error;

  bool _processing = false;

  Duration get _duration => widget.controller.duration;

  Duration _position = Duration(seconds: 0);

  YPlayerStatus get _status => widget.controller.status;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
        double value = 0.0;
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            _position = snapshot.data!;
            value = duration.inSeconds > 0 ? _position.inSeconds / duration.inSeconds : 0;
            break;
          default:
            break;
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.track.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      'by ${widget.track.artist.name}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Builder(builder: (context) {
                    return widget.track.album.isEmpty
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              widget.track.album.name,
                              style: TextStyle(fontSize: 16),
                            ),
                          );
                  }),
                ],
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
                          onPressed: !_processing ? _previous : null,
                        ),
                        PlayerButton(
                          icon: Icons.stop_circle_outlined,
                          onPressed: playing && !_processing ? _stop : null,
                        ),
                        PlayerButton(
                          icon: Icons.arrow_circle_right_outlined,
                          onPressed: !_processing ? _next : null,
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

  void _next() {
    setState(() {
      _processing = true;
    });
    widget.controller.stop().then((_) {
      setState(() {
        _processing = false;
      });
    });
  }

  void _previous() {
    setState(() => _processing = true);
    widget.controller.stop().then((_) {
      setState(() => _processing = false);
    });
  }

  void _stop() {
    setState(() {
      _position = Duration(seconds: 0);
      _processing = true;
    });
    widget.controller.stop().then((_) {
      setState(() => _processing = false);
    });
  }

  void _toggle() {
    setState(() => _processing = true);
    Future.microtask(() async {
      if (paused || stopped) {
        await widget.controller.play();
      } else {
        await widget.controller.pause();
      }
    }).then((_) {
      setState(() => _processing = false);
    });
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
