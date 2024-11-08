import 'package:flutter/material.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key, this.playLists});

  final List<PlaylistFull>? playLists;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (playLists?.isNotEmpty ?? false) {
      playLists!.map((play) => PlaylistDetailView(playlist: play)).forEach(children.add);
    } else {
      children.add(const Center(child: Text('No playlist was found.')));
    }
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: children,
    );
  }
}

class PlaylistDetailView extends StatelessWidget {
  const PlaylistDetailView({super.key, required this.playlist});

  final PlaylistFull playlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        horizontalTitleGap: 0,
        leading: Image.network(
          playlist.thumbnail,
          width: 96,
          height: 96,
        ),
        title: Text('${playlist.name} - ${playlist.videoCount} tracks'),
      ),
    );
  }
}
