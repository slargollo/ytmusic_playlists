import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/body_progress.dart';
import 'package:ytmusic/src/widgets/playlists_view.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

import '../widgets/side_menu.dart';
import 'add_playlist.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      title: const Text('My Playlists'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPlaylistPage(),
            ),
          );
        },
        tooltip: 'Add new playlist',
        child: const Icon(Icons.add),
      ),
      child: FutureBuilder(
        future: Services.db.loadPlaylists(),
        builder: (BuildContext context, AsyncSnapshot<List<PlaylistFull>> snapshot) {
          return BodyProgress(
            state: snapshot.connectionState,
            child: PlaylistsView(playLists: snapshot.data),
          );
        },
      ),
    );
  }
}
