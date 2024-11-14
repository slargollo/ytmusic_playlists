import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:ytmusic/src/pages/add_playlist.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/body_progress.dart';
import 'package:ytmusic/src/widgets/playlists_view.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

/// Gerenciador de playlists
class PlaylistManager extends StatefulWidget {
  const PlaylistManager({super.key});

  @override
  PlaylistManagerState createState() => PlaylistManagerState();
}

class PlaylistManagerState extends State<PlaylistManager> {
  late Future<List<PlaylistFull>> _rebuildCall;

  @override
  void initState() {
    super.initState();
    _rebuildCall = Services.music.loadPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Botão para adicionar novas playlists
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const AddPlaylistPage(),
              ))
              .then((changed) => _onRefresh(changed));
        },
        tooltip: local(context).addNewPlaylist,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _rebuildCall,
        builder: (BuildContext context, AsyncSnapshot<List<PlaylistFull>> snapshot) {
          return BodyProgress(
            state: snapshot.connectionState,
            // Exibe a lista de playlists cadastradas
            child: PlaylistsView(
              playLists: snapshot.data,
              onRemove: (p) => _onRemove(context, p),
              onRefresh: _onRefreshPlaylist,
              readOnly: false,
            ),
          );
        },
      ),
    );
  }

  // Remove a playlist selecionada
  void _onRemove(BuildContext context, PlaylistFull playlist) {
    showAdaptiveActionSheet(
      context: context,
      actions: [
        BottomSheetAction(
          title: Text(local(context).yesLabel),
          onPressed: (_) {
            Navigator.pop(context);
            setState(() {
              _rebuildCall = Services.music
                  .removePlaylist(playlist.playlistId) //
                  .then((val) => Services.music.loadPlaylists());
            });
          },
        ),
      ],
      cancelAction: CancelAction(title: Text(local(context).noLabel)),
      title: Text(local(context).removePlaylistConfirm(playlist.name)),
    );
  }

  // Faz o refresh da lista, se necessário
  void _onRefresh(bool changed) {
    if (changed) {
      setState(() {
        _rebuildCall = Services.music.loadPlaylists();
      });
    }
  }

  _onRefreshPlaylist(PlaylistFull playlist) {
    setState(() {
      _rebuildCall = Services.music.refreshPlaylist(playlist);
    });
  }
}
