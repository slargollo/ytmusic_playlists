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
          ViewPlaylistHeader(playlist: playlist),
          Expanded(
            child: playlist.tracks.isEmpty
                ? Container()
                : ListView.builder(
                    itemCount: playlist.tracks.length,
                    itemBuilder: (context, index) => AlbumListTile(track: playlist.tracks[index]),
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
    );
  }
}

class AlbumListTile extends StatelessWidget {
  const AlbumListTile({
    super.key,
    required this.track,
  });

  final PlaylistTrack track;
  final double trackThumbSize = 56;

  @override
  Widget build(BuildContext context) {
    final albumTitle = track.album.name == emptyAlbumName ? track.length : '${track.album.name} - ${track.length}';
    return ListTile(
      title: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: track.album.needsThumbnail
                  ? FutureBuilder(
                      future: Services.music.loadAlbum(track.album),
                      builder: (BuildContext context, AsyncSnapshot<AlbumBasic> snapshot) {
                        return AlbumThumbnailWidget(
                          album: snapshot.data,
                          state: snapshot.connectionState,
                        );
                      })
                  : AlbumThumbnailWidget(
                      album: track.album,
                    ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(albumTitle),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AlbumThumbnailWidget extends StatelessWidget {
  const AlbumThumbnailWidget({super.key, this.album, this.state});

  final AlbumBasic? album;
  final ConnectionState? state;
  final double trackThumbSize = 56;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final realState = state ?? ConnectionState.done;
        if (realState != ConnectionState.done) {
          return SizedBox(
            width: trackThumbSize,
            height: trackThumbSize,
            child: Center(
              child: state == ConnectionState.none
                  ? Container()
                  : SizedBox(
                      width: trackThumbSize - 26,
                      height: trackThumbSize - 26,
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        }
        if (album?.hasThumbnail ?? false) {
          return Image.network(
            album!.thumbnail!,
            width: trackThumbSize,
            height: trackThumbSize,
          );
        }
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
          ),
          child: Image.asset(
            'assets/empty-album.png',
            width: trackThumbSize,
            height: trackThumbSize,
          ),
        );
      },
    );
  }
}
