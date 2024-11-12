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
    return HomePlaylistList();
  }
}

class HomePlaylistList extends StatefulWidget {
  const HomePlaylistList({super.key});

  @override
  HomePlaylistListState createState() => HomePlaylistListState();
}

class HomePlaylistListState extends State<HomePlaylistList> {
  late Future<List<PlaylistFull>> _rebuildCall;

  @override
  void initState() {
    super.initState();
    _rebuildCall = Services.db.loadPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      title: const Text('My Playlists'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const AddPlaylistPage(),
              ))
              .then((changed) => _onRefresh(changed));
        },
        tooltip: 'Add new playlist',
        child: const Icon(Icons.add),
      ),
      child: FutureBuilder(
        future: _rebuildCall,
        builder: (BuildContext context, AsyncSnapshot<List<PlaylistFull>> snapshot) {
          return BodyProgress(
            state: snapshot.connectionState,
            child: PlaylistsView(
              playLists: snapshot.data,
              onRemove: _onRemove,
            ),
          );
        },
      ),
    );
  }

  void _onRemove(PlaylistFull playlist) {
    setState(() {
      _rebuildCall = Services.music.removePlaylist(playlist.playlistId).then(
            (val) => Services.db.loadPlaylists(),
          );
    });
  }

  void _onRefresh(bool changed) {
    if (changed) {
      setState(() {
        _rebuildCall = Services.db.loadPlaylists();
      });
    }
  }
}
