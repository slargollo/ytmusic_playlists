import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 0,
          height: 0,
          child: Container(),
        ),
      ],
    );
  }
}
