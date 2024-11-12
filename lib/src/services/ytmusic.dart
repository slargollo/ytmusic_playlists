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
      // for (var track in playlist.tracks) {
      //   final album = await _ytMusic.getAlbum(track.album.albumId);
      //   track.album.thumbnail = (album.thumbnails.where((t) => t.width >= 96).firstOrNull ?? album.thumbnails.first).url;
      // }
      await Services.db.addPlaylist(playlist);
    } catch (err) {
      print(err);
    }
    return playlist;
  }

  Future<bool> removePlaylist(String playlistId) async {
    return await Services.db.removePlaylist(playlistId);
  }

  // Future<List<SongDetailed>> searchSongs(String query) async {
  //   final results = await _ytMusic.searchSongs(query);
  //   return results;
  // }

  // Future<List<PlaylistDetailed>> searchPlaylists(String query) async {
  //   final results = await _ytMusic.searchPlaylists(query);
  //   return results;
  // }

  // Future<PlaylistFull> getPlaylist(String playlistId) async {
  //   final results = await _ytMusic.getPlaylist(playlistId);
  //   return results;
  // }
}
