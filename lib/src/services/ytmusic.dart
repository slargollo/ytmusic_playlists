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
    if (idOrUrl.contains('?')) {
      playlistId = idOrUrl.split('?')[1].split('&')[0].split('=')[1];
    } else {
      playlistId = idOrUrl;
    }
    final playlist = await _ytMusic.getPlaylist(playlistId);
    await Services.db.addPlaylist(playlist);
    return playlist;
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
