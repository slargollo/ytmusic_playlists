import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ytmusic/src/services/database.dart';
import 'package:ytmusic/src/services/ytmusic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final getIt = GetIt.instance;

AppLocalizations local(BuildContext context) {
  return AppLocalizations.of(context)!;
}

// @riverpod
// Future<List<PlaylistFull>> playlists(Ref ref) {
//   return Services.db.loadPlaylists();
// }

class Services {
  static Future<void> initialize() async {
    getIt.registerSingleton<YTMusicService>(YTMusicService());
    getIt.registerSingleton<DatabaseService>(DatabaseService());
    await music.initialize();
  }

  static YTMusicService get music {
    return getIt<YTMusicService>();
  }
}
