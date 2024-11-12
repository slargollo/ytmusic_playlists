// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ArtistTableTable extends ArtistTable
    with TableInfo<$ArtistTableTable, ArtistTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtistTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _artistIdMeta =
      const VerificationMeta('artistId');
  @override
  late final GeneratedColumn<String> artistId = GeneratedColumn<String>(
      'artist_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isValidIdMeta =
      const VerificationMeta('isValidId');
  @override
  late final GeneratedColumn<bool> isValidId = GeneratedColumn<bool>(
      'is_valid_id', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_valid_id" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [artistId, name, isValidId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artist_table';
  @override
  VerificationContext validateIntegrity(Insertable<ArtistTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_valid_id')) {
      context.handle(
          _isValidIdMeta,
          isValidId.isAcceptableOrUnknown(
              data['is_valid_id']!, _isValidIdMeta));
    } else if (isInserting) {
      context.missing(_isValidIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {artistId};
  @override
  ArtistTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArtistTableData(
      artistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      isValidId: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_valid_id'])!,
    );
  }

  @override
  $ArtistTableTable createAlias(String alias) {
    return $ArtistTableTable(attachedDatabase, alias);
  }
}

class ArtistTableData extends DataClass implements Insertable<ArtistTableData> {
  final String artistId;
  final String name;
  final bool isValidId;
  const ArtistTableData(
      {required this.artistId, required this.name, required this.isValidId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['artist_id'] = Variable<String>(artistId);
    map['name'] = Variable<String>(name);
    map['is_valid_id'] = Variable<bool>(isValidId);
    return map;
  }

  ArtistTableCompanion toCompanion(bool nullToAbsent) {
    return ArtistTableCompanion(
      artistId: Value(artistId),
      name: Value(name),
      isValidId: Value(isValidId),
    );
  }

  factory ArtistTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArtistTableData(
      artistId: serializer.fromJson<String>(json['artistId']),
      name: serializer.fromJson<String>(json['name']),
      isValidId: serializer.fromJson<bool>(json['isValidId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'artistId': serializer.toJson<String>(artistId),
      'name': serializer.toJson<String>(name),
      'isValidId': serializer.toJson<bool>(isValidId),
    };
  }

  ArtistTableData copyWith({String? artistId, String? name, bool? isValidId}) =>
      ArtistTableData(
        artistId: artistId ?? this.artistId,
        name: name ?? this.name,
        isValidId: isValidId ?? this.isValidId,
      );
  ArtistTableData copyWithCompanion(ArtistTableCompanion data) {
    return ArtistTableData(
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      name: data.name.present ? data.name.value : this.name,
      isValidId: data.isValidId.present ? data.isValidId.value : this.isValidId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArtistTableData(')
          ..write('artistId: $artistId, ')
          ..write('name: $name, ')
          ..write('isValidId: $isValidId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(artistId, name, isValidId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArtistTableData &&
          other.artistId == this.artistId &&
          other.name == this.name &&
          other.isValidId == this.isValidId);
}

class ArtistTableCompanion extends UpdateCompanion<ArtistTableData> {
  final Value<String> artistId;
  final Value<String> name;
  final Value<bool> isValidId;
  final Value<int> rowid;
  const ArtistTableCompanion({
    this.artistId = const Value.absent(),
    this.name = const Value.absent(),
    this.isValidId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArtistTableCompanion.insert({
    required String artistId,
    required String name,
    required bool isValidId,
    this.rowid = const Value.absent(),
  })  : artistId = Value(artistId),
        name = Value(name),
        isValidId = Value(isValidId);
  static Insertable<ArtistTableData> custom({
    Expression<String>? artistId,
    Expression<String>? name,
    Expression<bool>? isValidId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (artistId != null) 'artist_id': artistId,
      if (name != null) 'name': name,
      if (isValidId != null) 'is_valid_id': isValidId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArtistTableCompanion copyWith(
      {Value<String>? artistId,
      Value<String>? name,
      Value<bool>? isValidId,
      Value<int>? rowid}) {
    return ArtistTableCompanion(
      artistId: artistId ?? this.artistId,
      name: name ?? this.name,
      isValidId: isValidId ?? this.isValidId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isValidId.present) {
      map['is_valid_id'] = Variable<bool>(isValidId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistTableCompanion(')
          ..write('artistId: $artistId, ')
          ..write('name: $name, ')
          ..write('isValidId: $isValidId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumTableTable extends AlbumTable
    with TableInfo<$AlbumTableTable, AlbumTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _albumIdMeta =
      const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbnailMeta =
      const VerificationMeta('thumbnail');
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
      'thumbnail', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [albumId, name, thumbnail];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'album_table';
  @override
  VerificationContext validateIntegrity(Insertable<AlbumTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(_thumbnailMeta,
          thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta));
    } else if (isInserting) {
      context.missing(_thumbnailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {albumId};
  @override
  AlbumTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlbumTableData(
      albumId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      thumbnail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail'])!,
    );
  }

  @override
  $AlbumTableTable createAlias(String alias) {
    return $AlbumTableTable(attachedDatabase, alias);
  }
}

class AlbumTableData extends DataClass implements Insertable<AlbumTableData> {
  final String albumId;
  final String name;
  final String thumbnail;
  const AlbumTableData(
      {required this.albumId, required this.name, required this.thumbnail});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['album_id'] = Variable<String>(albumId);
    map['name'] = Variable<String>(name);
    map['thumbnail'] = Variable<String>(thumbnail);
    return map;
  }

  AlbumTableCompanion toCompanion(bool nullToAbsent) {
    return AlbumTableCompanion(
      albumId: Value(albumId),
      name: Value(name),
      thumbnail: Value(thumbnail),
    );
  }

  factory AlbumTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlbumTableData(
      albumId: serializer.fromJson<String>(json['albumId']),
      name: serializer.fromJson<String>(json['name']),
      thumbnail: serializer.fromJson<String>(json['thumbnail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'albumId': serializer.toJson<String>(albumId),
      'name': serializer.toJson<String>(name),
      'thumbnail': serializer.toJson<String>(thumbnail),
    };
  }

  AlbumTableData copyWith({String? albumId, String? name, String? thumbnail}) =>
      AlbumTableData(
        albumId: albumId ?? this.albumId,
        name: name ?? this.name,
        thumbnail: thumbnail ?? this.thumbnail,
      );
  AlbumTableData copyWithCompanion(AlbumTableCompanion data) {
    return AlbumTableData(
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      name: data.name.present ? data.name.value : this.name,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlbumTableData(')
          ..write('albumId: $albumId, ')
          ..write('name: $name, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(albumId, name, thumbnail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlbumTableData &&
          other.albumId == this.albumId &&
          other.name == this.name &&
          other.thumbnail == this.thumbnail);
}

class AlbumTableCompanion extends UpdateCompanion<AlbumTableData> {
  final Value<String> albumId;
  final Value<String> name;
  final Value<String> thumbnail;
  final Value<int> rowid;
  const AlbumTableCompanion({
    this.albumId = const Value.absent(),
    this.name = const Value.absent(),
    this.thumbnail = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumTableCompanion.insert({
    required String albumId,
    required String name,
    required String thumbnail,
    this.rowid = const Value.absent(),
  })  : albumId = Value(albumId),
        name = Value(name),
        thumbnail = Value(thumbnail);
  static Insertable<AlbumTableData> custom({
    Expression<String>? albumId,
    Expression<String>? name,
    Expression<String>? thumbnail,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (albumId != null) 'album_id': albumId,
      if (name != null) 'name': name,
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumTableCompanion copyWith(
      {Value<String>? albumId,
      Value<String>? name,
      Value<String>? thumbnail,
      Value<int>? rowid}) {
    return AlbumTableCompanion(
      albumId: albumId ?? this.albumId,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumTableCompanion(')
          ..write('albumId: $albumId, ')
          ..write('name: $name, ')
          ..write('thumbnail: $thumbnail, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistTableTable extends PlaylistTable
    with TableInfo<$PlaylistTableTable, PlaylistTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistIdMeta =
      const VerificationMeta('artistId');
  @override
  late final GeneratedColumn<String> artistId = GeneratedColumn<String>(
      'artist_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES artist_table (artist_id)'));
  static const VerificationMeta _videoCountMeta =
      const VerificationMeta('videoCount');
  @override
  late final GeneratedColumn<int> videoCount = GeneratedColumn<int>(
      'video_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _smallThumbMeta =
      const VerificationMeta('smallThumb');
  @override
  late final GeneratedColumn<String> smallThumb = GeneratedColumn<String>(
      'small_thumb', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _largeThumbMeta =
      const VerificationMeta('largeThumb');
  @override
  late final GeneratedColumn<String> largeThumb = GeneratedColumn<String>(
      'large_thumb', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        playlistId,
        type,
        name,
        artistId,
        videoCount,
        smallThumb,
        largeThumb,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_table';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('video_count')) {
      context.handle(
          _videoCountMeta,
          videoCount.isAcceptableOrUnknown(
              data['video_count']!, _videoCountMeta));
    } else if (isInserting) {
      context.missing(_videoCountMeta);
    }
    if (data.containsKey('small_thumb')) {
      context.handle(
          _smallThumbMeta,
          smallThumb.isAcceptableOrUnknown(
              data['small_thumb']!, _smallThumbMeta));
    } else if (isInserting) {
      context.missing(_smallThumbMeta);
    }
    if (data.containsKey('large_thumb')) {
      context.handle(
          _largeThumbMeta,
          largeThumb.isAcceptableOrUnknown(
              data['large_thumb']!, _largeThumbMeta));
    } else if (isInserting) {
      context.missing(_largeThumbMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId};
  @override
  PlaylistTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistTableData(
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}playlist_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      artistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist_id'])!,
      videoCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}video_count'])!,
      smallThumb: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}small_thumb'])!,
      largeThumb: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}large_thumb'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PlaylistTableTable createAlias(String alias) {
    return $PlaylistTableTable(attachedDatabase, alias);
  }
}

class PlaylistTableData extends DataClass
    implements Insertable<PlaylistTableData> {
  final String playlistId;
  final String type;
  final String name;
  final String artistId;
  final int videoCount;
  final String smallThumb;
  final String largeThumb;
  final DateTime createdAt;
  const PlaylistTableData(
      {required this.playlistId,
      required this.type,
      required this.name,
      required this.artistId,
      required this.videoCount,
      required this.smallThumb,
      required this.largeThumb,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<String>(playlistId);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['artist_id'] = Variable<String>(artistId);
    map['video_count'] = Variable<int>(videoCount);
    map['small_thumb'] = Variable<String>(smallThumb);
    map['large_thumb'] = Variable<String>(largeThumb);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlaylistTableCompanion toCompanion(bool nullToAbsent) {
    return PlaylistTableCompanion(
      playlistId: Value(playlistId),
      type: Value(type),
      name: Value(name),
      artistId: Value(artistId),
      videoCount: Value(videoCount),
      smallThumb: Value(smallThumb),
      largeThumb: Value(largeThumb),
      createdAt: Value(createdAt),
    );
  }

  factory PlaylistTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistTableData(
      playlistId: serializer.fromJson<String>(json['playlistId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      artistId: serializer.fromJson<String>(json['artistId']),
      videoCount: serializer.fromJson<int>(json['videoCount']),
      smallThumb: serializer.fromJson<String>(json['smallThumb']),
      largeThumb: serializer.fromJson<String>(json['largeThumb']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<String>(playlistId),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'artistId': serializer.toJson<String>(artistId),
      'videoCount': serializer.toJson<int>(videoCount),
      'smallThumb': serializer.toJson<String>(smallThumb),
      'largeThumb': serializer.toJson<String>(largeThumb),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlaylistTableData copyWith(
          {String? playlistId,
          String? type,
          String? name,
          String? artistId,
          int? videoCount,
          String? smallThumb,
          String? largeThumb,
          DateTime? createdAt}) =>
      PlaylistTableData(
        playlistId: playlistId ?? this.playlistId,
        type: type ?? this.type,
        name: name ?? this.name,
        artistId: artistId ?? this.artistId,
        videoCount: videoCount ?? this.videoCount,
        smallThumb: smallThumb ?? this.smallThumb,
        largeThumb: largeThumb ?? this.largeThumb,
        createdAt: createdAt ?? this.createdAt,
      );
  PlaylistTableData copyWithCompanion(PlaylistTableCompanion data) {
    return PlaylistTableData(
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      videoCount:
          data.videoCount.present ? data.videoCount.value : this.videoCount,
      smallThumb:
          data.smallThumb.present ? data.smallThumb.value : this.smallThumb,
      largeThumb:
          data.largeThumb.present ? data.largeThumb.value : this.largeThumb,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTableData(')
          ..write('playlistId: $playlistId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('artistId: $artistId, ')
          ..write('videoCount: $videoCount, ')
          ..write('smallThumb: $smallThumb, ')
          ..write('largeThumb: $largeThumb, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, type, name, artistId, videoCount,
      smallThumb, largeThumb, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistTableData &&
          other.playlistId == this.playlistId &&
          other.type == this.type &&
          other.name == this.name &&
          other.artistId == this.artistId &&
          other.videoCount == this.videoCount &&
          other.smallThumb == this.smallThumb &&
          other.largeThumb == this.largeThumb &&
          other.createdAt == this.createdAt);
}

class PlaylistTableCompanion extends UpdateCompanion<PlaylistTableData> {
  final Value<String> playlistId;
  final Value<String> type;
  final Value<String> name;
  final Value<String> artistId;
  final Value<int> videoCount;
  final Value<String> smallThumb;
  final Value<String> largeThumb;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlaylistTableCompanion({
    this.playlistId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.artistId = const Value.absent(),
    this.videoCount = const Value.absent(),
    this.smallThumb = const Value.absent(),
    this.largeThumb = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistTableCompanion.insert({
    required String playlistId,
    required String type,
    required String name,
    required String artistId,
    required int videoCount,
    required String smallThumb,
    required String largeThumb,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : playlistId = Value(playlistId),
        type = Value(type),
        name = Value(name),
        artistId = Value(artistId),
        videoCount = Value(videoCount),
        smallThumb = Value(smallThumb),
        largeThumb = Value(largeThumb),
        createdAt = Value(createdAt);
  static Insertable<PlaylistTableData> custom({
    Expression<String>? playlistId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? artistId,
    Expression<int>? videoCount,
    Expression<String>? smallThumb,
    Expression<String>? largeThumb,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (artistId != null) 'artist_id': artistId,
      if (videoCount != null) 'video_count': videoCount,
      if (smallThumb != null) 'small_thumb': smallThumb,
      if (largeThumb != null) 'large_thumb': largeThumb,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistTableCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? type,
      Value<String>? name,
      Value<String>? artistId,
      Value<int>? videoCount,
      Value<String>? smallThumb,
      Value<String>? largeThumb,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PlaylistTableCompanion(
      playlistId: playlistId ?? this.playlistId,
      type: type ?? this.type,
      name: name ?? this.name,
      artistId: artistId ?? this.artistId,
      videoCount: videoCount ?? this.videoCount,
      smallThumb: smallThumb ?? this.smallThumb,
      largeThumb: largeThumb ?? this.largeThumb,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (videoCount.present) {
      map['video_count'] = Variable<int>(videoCount.value);
    }
    if (smallThumb.present) {
      map['small_thumb'] = Variable<String>(smallThumb.value);
    }
    if (largeThumb.present) {
      map['large_thumb'] = Variable<String>(largeThumb.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTableCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('artistId: $artistId, ')
          ..write('videoCount: $videoCount, ')
          ..write('smallThumb: $smallThumb, ')
          ..write('largeThumb: $largeThumb, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistTrackTableTable extends PlaylistTrackTable
    with TableInfo<$PlaylistTrackTableTable, PlaylistTrackTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistTrackTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES playlist_table (playlist_id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistIdMeta =
      const VerificationMeta('artistId');
  @override
  late final GeneratedColumn<String> artistId = GeneratedColumn<String>(
      'artist_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES artist_table (artist_id)'));
  static const VerificationMeta _albumIdMeta =
      const VerificationMeta('albumId');
  @override
  late final GeneratedColumn<String> albumId = GeneratedColumn<String>(
      'album_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES album_table (album_id)'));
  static const VerificationMeta _videoIdMeta =
      const VerificationMeta('videoId');
  @override
  late final GeneratedColumn<String> videoId = GeneratedColumn<String>(
      'video_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lengthMeta = const VerificationMeta('length');
  @override
  late final GeneratedColumn<String> length = GeneratedColumn<String>(
      'length', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, playlistId, title, artistId, albumId, videoId, length];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_track_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlaylistTrackTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist_id')) {
      context.handle(_artistIdMeta,
          artistId.isAcceptableOrUnknown(data['artist_id']!, _artistIdMeta));
    } else if (isInserting) {
      context.missing(_artistIdMeta);
    }
    if (data.containsKey('album_id')) {
      context.handle(_albumIdMeta,
          albumId.isAcceptableOrUnknown(data['album_id']!, _albumIdMeta));
    } else if (isInserting) {
      context.missing(_albumIdMeta);
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('length')) {
      context.handle(_lengthMeta,
          length.isAcceptableOrUnknown(data['length']!, _lengthMeta));
    } else if (isInserting) {
      context.missing(_lengthMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistTrackTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistTrackTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}playlist_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist_id'])!,
      albumId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album_id'])!,
      videoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video_id'])!,
      length: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}length'])!,
    );
  }

  @override
  $PlaylistTrackTableTable createAlias(String alias) {
    return $PlaylistTrackTableTable(attachedDatabase, alias);
  }
}

class PlaylistTrackTableData extends DataClass
    implements Insertable<PlaylistTrackTableData> {
  final int id;
  final String playlistId;
  final String title;
  final String artistId;
  final String albumId;
  final String videoId;
  final String length;
  const PlaylistTrackTableData(
      {required this.id,
      required this.playlistId,
      required this.title,
      required this.artistId,
      required this.albumId,
      required this.videoId,
      required this.length});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['playlist_id'] = Variable<String>(playlistId);
    map['title'] = Variable<String>(title);
    map['artist_id'] = Variable<String>(artistId);
    map['album_id'] = Variable<String>(albumId);
    map['video_id'] = Variable<String>(videoId);
    map['length'] = Variable<String>(length);
    return map;
  }

  PlaylistTrackTableCompanion toCompanion(bool nullToAbsent) {
    return PlaylistTrackTableCompanion(
      id: Value(id),
      playlistId: Value(playlistId),
      title: Value(title),
      artistId: Value(artistId),
      albumId: Value(albumId),
      videoId: Value(videoId),
      length: Value(length),
    );
  }

  factory PlaylistTrackTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistTrackTableData(
      id: serializer.fromJson<int>(json['id']),
      playlistId: serializer.fromJson<String>(json['playlistId']),
      title: serializer.fromJson<String>(json['title']),
      artistId: serializer.fromJson<String>(json['artistId']),
      albumId: serializer.fromJson<String>(json['albumId']),
      videoId: serializer.fromJson<String>(json['videoId']),
      length: serializer.fromJson<String>(json['length']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playlistId': serializer.toJson<String>(playlistId),
      'title': serializer.toJson<String>(title),
      'artistId': serializer.toJson<String>(artistId),
      'albumId': serializer.toJson<String>(albumId),
      'videoId': serializer.toJson<String>(videoId),
      'length': serializer.toJson<String>(length),
    };
  }

  PlaylistTrackTableData copyWith(
          {int? id,
          String? playlistId,
          String? title,
          String? artistId,
          String? albumId,
          String? videoId,
          String? length}) =>
      PlaylistTrackTableData(
        id: id ?? this.id,
        playlistId: playlistId ?? this.playlistId,
        title: title ?? this.title,
        artistId: artistId ?? this.artistId,
        albumId: albumId ?? this.albumId,
        videoId: videoId ?? this.videoId,
        length: length ?? this.length,
      );
  PlaylistTrackTableData copyWithCompanion(PlaylistTrackTableCompanion data) {
    return PlaylistTrackTableData(
      id: data.id.present ? data.id.value : this.id,
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      title: data.title.present ? data.title.value : this.title,
      artistId: data.artistId.present ? data.artistId.value : this.artistId,
      albumId: data.albumId.present ? data.albumId.value : this.albumId,
      videoId: data.videoId.present ? data.videoId.value : this.videoId,
      length: data.length.present ? data.length.value : this.length,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTrackTableData(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('title: $title, ')
          ..write('artistId: $artistId, ')
          ..write('albumId: $albumId, ')
          ..write('videoId: $videoId, ')
          ..write('length: $length')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, playlistId, title, artistId, albumId, videoId, length);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistTrackTableData &&
          other.id == this.id &&
          other.playlistId == this.playlistId &&
          other.title == this.title &&
          other.artistId == this.artistId &&
          other.albumId == this.albumId &&
          other.videoId == this.videoId &&
          other.length == this.length);
}

class PlaylistTrackTableCompanion
    extends UpdateCompanion<PlaylistTrackTableData> {
  final Value<int> id;
  final Value<String> playlistId;
  final Value<String> title;
  final Value<String> artistId;
  final Value<String> albumId;
  final Value<String> videoId;
  final Value<String> length;
  const PlaylistTrackTableCompanion({
    this.id = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.title = const Value.absent(),
    this.artistId = const Value.absent(),
    this.albumId = const Value.absent(),
    this.videoId = const Value.absent(),
    this.length = const Value.absent(),
  });
  PlaylistTrackTableCompanion.insert({
    this.id = const Value.absent(),
    required String playlistId,
    required String title,
    required String artistId,
    required String albumId,
    required String videoId,
    required String length,
  })  : playlistId = Value(playlistId),
        title = Value(title),
        artistId = Value(artistId),
        albumId = Value(albumId),
        videoId = Value(videoId),
        length = Value(length);
  static Insertable<PlaylistTrackTableData> custom({
    Expression<int>? id,
    Expression<String>? playlistId,
    Expression<String>? title,
    Expression<String>? artistId,
    Expression<String>? albumId,
    Expression<String>? videoId,
    Expression<String>? length,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlistId != null) 'playlist_id': playlistId,
      if (title != null) 'title': title,
      if (artistId != null) 'artist_id': artistId,
      if (albumId != null) 'album_id': albumId,
      if (videoId != null) 'video_id': videoId,
      if (length != null) 'length': length,
    });
  }

  PlaylistTrackTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? playlistId,
      Value<String>? title,
      Value<String>? artistId,
      Value<String>? albumId,
      Value<String>? videoId,
      Value<String>? length}) {
    return PlaylistTrackTableCompanion(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      title: title ?? this.title,
      artistId: artistId ?? this.artistId,
      albumId: albumId ?? this.albumId,
      videoId: videoId ?? this.videoId,
      length: length ?? this.length,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artistId.present) {
      map['artist_id'] = Variable<String>(artistId.value);
    }
    if (albumId.present) {
      map['album_id'] = Variable<String>(albumId.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<String>(videoId.value);
    }
    if (length.present) {
      map['length'] = Variable<String>(length.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistTrackTableCompanion(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('title: $title, ')
          ..write('artistId: $artistId, ')
          ..write('albumId: $albumId, ')
          ..write('videoId: $videoId, ')
          ..write('length: $length')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ArtistTableTable artistTable = $ArtistTableTable(this);
  late final $AlbumTableTable albumTable = $AlbumTableTable(this);
  late final $PlaylistTableTable playlistTable = $PlaylistTableTable(this);
  late final $PlaylistTrackTableTable playlistTrackTable =
      $PlaylistTrackTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [artistTable, albumTable, playlistTable, playlistTrackTable];
}

typedef $$ArtistTableTableCreateCompanionBuilder = ArtistTableCompanion
    Function({
  required String artistId,
  required String name,
  required bool isValidId,
  Value<int> rowid,
});
typedef $$ArtistTableTableUpdateCompanionBuilder = ArtistTableCompanion
    Function({
  Value<String> artistId,
  Value<String> name,
  Value<bool> isValidId,
  Value<int> rowid,
});

final class $$ArtistTableTableReferences
    extends BaseReferences<_$AppDatabase, $ArtistTableTable, ArtistTableData> {
  $$ArtistTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaylistTableTable, List<PlaylistTableData>>
      _playlistTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.playlistTable,
              aliasName: $_aliasNameGenerator(
                  db.artistTable.artistId, db.playlistTable.artistId));

  $$PlaylistTableTableProcessedTableManager get playlistTableRefs {
    final manager = $$PlaylistTableTableTableManager($_db, $_db.playlistTable)
        .filter((f) => f.artistId.artistId($_item.artistId));

    final cache = $_typedResult.readTableOrNull(_playlistTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PlaylistTrackTableTable,
      List<PlaylistTrackTableData>> _playlistTrackTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.playlistTrackTable,
          aliasName: $_aliasNameGenerator(
              db.artistTable.artistId, db.playlistTrackTable.artistId));

  $$PlaylistTrackTableTableProcessedTableManager get playlistTrackTableRefs {
    final manager =
        $$PlaylistTrackTableTableTableManager($_db, $_db.playlistTrackTable)
            .filter((f) => f.artistId.artistId($_item.artistId));

    final cache =
        $_typedResult.readTableOrNull(_playlistTrackTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ArtistTableTableFilterComposer
    extends Composer<_$AppDatabase, $ArtistTableTable> {
  $$ArtistTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get artistId => $composableBuilder(
      column: $table.artistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isValidId => $composableBuilder(
      column: $table.isValidId, builder: (column) => ColumnFilters(column));

  Expression<bool> playlistTableRefs(
      Expression<bool> Function($$PlaylistTableTableFilterComposer f) f) {
    final $$PlaylistTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.playlistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTableTableFilterComposer(
              $db: $db,
              $table: $db.playlistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> playlistTrackTableRefs(
      Expression<bool> Function($$PlaylistTrackTableTableFilterComposer f) f) {
    final $$PlaylistTrackTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.playlistTrackTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTrackTableTableFilterComposer(
              $db: $db,
              $table: $db.playlistTrackTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ArtistTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ArtistTableTable> {
  $$ArtistTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get artistId => $composableBuilder(
      column: $table.artistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isValidId => $composableBuilder(
      column: $table.isValidId, builder: (column) => ColumnOrderings(column));
}

class $$ArtistTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArtistTableTable> {
  $$ArtistTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get artistId =>
      $composableBuilder(column: $table.artistId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isValidId =>
      $composableBuilder(column: $table.isValidId, builder: (column) => column);

  Expression<T> playlistTableRefs<T extends Object>(
      Expression<T> Function($$PlaylistTableTableAnnotationComposer a) f) {
    final $$PlaylistTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.playlistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTableTableAnnotationComposer(
              $db: $db,
              $table: $db.playlistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> playlistTrackTableRefs<T extends Object>(
      Expression<T> Function($$PlaylistTrackTableTableAnnotationComposer a) f) {
    final $$PlaylistTrackTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.artistId,
            referencedTable: $db.playlistTrackTable,
            getReferencedColumn: (t) => t.artistId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlaylistTrackTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playlistTrackTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ArtistTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ArtistTableTable,
    ArtistTableData,
    $$ArtistTableTableFilterComposer,
    $$ArtistTableTableOrderingComposer,
    $$ArtistTableTableAnnotationComposer,
    $$ArtistTableTableCreateCompanionBuilder,
    $$ArtistTableTableUpdateCompanionBuilder,
    (ArtistTableData, $$ArtistTableTableReferences),
    ArtistTableData,
    PrefetchHooks Function(
        {bool playlistTableRefs, bool playlistTrackTableRefs})> {
  $$ArtistTableTableTableManager(_$AppDatabase db, $ArtistTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArtistTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArtistTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArtistTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> artistId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<bool> isValidId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArtistTableCompanion(
            artistId: artistId,
            name: name,
            isValidId: isValidId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String artistId,
            required String name,
            required bool isValidId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ArtistTableCompanion.insert(
            artistId: artistId,
            name: name,
            isValidId: isValidId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ArtistTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {playlistTableRefs = false, playlistTrackTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playlistTableRefs) db.playlistTable,
                if (playlistTrackTableRefs) db.playlistTrackTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playlistTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ArtistTableTableReferences
                            ._playlistTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ArtistTableTableReferences(db, table, p0)
                                .playlistTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.artistId == item.artistId),
                        typedResults: items),
                  if (playlistTrackTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ArtistTableTableReferences
                            ._playlistTrackTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ArtistTableTableReferences(db, table, p0)
                                .playlistTrackTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.artistId == item.artistId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ArtistTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ArtistTableTable,
    ArtistTableData,
    $$ArtistTableTableFilterComposer,
    $$ArtistTableTableOrderingComposer,
    $$ArtistTableTableAnnotationComposer,
    $$ArtistTableTableCreateCompanionBuilder,
    $$ArtistTableTableUpdateCompanionBuilder,
    (ArtistTableData, $$ArtistTableTableReferences),
    ArtistTableData,
    PrefetchHooks Function(
        {bool playlistTableRefs, bool playlistTrackTableRefs})>;
typedef $$AlbumTableTableCreateCompanionBuilder = AlbumTableCompanion Function({
  required String albumId,
  required String name,
  required String thumbnail,
  Value<int> rowid,
});
typedef $$AlbumTableTableUpdateCompanionBuilder = AlbumTableCompanion Function({
  Value<String> albumId,
  Value<String> name,
  Value<String> thumbnail,
  Value<int> rowid,
});

final class $$AlbumTableTableReferences
    extends BaseReferences<_$AppDatabase, $AlbumTableTable, AlbumTableData> {
  $$AlbumTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaylistTrackTableTable,
      List<PlaylistTrackTableData>> _playlistTrackTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.playlistTrackTable,
          aliasName: $_aliasNameGenerator(
              db.albumTable.albumId, db.playlistTrackTable.albumId));

  $$PlaylistTrackTableTableProcessedTableManager get playlistTrackTableRefs {
    final manager =
        $$PlaylistTrackTableTableTableManager($_db, $_db.playlistTrackTable)
            .filter((f) => f.albumId.albumId($_item.albumId));

    final cache =
        $_typedResult.readTableOrNull(_playlistTrackTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AlbumTableTableFilterComposer
    extends Composer<_$AppDatabase, $AlbumTableTable> {
  $$AlbumTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get albumId => $composableBuilder(
      column: $table.albumId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnail => $composableBuilder(
      column: $table.thumbnail, builder: (column) => ColumnFilters(column));

  Expression<bool> playlistTrackTableRefs(
      Expression<bool> Function($$PlaylistTrackTableTableFilterComposer f) f) {
    final $$PlaylistTrackTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.playlistTrackTable,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTrackTableTableFilterComposer(
              $db: $db,
              $table: $db.playlistTrackTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AlbumTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AlbumTableTable> {
  $$AlbumTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get albumId => $composableBuilder(
      column: $table.albumId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnail => $composableBuilder(
      column: $table.thumbnail, builder: (column) => ColumnOrderings(column));
}

class $$AlbumTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlbumTableTable> {
  $$AlbumTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get albumId =>
      $composableBuilder(column: $table.albumId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  Expression<T> playlistTrackTableRefs<T extends Object>(
      Expression<T> Function($$PlaylistTrackTableTableAnnotationComposer a) f) {
    final $$PlaylistTrackTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.albumId,
            referencedTable: $db.playlistTrackTable,
            getReferencedColumn: (t) => t.albumId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlaylistTrackTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playlistTrackTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AlbumTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlbumTableTable,
    AlbumTableData,
    $$AlbumTableTableFilterComposer,
    $$AlbumTableTableOrderingComposer,
    $$AlbumTableTableAnnotationComposer,
    $$AlbumTableTableCreateCompanionBuilder,
    $$AlbumTableTableUpdateCompanionBuilder,
    (AlbumTableData, $$AlbumTableTableReferences),
    AlbumTableData,
    PrefetchHooks Function({bool playlistTrackTableRefs})> {
  $$AlbumTableTableTableManager(_$AppDatabase db, $AlbumTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> albumId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> thumbnail = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumTableCompanion(
            albumId: albumId,
            name: name,
            thumbnail: thumbnail,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String albumId,
            required String name,
            required String thumbnail,
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumTableCompanion.insert(
            albumId: albumId,
            name: name,
            thumbnail: thumbnail,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AlbumTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({playlistTrackTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playlistTrackTableRefs) db.playlistTrackTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playlistTrackTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$AlbumTableTableReferences
                            ._playlistTrackTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AlbumTableTableReferences(db, table, p0)
                                .playlistTrackTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.albumId == item.albumId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AlbumTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlbumTableTable,
    AlbumTableData,
    $$AlbumTableTableFilterComposer,
    $$AlbumTableTableOrderingComposer,
    $$AlbumTableTableAnnotationComposer,
    $$AlbumTableTableCreateCompanionBuilder,
    $$AlbumTableTableUpdateCompanionBuilder,
    (AlbumTableData, $$AlbumTableTableReferences),
    AlbumTableData,
    PrefetchHooks Function({bool playlistTrackTableRefs})>;
typedef $$PlaylistTableTableCreateCompanionBuilder = PlaylistTableCompanion
    Function({
  required String playlistId,
  required String type,
  required String name,
  required String artistId,
  required int videoCount,
  required String smallThumb,
  required String largeThumb,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PlaylistTableTableUpdateCompanionBuilder = PlaylistTableCompanion
    Function({
  Value<String> playlistId,
  Value<String> type,
  Value<String> name,
  Value<String> artistId,
  Value<int> videoCount,
  Value<String> smallThumb,
  Value<String> largeThumb,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$PlaylistTableTableReferences extends BaseReferences<_$AppDatabase,
    $PlaylistTableTable, PlaylistTableData> {
  $$PlaylistTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ArtistTableTable _artistIdTable(_$AppDatabase db) =>
      db.artistTable.createAlias($_aliasNameGenerator(
          db.playlistTable.artistId, db.artistTable.artistId));

  $$ArtistTableTableProcessedTableManager? get artistId {
    if ($_item.artistId == null) return null;
    final manager = $$ArtistTableTableTableManager($_db, $_db.artistTable)
        .filter((f) => f.artistId($_item.artistId!));
    final item = $_typedResult.readTableOrNull(_artistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PlaylistTrackTableTable,
      List<PlaylistTrackTableData>> _playlistTrackTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.playlistTrackTable,
          aliasName: $_aliasNameGenerator(
              db.playlistTable.playlistId, db.playlistTrackTable.playlistId));

  $$PlaylistTrackTableTableProcessedTableManager get playlistTrackTableRefs {
    final manager =
        $$PlaylistTrackTableTableTableManager($_db, $_db.playlistTrackTable)
            .filter((f) => f.playlistId.playlistId($_item.playlistId));

    final cache =
        $_typedResult.readTableOrNull(_playlistTrackTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlaylistTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistTableTable> {
  $$PlaylistTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get videoCount => $composableBuilder(
      column: $table.videoCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get smallThumb => $composableBuilder(
      column: $table.smallThumb, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get largeThumb => $composableBuilder(
      column: $table.largeThumb, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ArtistTableTableFilterComposer get artistId {
    final $$ArtistTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.artistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArtistTableTableFilterComposer(
              $db: $db,
              $table: $db.artistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> playlistTrackTableRefs(
      Expression<bool> Function($$PlaylistTrackTableTableFilterComposer f) f) {
    final $$PlaylistTrackTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $db.playlistTrackTable,
        getReferencedColumn: (t) => t.playlistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTrackTableTableFilterComposer(
              $db: $db,
              $table: $db.playlistTrackTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlaylistTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistTableTable> {
  $$PlaylistTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get videoCount => $composableBuilder(
      column: $table.videoCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get smallThumb => $composableBuilder(
      column: $table.smallThumb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get largeThumb => $composableBuilder(
      column: $table.largeThumb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ArtistTableTableOrderingComposer get artistId {
    final $$ArtistTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.artistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArtistTableTableOrderingComposer(
              $db: $db,
              $table: $db.artistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaylistTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistTableTable> {
  $$PlaylistTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get videoCount => $composableBuilder(
      column: $table.videoCount, builder: (column) => column);

  GeneratedColumn<String> get smallThumb => $composableBuilder(
      column: $table.smallThumb, builder: (column) => column);

  GeneratedColumn<String> get largeThumb => $composableBuilder(
      column: $table.largeThumb, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ArtistTableTableAnnotationComposer get artistId {
    final $$ArtistTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.artistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArtistTableTableAnnotationComposer(
              $db: $db,
              $table: $db.artistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> playlistTrackTableRefs<T extends Object>(
      Expression<T> Function($$PlaylistTrackTableTableAnnotationComposer a) f) {
    final $$PlaylistTrackTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.playlistId,
            referencedTable: $db.playlistTrackTable,
            getReferencedColumn: (t) => t.playlistId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlaylistTrackTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.playlistTrackTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlaylistTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistTableTable,
    PlaylistTableData,
    $$PlaylistTableTableFilterComposer,
    $$PlaylistTableTableOrderingComposer,
    $$PlaylistTableTableAnnotationComposer,
    $$PlaylistTableTableCreateCompanionBuilder,
    $$PlaylistTableTableUpdateCompanionBuilder,
    (PlaylistTableData, $$PlaylistTableTableReferences),
    PlaylistTableData,
    PrefetchHooks Function({bool artistId, bool playlistTrackTableRefs})> {
  $$PlaylistTableTableTableManager(_$AppDatabase db, $PlaylistTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> playlistId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> artistId = const Value.absent(),
            Value<int> videoCount = const Value.absent(),
            Value<String> smallThumb = const Value.absent(),
            Value<String> largeThumb = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistTableCompanion(
            playlistId: playlistId,
            type: type,
            name: name,
            artistId: artistId,
            videoCount: videoCount,
            smallThumb: smallThumb,
            largeThumb: largeThumb,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String playlistId,
            required String type,
            required String name,
            required String artistId,
            required int videoCount,
            required String smallThumb,
            required String largeThumb,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistTableCompanion.insert(
            playlistId: playlistId,
            type: type,
            name: name,
            artistId: artistId,
            videoCount: videoCount,
            smallThumb: smallThumb,
            largeThumb: largeThumb,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlaylistTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {artistId = false, playlistTrackTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playlistTrackTableRefs) db.playlistTrackTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (artistId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.artistId,
                    referencedTable:
                        $$PlaylistTableTableReferences._artistIdTable(db),
                    referencedColumn: $$PlaylistTableTableReferences
                        ._artistIdTable(db)
                        .artistId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playlistTrackTableRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlaylistTableTableReferences
                            ._playlistTrackTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlaylistTableTableReferences(db, table, p0)
                                .playlistTrackTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.playlistId == item.playlistId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlaylistTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaylistTableTable,
    PlaylistTableData,
    $$PlaylistTableTableFilterComposer,
    $$PlaylistTableTableOrderingComposer,
    $$PlaylistTableTableAnnotationComposer,
    $$PlaylistTableTableCreateCompanionBuilder,
    $$PlaylistTableTableUpdateCompanionBuilder,
    (PlaylistTableData, $$PlaylistTableTableReferences),
    PlaylistTableData,
    PrefetchHooks Function({bool artistId, bool playlistTrackTableRefs})>;
typedef $$PlaylistTrackTableTableCreateCompanionBuilder
    = PlaylistTrackTableCompanion Function({
  Value<int> id,
  required String playlistId,
  required String title,
  required String artistId,
  required String albumId,
  required String videoId,
  required String length,
});
typedef $$PlaylistTrackTableTableUpdateCompanionBuilder
    = PlaylistTrackTableCompanion Function({
  Value<int> id,
  Value<String> playlistId,
  Value<String> title,
  Value<String> artistId,
  Value<String> albumId,
  Value<String> videoId,
  Value<String> length,
});

final class $$PlaylistTrackTableTableReferences extends BaseReferences<
    _$AppDatabase, $PlaylistTrackTableTable, PlaylistTrackTableData> {
  $$PlaylistTrackTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlaylistTableTable _playlistIdTable(_$AppDatabase db) =>
      db.playlistTable.createAlias($_aliasNameGenerator(
          db.playlistTrackTable.playlistId, db.playlistTable.playlistId));

  $$PlaylistTableTableProcessedTableManager? get playlistId {
    if ($_item.playlistId == null) return null;
    final manager = $$PlaylistTableTableTableManager($_db, $_db.playlistTable)
        .filter((f) => f.playlistId($_item.playlistId!));
    final item = $_typedResult.readTableOrNull(_playlistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ArtistTableTable _artistIdTable(_$AppDatabase db) =>
      db.artistTable.createAlias($_aliasNameGenerator(
          db.playlistTrackTable.artistId, db.artistTable.artistId));

  $$ArtistTableTableProcessedTableManager? get artistId {
    if ($_item.artistId == null) return null;
    final manager = $$ArtistTableTableTableManager($_db, $_db.artistTable)
        .filter((f) => f.artistId($_item.artistId!));
    final item = $_typedResult.readTableOrNull(_artistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AlbumTableTable _albumIdTable(_$AppDatabase db) =>
      db.albumTable.createAlias($_aliasNameGenerator(
          db.playlistTrackTable.albumId, db.albumTable.albumId));

  $$AlbumTableTableProcessedTableManager? get albumId {
    if ($_item.albumId == null) return null;
    final manager = $$AlbumTableTableTableManager($_db, $_db.albumTable)
        .filter((f) => f.albumId($_item.albumId!));
    final item = $_typedResult.readTableOrNull(_albumIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlaylistTrackTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistTrackTableTable> {
  $$PlaylistTrackTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get videoId => $composableBuilder(
      column: $table.videoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get length => $composableBuilder(
      column: $table.length, builder: (column) => ColumnFilters(column));

  $$PlaylistTableTableFilterComposer get playlistId {
    final $$PlaylistTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $db.playlistTable,
        getReferencedColumn: (t) => t.playlistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTableTableFilterComposer(
              $db: $db,
              $table: $db.playlistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ArtistTableTableFilterComposer get artistId {
    final $$ArtistTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.artistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArtistTableTableFilterComposer(
              $db: $db,
              $table: $db.artistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AlbumTableTableFilterComposer get albumId {
    final $$AlbumTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.albumTable,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlbumTableTableFilterComposer(
              $db: $db,
              $table: $db.albumTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaylistTrackTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistTrackTableTable> {
  $$PlaylistTrackTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get videoId => $composableBuilder(
      column: $table.videoId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get length => $composableBuilder(
      column: $table.length, builder: (column) => ColumnOrderings(column));

  $$PlaylistTableTableOrderingComposer get playlistId {
    final $$PlaylistTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $db.playlistTable,
        getReferencedColumn: (t) => t.playlistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTableTableOrderingComposer(
              $db: $db,
              $table: $db.playlistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ArtistTableTableOrderingComposer get artistId {
    final $$ArtistTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.artistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArtistTableTableOrderingComposer(
              $db: $db,
              $table: $db.artistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AlbumTableTableOrderingComposer get albumId {
    final $$AlbumTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.albumTable,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlbumTableTableOrderingComposer(
              $db: $db,
              $table: $db.albumTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaylistTrackTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistTrackTableTable> {
  $$PlaylistTrackTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get videoId =>
      $composableBuilder(column: $table.videoId, builder: (column) => column);

  GeneratedColumn<String> get length =>
      $composableBuilder(column: $table.length, builder: (column) => column);

  $$PlaylistTableTableAnnotationComposer get playlistId {
    final $$PlaylistTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $db.playlistTable,
        getReferencedColumn: (t) => t.playlistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlaylistTableTableAnnotationComposer(
              $db: $db,
              $table: $db.playlistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ArtistTableTableAnnotationComposer get artistId {
    final $$ArtistTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.artistId,
        referencedTable: $db.artistTable,
        getReferencedColumn: (t) => t.artistId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArtistTableTableAnnotationComposer(
              $db: $db,
              $table: $db.artistTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AlbumTableTableAnnotationComposer get albumId {
    final $$AlbumTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.albumId,
        referencedTable: $db.albumTable,
        getReferencedColumn: (t) => t.albumId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AlbumTableTableAnnotationComposer(
              $db: $db,
              $table: $db.albumTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PlaylistTrackTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistTrackTableTable,
    PlaylistTrackTableData,
    $$PlaylistTrackTableTableFilterComposer,
    $$PlaylistTrackTableTableOrderingComposer,
    $$PlaylistTrackTableTableAnnotationComposer,
    $$PlaylistTrackTableTableCreateCompanionBuilder,
    $$PlaylistTrackTableTableUpdateCompanionBuilder,
    (PlaylistTrackTableData, $$PlaylistTrackTableTableReferences),
    PlaylistTrackTableData,
    PrefetchHooks Function({bool playlistId, bool artistId, bool albumId})> {
  $$PlaylistTrackTableTableTableManager(
      _$AppDatabase db, $PlaylistTrackTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistTrackTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistTrackTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistTrackTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> playlistId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artistId = const Value.absent(),
            Value<String> albumId = const Value.absent(),
            Value<String> videoId = const Value.absent(),
            Value<String> length = const Value.absent(),
          }) =>
              PlaylistTrackTableCompanion(
            id: id,
            playlistId: playlistId,
            title: title,
            artistId: artistId,
            albumId: albumId,
            videoId: videoId,
            length: length,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String playlistId,
            required String title,
            required String artistId,
            required String albumId,
            required String videoId,
            required String length,
          }) =>
              PlaylistTrackTableCompanion.insert(
            id: id,
            playlistId: playlistId,
            title: title,
            artistId: artistId,
            albumId: albumId,
            videoId: videoId,
            length: length,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlaylistTrackTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {playlistId = false, artistId = false, albumId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (playlistId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playlistId,
                    referencedTable: $$PlaylistTrackTableTableReferences
                        ._playlistIdTable(db),
                    referencedColumn: $$PlaylistTrackTableTableReferences
                        ._playlistIdTable(db)
                        .playlistId,
                  ) as T;
                }
                if (artistId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.artistId,
                    referencedTable:
                        $$PlaylistTrackTableTableReferences._artistIdTable(db),
                    referencedColumn: $$PlaylistTrackTableTableReferences
                        ._artistIdTable(db)
                        .artistId,
                  ) as T;
                }
                if (albumId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.albumId,
                    referencedTable:
                        $$PlaylistTrackTableTableReferences._albumIdTable(db),
                    referencedColumn: $$PlaylistTrackTableTableReferences
                        ._albumIdTable(db)
                        .albumId,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PlaylistTrackTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaylistTrackTableTable,
    PlaylistTrackTableData,
    $$PlaylistTrackTableTableFilterComposer,
    $$PlaylistTrackTableTableOrderingComposer,
    $$PlaylistTrackTableTableAnnotationComposer,
    $$PlaylistTrackTableTableCreateCompanionBuilder,
    $$PlaylistTrackTableTableUpdateCompanionBuilder,
    (PlaylistTrackTableData, $$PlaylistTrackTableTableReferences),
    PlaylistTrackTableData,
    PrefetchHooks Function({bool playlistId, bool artistId, bool albumId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ArtistTableTableTableManager get artistTable =>
      $$ArtistTableTableTableManager(_db, _db.artistTable);
  $$AlbumTableTableTableManager get albumTable =>
      $$AlbumTableTableTableManager(_db, _db.albumTable);
  $$PlaylistTableTableTableManager get playlistTable =>
      $$PlaylistTableTableTableManager(_db, _db.playlistTable);
  $$PlaylistTrackTableTableTableManager get playlistTrackTable =>
      $$PlaylistTrackTableTableTableManager(_db, _db.playlistTrackTable);
}
