import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ytmusic/src/pages/view_playlist.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

typedef PlaylistRemoveCallback = void Function(PlaylistFull playlist);

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({
    super.key,
    this.playLists,
    this.onRemove,
    this.readOnly,
    this.onRefresh,
  });

  final List<PlaylistFull>? playLists;
  final PlaylistRemoveCallback? onRemove;
  final PlaylistRemoveCallback? onRefresh;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    if (playLists?.isNotEmpty ?? false) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: playLists!.length,
        itemBuilder: (context, index) => PlaylistDetailView(
          playlist: playLists![index],
          onRemove: onRemove,
          onRefresh: onRefresh,
          readOnly: readOnly,
        ),
      );
    }
    return Center(child: Text(local(context).playlistNotFound));
  }
}

class PlaylistDetailView extends StatelessWidget {
  const PlaylistDetailView({
    super.key,
    required this.playlist,
    this.onRemove,
    this.readOnly,
    this.onRefresh,
  });

  final PlaylistFull playlist;
  final PlaylistRemoveCallback? onRemove;
  final PlaylistRemoveCallback? onRefresh;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return (readOnly ?? true)
        ? PlayListItem(playlist: playlist)
        : Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (ctx) => onRefresh!(playlist),
                  backgroundColor: Colors.blue[600]!,
                  foregroundColor: Colors.white,
                  icon: Icons.refresh,
                  label: local(context).refreshLabel,
                ),
                SlidableAction(
                  onPressed: (ctx) => onRemove!(playlist),
                  backgroundColor: Colors.red[600]!,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: local(context).removeLabel,
                ),
              ],
            ),
            child: PlayListItem(
              playlist: playlist,
              readOnly: readOnly,
            ),
          );
  }
}

class PlayListItem extends StatelessWidget {
  const PlayListItem({super.key, required this.playlist, this.readOnly});

  final PlaylistFull playlist;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListTile(
        horizontalTitleGap: 0,
        onTap: readOnly ?? true
            ? null
            : () {
                Services.music.loadTracks(playlist).then((data) {
                  if (context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ViewPlaylistPage(playlist: data),
                      ),
                    );
                  }
                });
              },
        leading: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Image.network(
            playlist.smallThumb,
            width: 86,
            height: 86,
          ),
        ),
        title: Text('${playlist.name} - ${local(context).trackCount(playlist.videoCount)}'),
      ),
    );
  }
}
