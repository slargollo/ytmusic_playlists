import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ytmusic/src/services/database.dart';
import 'package:ytmusic/src/services/ytmusic.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

part 'services.g.dart';

final getIt = GetIt.instance;

@riverpod
Future<List<PlaylistFull>> playlists(Ref ref) {
  return Services.db.loadPlaylists();
}

class Services {
  static Future<void> initialize() async {
    getIt.registerSingleton<YTMusicService>(YTMusicService());
    getIt.registerSingleton<DatabaseService>(DatabaseService());
    await music.initialize();
  }

  static DatabaseService get db {
    return getIt<DatabaseService>();
  }

  static YTMusicService get music {
    return getIt<YTMusicService>();
  }
}
