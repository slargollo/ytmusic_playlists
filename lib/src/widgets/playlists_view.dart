import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ytmusic/src/pages/view_playlist.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

typedef PlaylistRemoveCallback = void Function(PlaylistFull playlist);

class PlaylistsView extends StatelessWidget {
  const PlaylistsView({super.key, this.playLists, this.onRemove, this.readOnly});

  final List<PlaylistFull>? playLists;
  final PlaylistRemoveCallback? onRemove;
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
          readOnly: readOnly,
        ),
      );
    }
    return const Center(child: Text('No playlist was found.'));
  }
}

class PlaylistDetailView extends StatelessWidget {
  const PlaylistDetailView({super.key, required this.playlist, this.onRemove, this.readOnly});

  final PlaylistFull playlist;
  final PlaylistRemoveCallback? onRemove;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return (readOnly ?? true) || onRemove == null
        ? PlayListItem(playlist: playlist)
        : Slidable(
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (ctx) => onRemove!(playlist),
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Remove',
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ViewPlaylistPage(playlist: playlist),
                  ),
                );
              },
        leading: Image.network(
          playlist.smallThumb,
          width: 96,
          height: 96,
        ),
        title: Text('${playlist.name} - ${playlist.videoCount} tracks'),
      ),
    );
  }
}
