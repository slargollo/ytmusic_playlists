import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:ytmusic/src/ytmusic_api/dart_ytmusic_api.dart';

part 'database.g.dart';

class ArtistTable extends Table {
  TextColumn get artistId => text()();
  TextColumn get name => text()();
  BoolColumn get isValidId => boolean()();

  @override
  Set<Column> get primaryKey => {artistId};

  static ArtistTableCompanion insert(ArtistBasic artist) {
    return ArtistTableCompanion.insert(
      artistId: artist.id,
      name: artist.name,
      isValidId: artist.isValidId,
    );
  }
}

class AlbumTable extends Table {
  TextColumn get albumId => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {albumId};

  static AlbumTableCompanion insert(AlbumBasic album) {
    return AlbumTableCompanion.insert(
      albumId: album.albumId,
      name: album.name,
    );
  }
}

class PlaylistTable extends Table {
  TextColumn get playlistId => text()();
  TextColumn get type => text()();
  TextColumn get name => text()();
  TextColumn get artistId => text().references(ArtistTable, #artistId)();
  IntColumn get videoCount => integer()();
  TextColumn get thumbnail => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {playlistId};

  static PlaylistTableCompanion insert(PlaylistFull playlist) {
    return PlaylistTableCompanion.insert(
      playlistId: playlist.playlistId,
      type: playlist.type,
      name: playlist.name,
      artistId: playlist.artist.id,
      videoCount: playlist.videoCount,
      thumbnail: playlist.thumbnail,
      createdAt: DateTime.now(),
    );
  }

  // PlaylistTable.from(PlaylistFull playlist)  : playlistId
}

class PlaylistTrackTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get playlistId => text().references(PlaylistTable, #playlistId)();
  TextColumn get title => text()();
  TextColumn get artistId => text().references(ArtistTable, #artistId)();
  TextColumn get albumId => text().references(AlbumTable, #albumId)();
  TextColumn get videoId => text()();
  TextColumn get length => text()();

  static PlaylistTrackTableCompanion insert(PlaylistTrack track) {
    return PlaylistTrackTableCompanion.insert(
      playlistId: track.playlistId,
      albumId: track.album.albumId,
      artistId: track.artist.artistId!,
      length: track.length,
      title: track.title,
      videoId: track.videoId,
    );
  }
}

@DriftDatabase(tables: [
  ArtistTable,
  AlbumTable,
  PlaylistTable,
  PlaylistTrackTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // driftDatabase from package:drift_flutter stores the database in
    // getApplicationDocumentsDirectory().
    return driftDatabase(name: 'db_ytmusic');
  }
}

class DatabaseService {
  final _db = AppDatabase();

  Future<void> addPlaylist(PlaylistFull playlist) async {
    await _db.batch((batch) {
      // Atualiza o artista
      final artist = ArtistTable.insert(playlist.artist);
      batch.insertAllOnConflictUpdate(
        _db.artistTable,
        [artist],
      );
      // Atualiza a playlist
      final playlistTb = PlaylistTable.insert(playlist);
      batch.insertAllOnConflictUpdate(
        _db.playlistTable,
        [playlistTb],
      );
      // Atualiza as tracks
      batch.insertAllOnConflictUpdate(
        _db.artistTable,
        playlist.tracks.map((t) => ArtistTable.insert(t.artist)).toList(),
      );
      batch.insertAllOnConflictUpdate(
        _db.albumTable,
        playlist.tracks.map((t) => AlbumTable.insert(t.album)).toList(),
      );
      batch.insertAll(
        _db.playlistTrackTable,
        playlist.tracks.map(PlaylistTrackTable.insert).toList(),
      );
    });
  }

  Future<List<PlaylistFull>> loadPlaylists() async {
    final select = await (_db.select(_db.playlistTable)..orderBy([(p) => OrderingTerm(expression: p.name)])).get();
    return await Future.wait(select.map(dataToPlaylist));
  }

  Future<PlaylistFull> dataToPlaylist(PlaylistTableData data) async {
    var artist = await (_db.select(_db.artistTable)..where((e) => e.artistId.equals(data.artistId))).getSingle();
    var tracks = await (_db.select(_db.playlistTrackTable)..where((e) => e.playlistId.equals(data.playlistId))).get();
    return PlaylistFull.fromData(data, ArtistBasic.fromData(artist), await Future.wait(tracks.map(dataToTrack)));
  }

  Future<PlaylistTrack> dataToTrack(PlaylistTrackTableData data) async {
    var artist = await (_db.select(_db.artistTable)..where((e) => e.artistId.equals(data.artistId))).getSingle();
    var album = await (_db.select(_db.albumTable)..where((e) => e.albumId.equals(data.albumId))).getSingle();
    return PlaylistTrack.fromData(data, ArtistBasic.fromData(artist), AlbumBasic.fromData(album));
  }
}