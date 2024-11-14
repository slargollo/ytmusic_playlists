import 'package:flutter/foundation.dart';
import 'package:ytmusic/src/services.dart';
import 'package:ytmusic/src/services/database.dart';

import '../ytmusic_api/types.dart';
import '../ytmusic_api/yt_music.dart';

class YTMusicService {
  late YTMusic _ytMusic;

  DatabaseService get _db => getIt<DatabaseService>();

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
      await _db.addPlaylist(playlist);
    } catch (err) {
      if (kDebugMode) {
        debugPrint('$err');
      }
    }
    return playlist;
  }

  Future<bool> removePlaylist(String playlistId) async {
    return await _db.removePlaylist(playlistId);
  }

  Future<AlbumBasic> loadAlbum(PlaylistTrack track) async {
    if (!track.album.hasThumbnail) {
      try {
        if (track.album.isEmpty) {
          final song = await _ytMusic.getSong(track.videoId);
          // debugPrint('---------------------------');
          // debugPrint(track.title);
          // song.thumbnails.forEach((t) {
          //   debugPrint('${t.url} - ${t.width} : ${t.height}');
          // });
          // debugPrint('---------------------------');
          track.album.thumbnail = (song.thumbnails.where((a) => a.width >= 96).firstOrNull)?.url ?? emptyThumbnail;
        } else {
          final details = await _ytMusic.getAlbum(track.album.albumId);
          track.album.thumbnail = (details.thumbnails.where((a) => a.width >= 96).firstOrNull)?.url ?? emptyThumbnail;
        }
      } catch (err) {
        if (kDebugMode) {
          debugPrint('$err');
          track.album.thumbnail = emptyThumbnail;
        }
      }
      return await _db.updateAlbum(track.album);
    }
    return track.album;
  }

  Future<List<PlaylistFull>> loadPlaylists() async {
    return await _db.loadPlaylists();
  }

  Future<List<PlaylistFull>> refreshPlaylist(PlaylistFull playlist) async {
    await removePlaylist(playlist.playlistId);
    await addPlaylist(playlist.playlistId);
    return await loadPlaylists();
  }

  Future<PlaylistFull> loadTracks(PlaylistFull playlist) async {
    return await _db.loadTracks(playlist);
  }
}
