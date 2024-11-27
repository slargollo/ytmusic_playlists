import 'package:flutter/material.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({
    super.key,
    this.target,
    required this.future,
    required this.trackThumbSize,
  });

  final HasThumbnail? target;

  final double trackThumbSize;

  final Future<HasThumbnail> future;

  @override
  Widget build(BuildContext context) {
    return target?.needsThumbnail ?? false
        ? FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<HasThumbnail> snapshot) {
              return _InternalThumbnailWidget(
                target: snapshot.data,
                state: snapshot.connectionState,
                trackThumbSize: trackThumbSize,
              );
            })
        : _InternalThumbnailWidget(
            target: target,
            trackThumbSize: trackThumbSize,
          );
  }
}

class _InternalThumbnailWidget extends StatelessWidget {
  const _InternalThumbnailWidget({
    this.target,
    this.state,
    required this.trackThumbSize,
  });

  final HasThumbnail? target;

  final ConnectionState? state;

  final double trackThumbSize;

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
        if (target?.hasThumbnail ?? false) {
          return Image.network(
            target!.thumbnail!,
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
