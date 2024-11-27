import 'package:flutter/material.dart';
import 'package:ytmusic/src/pages/player.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/image_thumbnail.dart';
import 'package:ytmusic/src/widgets/track_list_tile.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

class ViewPlaylistPage extends StatelessWidget {
  const ViewPlaylistPage({super.key, required this.playlist});

  final PlaylistFull playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(local(context).viewPlaylistPageTitle),
      ),
      body: Column(
        children: [
          ViewPlaylistHeader(playlist: playlist),
          Expanded(
            child: playlist.tracks.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: playlist.tracks.length,
                    itemBuilder: (context, index) => TrackListTile(track: playlist.tracks[index]),
                  ),
          )
        ],
      ),
    );
  }
}

class ViewPlaylistHeader extends StatelessWidget {
  const ViewPlaylistHeader({
    super.key,
    required this.playlist,
  });

  final PlaylistFull playlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.network(
                  playlist.largeThumb,
                  width: 196,
                  height: 196,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    playlist.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(local(context).trackCount(playlist.videoCount)),
                  Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: IconButton(
                      icon: Icon(Icons.play_circle),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayerPage(playlists: [playlist]),
                        ));
                      },
                      style: ButtonStyle(iconSize: WidgetStateProperty.all(64)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
