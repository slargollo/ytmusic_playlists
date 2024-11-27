import 'package:flutter/material.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/widgets/image_thumbnail.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

class TrackListTile extends StatelessWidget {
  const TrackListTile({
    super.key,
    this.selected,
    required this.track,
  });

  final PlaylistTrack track;

  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      minVerticalPadding: 0.0,
      title: IntrinsicHeight(
        child: Container(
          decoration: (selected ?? false)
              ? BoxDecoration(
                  color: const Color(0xFFecf3ff),
                  border: Border(
                    top: BorderSide(color: Colors.blue[800]!),
                    bottom: BorderSide(color: Colors.blue[800]!),
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: ImageThumbnail(
                    future: Services.music.loadAlbum(track),
                    target: track.album,
                    trackThumbSize: 56,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          track.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(track.album.isEmpty ? track.artist.name : '${track.artist.name} - ${track.album.name}'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  child: Center(
                      child: Text(
                    track.length,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
