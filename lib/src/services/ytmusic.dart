import 'package:flutter/foundation.dart';
import 'package:ytmusic/src/services.dart';

import '../ytmusic_api/types.dart';
import '../ytmusic_api/yt_music.dart';

class YTMusicService {
  late YTMusic _ytMusic;

  Future<void> initialize() async {
    _ytMusic = YTMusic();
    await _ytMusic.initialize();
  }

  Future<PlaylistFull?> addPlaylist(String idOrUrl) async {
    String playlistId;
    PlaylistFull? playlist;
    try {
      if (idOrUrl.contains('?')) {
        playlistId = idOrUrl.split('?')[1].split('&')[0].split('=')[1];
      } else {
        playlistId = idOrUrl;
      }
      playlist = await _ytMusic.getPlaylist(playlistId);
      await Services.db.addPlaylist(playlist);
    } catch (err) {
      if (kDebugMode) {
        debugPrint('$err');
      }
    }
    return playlist;
  }

  Future<bool> removePlaylist(String playlistId) async {
    return await Services.db.removePlaylist(playlistId);
  }

  Future<AlbumBasic> loadAlbum(AlbumBasic album) async {
    if (!album.hasThumbnail) {
      AlbumFull? details;
      try {
        details = await _ytMusic.getAlbum(album.albumId);
      } catch (err) {
        if (kDebugMode) {
          debugPrint('$err');
        }
      }
      album.thumbnail = (details?.thumbnails.where((a) => a.width >= 96).firstOrNull)?.url ?? emptyThumbnail;
      return await Services.db.updateAlbum(album);
    }
    return album;
  }
}
