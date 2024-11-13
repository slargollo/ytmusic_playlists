import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                    padding: const EdgeInsets.all(16.0),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: playlist.tracks.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: playlist.tracks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(playlist.tracks[index].title),
                            Text('${playlist.tracks[index].album.name} - ${playlist.tracks[index].length}'),
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
