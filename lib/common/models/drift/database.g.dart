// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AllSongsTable extends AllSongs with TableInfo<$AllSongsTable, AllSong> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllSongsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [title, artist, album];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'all_songs';
  @override
  VerificationContext validateIntegrity(Insertable<AllSong> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title, artist, album};
  @override
  AllSong map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllSong(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
    );
  }

  @override
  $AllSongsTable createAlias(String alias) {
    return $AllSongsTable(attachedDatabase, alias);
  }
}

class AllSong extends DataClass implements Insertable<AllSong> {
  final String title;
  final String artist;
  final String album;
  const AllSong(
      {required this.title, required this.artist, required this.album});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    return map;
  }

  AllSongsCompanion toCompanion(bool nullToAbsent) {
    return AllSongsCompanion(
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
    );
  }

  factory AllSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllSong(
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
    };
  }

  AllSong copyWith({String? title, String? artist, String? album}) => AllSong(
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
      );
  @override
  String toString() {
    return (StringBuffer('AllSong(')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, artist, album);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllSong &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album);
}

class AllSongsCompanion extends UpdateCompanion<AllSong> {
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<int> rowid;
  const AllSongsCompanion({
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AllSongsCompanion.insert({
    required String title,
    required String artist,
    required String album,
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        artist = Value(artist),
        album = Value(album);
  static Insertable<AllSong> custom({
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AllSongsCompanion copyWith(
      {Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<int>? rowid}) {
    return AllSongsCompanion(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllSongsCompanion(')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AllAudioSourcesTable extends AllAudioSources
    with TableInfo<$AllAudioSourcesTable, AllAudioSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllAudioSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, artist, album, sourceType, sourceId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'all_audio_sources';
  @override
  VerificationContext validateIntegrity(Insertable<AllAudioSource> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AllAudioSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllAudioSource(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
    );
  }

  @override
  $AllAudioSourcesTable createAlias(String alias) {
    return $AllAudioSourcesTable(attachedDatabase, alias);
  }
}

class AllAudioSource extends DataClass implements Insertable<AllAudioSource> {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String sourceType;
  final String sourceId;
  final int priority;
  const AllAudioSource(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.sourceType,
      required this.sourceId,
      required this.priority});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  AllAudioSourcesCompanion toCompanion(bool nullToAbsent) {
    return AllAudioSourcesCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      priority: Value(priority),
    );
  }

  factory AllAudioSource.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllAudioSource(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  AllAudioSource copyWith(
          {int? id,
          String? title,
          String? artist,
          String? album,
          String? sourceType,
          String? sourceId,
          int? priority}) =>
      AllAudioSource(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        priority: priority ?? this.priority,
      );
  @override
  String toString() {
    return (StringBuffer('AllAudioSource(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, artist, album, sourceType, sourceId, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllAudioSource &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.priority == this.priority);
}

class AllAudioSourcesCompanion extends UpdateCompanion<AllAudioSource> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<int> priority;
  const AllAudioSourcesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.priority = const Value.absent(),
  });
  AllAudioSourcesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    required String album,
    required String sourceType,
    required String sourceId,
    required int priority,
  })  : title = Value(title),
        artist = Value(artist),
        album = Value(album),
        sourceType = Value(sourceType),
        sourceId = Value(sourceId),
        priority = Value(priority);
  static Insertable<AllAudioSource> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (priority != null) 'priority': priority,
    });
  }

  AllAudioSourcesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<String>? sourceType,
      Value<String>? sourceId,
      Value<int>? priority}) {
    return AllAudioSourcesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllAudioSourcesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $AllMusicInfosTable extends AllMusicInfos
    with TableInfo<$AllMusicInfosTable, AllMusicInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllMusicInfosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceTypeMeta =
      const VerificationMeta('sourceType');
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
      'source_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceIdMeta =
      const VerificationMeta('sourceId');
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
      'source_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, artist, album, sourceType, sourceId, priority];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'all_music_infos';
  @override
  VerificationContext validateIntegrity(Insertable<AllMusicInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
          _sourceTypeMeta,
          sourceType.isAcceptableOrUnknown(
              data['source_type']!, _sourceTypeMeta));
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(_sourceIdMeta,
          sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta));
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AllMusicInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AllMusicInfo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
      sourceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_type'])!,
      sourceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_id'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
    );
  }

  @override
  $AllMusicInfosTable createAlias(String alias) {
    return $AllMusicInfosTable(attachedDatabase, alias);
  }
}

class AllMusicInfo extends DataClass implements Insertable<AllMusicInfo> {
  final int id;
  final String title;
  final String artist;
  final String album;
  final String sourceType;
  final String sourceId;
  final int priority;
  const AllMusicInfo(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.sourceType,
      required this.sourceId,
      required this.priority});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    map['source_type'] = Variable<String>(sourceType);
    map['source_id'] = Variable<String>(sourceId);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  AllMusicInfosCompanion toCompanion(bool nullToAbsent) {
    return AllMusicInfosCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      priority: Value(priority),
    );
  }

  factory AllMusicInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AllMusicInfo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'sourceType': serializer.toJson<String>(sourceType),
      'sourceId': serializer.toJson<String>(sourceId),
      'priority': serializer.toJson<int>(priority),
    };
  }

  AllMusicInfo copyWith(
          {int? id,
          String? title,
          String? artist,
          String? album,
          String? sourceType,
          String? sourceId,
          int? priority}) =>
      AllMusicInfo(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        sourceType: sourceType ?? this.sourceType,
        sourceId: sourceId ?? this.sourceId,
        priority: priority ?? this.priority,
      );
  @override
  String toString() {
    return (StringBuffer('AllMusicInfo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, artist, album, sourceType, sourceId, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AllMusicInfo &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.priority == this.priority);
}

class AllMusicInfosCompanion extends UpdateCompanion<AllMusicInfo> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<String> sourceType;
  final Value<String> sourceId;
  final Value<int> priority;
  const AllMusicInfosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.priority = const Value.absent(),
  });
  AllMusicInfosCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    required String album,
    required String sourceType,
    required String sourceId,
    required int priority,
  })  : title = Value(title),
        artist = Value(artist),
        album = Value(album),
        sourceType = Value(sourceType),
        sourceId = Value(sourceId),
        priority = Value(priority);
  static Insertable<AllMusicInfo> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (priority != null) 'priority': priority,
    });
  }

  AllMusicInfosCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<String>? sourceType,
      Value<String>? sourceId,
      Value<int>? priority}) {
    return AllMusicInfosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllMusicInfosCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $CurrentPlaylistItemsTable extends CurrentPlaylistItems
    with TableInfo<$CurrentPlaylistItemsTable, CurrentPlaylistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrentPlaylistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, artist, album, orderId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'current_playlist_items';
  @override
  VerificationContext validateIntegrity(
      Insertable<CurrentPlaylistItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CurrentPlaylistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrentPlaylistItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
    );
  }

  @override
  $CurrentPlaylistItemsTable createAlias(String alias) {
    return $CurrentPlaylistItemsTable(attachedDatabase, alias);
  }
}

class CurrentPlaylistItem extends DataClass
    implements Insertable<CurrentPlaylistItem> {
  final int id;
  final String title;
  final String artist;
  final String album;
  final int orderId;
  const CurrentPlaylistItem(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.orderId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    map['order_id'] = Variable<int>(orderId);
    return map;
  }

  CurrentPlaylistItemsCompanion toCompanion(bool nullToAbsent) {
    return CurrentPlaylistItemsCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
      orderId: Value(orderId),
    );
  }

  factory CurrentPlaylistItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrentPlaylistItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      orderId: serializer.fromJson<int>(json['orderId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'orderId': serializer.toJson<int>(orderId),
    };
  }

  CurrentPlaylistItem copyWith(
          {int? id,
          String? title,
          String? artist,
          String? album,
          int? orderId}) =>
      CurrentPlaylistItem(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        orderId: orderId ?? this.orderId,
      );
  @override
  String toString() {
    return (StringBuffer('CurrentPlaylistItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('orderId: $orderId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, artist, album, orderId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrentPlaylistItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.orderId == this.orderId);
}

class CurrentPlaylistItemsCompanion
    extends UpdateCompanion<CurrentPlaylistItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<int> orderId;
  const CurrentPlaylistItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.orderId = const Value.absent(),
  });
  CurrentPlaylistItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    required String album,
    required int orderId,
  })  : title = Value(title),
        artist = Value(artist),
        album = Value(album),
        orderId = Value(orderId);
  static Insertable<CurrentPlaylistItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<int>? orderId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (orderId != null) 'order_id': orderId,
    });
  }

  CurrentPlaylistItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<int>? orderId}) {
    return CurrentPlaylistItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      orderId: orderId ?? this.orderId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrentPlaylistItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('orderId: $orderId')
          ..write(')'))
        .toString();
  }
}

class $SongSheetItemsTable extends SongSheetItems
    with TableInfo<$SongSheetItemsTable, SongSheetItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongSheetItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _playlistnameMeta =
      const VerificationMeta('playlistname');
  @override
  late final GeneratedColumn<String> playlistname = GeneratedColumn<String>(
      'playlistname', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, artist, album, orderId, playlistname];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'song_sheet_items';
  @override
  VerificationContext validateIntegrity(Insertable<SongSheetItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('playlistname')) {
      context.handle(
          _playlistnameMeta,
          playlistname.isAcceptableOrUnknown(
              data['playlistname']!, _playlistnameMeta));
    } else if (isInserting) {
      context.missing(_playlistnameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SongSheetItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SongSheetItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      playlistname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}playlistname'])!,
    );
  }

  @override
  $SongSheetItemsTable createAlias(String alias) {
    return $SongSheetItemsTable(attachedDatabase, alias);
  }
}

class SongSheetItem extends DataClass implements Insertable<SongSheetItem> {
  final int id;
  final String title;
  final String artist;
  final String album;
  final int orderId;
  final String playlistname;
  const SongSheetItem(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.orderId,
      required this.playlistname});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    map['order_id'] = Variable<int>(orderId);
    map['playlistname'] = Variable<String>(playlistname);
    return map;
  }

  SongSheetItemsCompanion toCompanion(bool nullToAbsent) {
    return SongSheetItemsCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
      orderId: Value(orderId),
      playlistname: Value(playlistname),
    );
  }

  factory SongSheetItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SongSheetItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      orderId: serializer.fromJson<int>(json['orderId']),
      playlistname: serializer.fromJson<String>(json['playlistname']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'orderId': serializer.toJson<int>(orderId),
      'playlistname': serializer.toJson<String>(playlistname),
    };
  }

  SongSheetItem copyWith(
          {int? id,
          String? title,
          String? artist,
          String? album,
          int? orderId,
          String? playlistname}) =>
      SongSheetItem(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        orderId: orderId ?? this.orderId,
        playlistname: playlistname ?? this.playlistname,
      );
  @override
  String toString() {
    return (StringBuffer('SongSheetItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('orderId: $orderId, ')
          ..write('playlistname: $playlistname')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, artist, album, orderId, playlistname);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SongSheetItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.orderId == this.orderId &&
          other.playlistname == this.playlistname);
}

class SongSheetItemsCompanion extends UpdateCompanion<SongSheetItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<int> orderId;
  final Value<String> playlistname;
  const SongSheetItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.orderId = const Value.absent(),
    this.playlistname = const Value.absent(),
  });
  SongSheetItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String artist,
    required String album,
    required int orderId,
    required String playlistname,
  })  : title = Value(title),
        artist = Value(artist),
        album = Value(album),
        orderId = Value(orderId),
        playlistname = Value(playlistname);
  static Insertable<SongSheetItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<int>? orderId,
    Expression<String>? playlistname,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (orderId != null) 'order_id': orderId,
      if (playlistname != null) 'playlistname': playlistname,
    });
  }

  SongSheetItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<int>? orderId,
      Value<String>? playlistname}) {
    return SongSheetItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      orderId: orderId ?? this.orderId,
      playlistname: playlistname ?? this.playlistname,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (playlistname.present) {
      map['playlistname'] = Variable<String>(playlistname.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongSheetItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('orderId: $orderId, ')
          ..write('playlistname: $playlistname')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $AllSongsTable allSongs = $AllSongsTable(this);
  late final $AllAudioSourcesTable allAudioSources =
      $AllAudioSourcesTable(this);
  late final $AllMusicInfosTable allMusicInfos = $AllMusicInfosTable(this);
  late final $CurrentPlaylistItemsTable currentPlaylistItems =
      $CurrentPlaylistItemsTable(this);
  late final $SongSheetItemsTable songSheetItems = $SongSheetItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        allSongs,
        allAudioSources,
        allMusicInfos,
        currentPlaylistItems,
        songSheetItems
      ];
}

typedef $$AllSongsTableInsertCompanionBuilder = AllSongsCompanion Function({
  required String title,
  required String artist,
  required String album,
  Value<int> rowid,
});
typedef $$AllSongsTableUpdateCompanionBuilder = AllSongsCompanion Function({
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<int> rowid,
});

class $$AllSongsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AllSongsTable,
    AllSong,
    $$AllSongsTableFilterComposer,
    $$AllSongsTableOrderingComposer,
    $$AllSongsTableProcessedTableManager,
    $$AllSongsTableInsertCompanionBuilder,
    $$AllSongsTableUpdateCompanionBuilder> {
  $$AllSongsTableTableManager(_$AppDatabase db, $AllSongsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AllSongsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AllSongsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AllSongsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AllSongsCompanion(
            title: title,
            artist: artist,
            album: album,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String title,
            required String artist,
            required String album,
            Value<int> rowid = const Value.absent(),
          }) =>
              AllSongsCompanion.insert(
            title: title,
            artist: artist,
            album: album,
            rowid: rowid,
          ),
        ));
}

class $$AllSongsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AllSongsTable,
    AllSong,
    $$AllSongsTableFilterComposer,
    $$AllSongsTableOrderingComposer,
    $$AllSongsTableProcessedTableManager,
    $$AllSongsTableInsertCompanionBuilder,
    $$AllSongsTableUpdateCompanionBuilder> {
  $$AllSongsTableProcessedTableManager(super.$state);
}

class $$AllSongsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AllSongsTable> {
  $$AllSongsTableFilterComposer(super.$state);
  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AllSongsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AllSongsTable> {
  $$AllSongsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AllAudioSourcesTableInsertCompanionBuilder = AllAudioSourcesCompanion
    Function({
  Value<int> id,
  required String title,
  required String artist,
  required String album,
  required String sourceType,
  required String sourceId,
  required int priority,
});
typedef $$AllAudioSourcesTableUpdateCompanionBuilder = AllAudioSourcesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<String> sourceType,
  Value<String> sourceId,
  Value<int> priority,
});

class $$AllAudioSourcesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AllAudioSourcesTable,
    AllAudioSource,
    $$AllAudioSourcesTableFilterComposer,
    $$AllAudioSourcesTableOrderingComposer,
    $$AllAudioSourcesTableProcessedTableManager,
    $$AllAudioSourcesTableInsertCompanionBuilder,
    $$AllAudioSourcesTableUpdateCompanionBuilder> {
  $$AllAudioSourcesTableTableManager(
      _$AppDatabase db, $AllAudioSourcesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AllAudioSourcesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AllAudioSourcesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AllAudioSourcesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<int> priority = const Value.absent(),
          }) =>
              AllAudioSourcesCompanion(
            id: id,
            title: title,
            artist: artist,
            album: album,
            sourceType: sourceType,
            sourceId: sourceId,
            priority: priority,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String artist,
            required String album,
            required String sourceType,
            required String sourceId,
            required int priority,
          }) =>
              AllAudioSourcesCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            album: album,
            sourceType: sourceType,
            sourceId: sourceId,
            priority: priority,
          ),
        ));
}

class $$AllAudioSourcesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AllAudioSourcesTable,
    AllAudioSource,
    $$AllAudioSourcesTableFilterComposer,
    $$AllAudioSourcesTableOrderingComposer,
    $$AllAudioSourcesTableProcessedTableManager,
    $$AllAudioSourcesTableInsertCompanionBuilder,
    $$AllAudioSourcesTableUpdateCompanionBuilder> {
  $$AllAudioSourcesTableProcessedTableManager(super.$state);
}

class $$AllAudioSourcesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AllAudioSourcesTable> {
  $$AllAudioSourcesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceType => $state.composableBuilder(
      column: $state.table.sourceType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceId => $state.composableBuilder(
      column: $state.table.sourceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AllAudioSourcesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AllAudioSourcesTable> {
  $$AllAudioSourcesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceType => $state.composableBuilder(
      column: $state.table.sourceType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceId => $state.composableBuilder(
      column: $state.table.sourceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AllMusicInfosTableInsertCompanionBuilder = AllMusicInfosCompanion
    Function({
  Value<int> id,
  required String title,
  required String artist,
  required String album,
  required String sourceType,
  required String sourceId,
  required int priority,
});
typedef $$AllMusicInfosTableUpdateCompanionBuilder = AllMusicInfosCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<String> sourceType,
  Value<String> sourceId,
  Value<int> priority,
});

class $$AllMusicInfosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AllMusicInfosTable,
    AllMusicInfo,
    $$AllMusicInfosTableFilterComposer,
    $$AllMusicInfosTableOrderingComposer,
    $$AllMusicInfosTableProcessedTableManager,
    $$AllMusicInfosTableInsertCompanionBuilder,
    $$AllMusicInfosTableUpdateCompanionBuilder> {
  $$AllMusicInfosTableTableManager(_$AppDatabase db, $AllMusicInfosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AllMusicInfosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AllMusicInfosTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$AllMusicInfosTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<String> sourceType = const Value.absent(),
            Value<String> sourceId = const Value.absent(),
            Value<int> priority = const Value.absent(),
          }) =>
              AllMusicInfosCompanion(
            id: id,
            title: title,
            artist: artist,
            album: album,
            sourceType: sourceType,
            sourceId: sourceId,
            priority: priority,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String artist,
            required String album,
            required String sourceType,
            required String sourceId,
            required int priority,
          }) =>
              AllMusicInfosCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            album: album,
            sourceType: sourceType,
            sourceId: sourceId,
            priority: priority,
          ),
        ));
}

class $$AllMusicInfosTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AllMusicInfosTable,
    AllMusicInfo,
    $$AllMusicInfosTableFilterComposer,
    $$AllMusicInfosTableOrderingComposer,
    $$AllMusicInfosTableProcessedTableManager,
    $$AllMusicInfosTableInsertCompanionBuilder,
    $$AllMusicInfosTableUpdateCompanionBuilder> {
  $$AllMusicInfosTableProcessedTableManager(super.$state);
}

class $$AllMusicInfosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AllMusicInfosTable> {
  $$AllMusicInfosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceType => $state.composableBuilder(
      column: $state.table.sourceType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sourceId => $state.composableBuilder(
      column: $state.table.sourceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AllMusicInfosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AllMusicInfosTable> {
  $$AllMusicInfosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceType => $state.composableBuilder(
      column: $state.table.sourceType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sourceId => $state.composableBuilder(
      column: $state.table.sourceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get priority => $state.composableBuilder(
      column: $state.table.priority,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CurrentPlaylistItemsTableInsertCompanionBuilder
    = CurrentPlaylistItemsCompanion Function({
  Value<int> id,
  required String title,
  required String artist,
  required String album,
  required int orderId,
});
typedef $$CurrentPlaylistItemsTableUpdateCompanionBuilder
    = CurrentPlaylistItemsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<int> orderId,
});

class $$CurrentPlaylistItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CurrentPlaylistItemsTable,
    CurrentPlaylistItem,
    $$CurrentPlaylistItemsTableFilterComposer,
    $$CurrentPlaylistItemsTableOrderingComposer,
    $$CurrentPlaylistItemsTableProcessedTableManager,
    $$CurrentPlaylistItemsTableInsertCompanionBuilder,
    $$CurrentPlaylistItemsTableUpdateCompanionBuilder> {
  $$CurrentPlaylistItemsTableTableManager(
      _$AppDatabase db, $CurrentPlaylistItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$CurrentPlaylistItemsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$CurrentPlaylistItemsTableOrderingComposer(
              ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$CurrentPlaylistItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<int> orderId = const Value.absent(),
          }) =>
              CurrentPlaylistItemsCompanion(
            id: id,
            title: title,
            artist: artist,
            album: album,
            orderId: orderId,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String artist,
            required String album,
            required int orderId,
          }) =>
              CurrentPlaylistItemsCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            album: album,
            orderId: orderId,
          ),
        ));
}

class $$CurrentPlaylistItemsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $CurrentPlaylistItemsTable,
        CurrentPlaylistItem,
        $$CurrentPlaylistItemsTableFilterComposer,
        $$CurrentPlaylistItemsTableOrderingComposer,
        $$CurrentPlaylistItemsTableProcessedTableManager,
        $$CurrentPlaylistItemsTableInsertCompanionBuilder,
        $$CurrentPlaylistItemsTableUpdateCompanionBuilder> {
  $$CurrentPlaylistItemsTableProcessedTableManager(super.$state);
}

class $$CurrentPlaylistItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CurrentPlaylistItemsTable> {
  $$CurrentPlaylistItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CurrentPlaylistItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CurrentPlaylistItemsTable> {
  $$CurrentPlaylistItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SongSheetItemsTableInsertCompanionBuilder = SongSheetItemsCompanion
    Function({
  Value<int> id,
  required String title,
  required String artist,
  required String album,
  required int orderId,
  required String playlistname,
});
typedef $$SongSheetItemsTableUpdateCompanionBuilder = SongSheetItemsCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<int> orderId,
  Value<String> playlistname,
});

class $$SongSheetItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SongSheetItemsTable,
    SongSheetItem,
    $$SongSheetItemsTableFilterComposer,
    $$SongSheetItemsTableOrderingComposer,
    $$SongSheetItemsTableProcessedTableManager,
    $$SongSheetItemsTableInsertCompanionBuilder,
    $$SongSheetItemsTableUpdateCompanionBuilder> {
  $$SongSheetItemsTableTableManager(
      _$AppDatabase db, $SongSheetItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SongSheetItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SongSheetItemsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SongSheetItemsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<String> playlistname = const Value.absent(),
          }) =>
              SongSheetItemsCompanion(
            id: id,
            title: title,
            artist: artist,
            album: album,
            orderId: orderId,
            playlistname: playlistname,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String artist,
            required String album,
            required int orderId,
            required String playlistname,
          }) =>
              SongSheetItemsCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            album: album,
            orderId: orderId,
            playlistname: playlistname,
          ),
        ));
}

class $$SongSheetItemsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $SongSheetItemsTable,
    SongSheetItem,
    $$SongSheetItemsTableFilterComposer,
    $$SongSheetItemsTableOrderingComposer,
    $$SongSheetItemsTableProcessedTableManager,
    $$SongSheetItemsTableInsertCompanionBuilder,
    $$SongSheetItemsTableUpdateCompanionBuilder> {
  $$SongSheetItemsTableProcessedTableManager(super.$state);
}

class $$SongSheetItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SongSheetItemsTable> {
  $$SongSheetItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get playlistname => $state.composableBuilder(
      column: $state.table.playlistname,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SongSheetItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SongSheetItemsTable> {
  $$SongSheetItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get artist => $state.composableBuilder(
      column: $state.table.artist,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get album => $state.composableBuilder(
      column: $state.table.album,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get orderId => $state.composableBuilder(
      column: $state.table.orderId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get playlistname => $state.composableBuilder(
      column: $state.table.playlistname,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$AllSongsTableTableManager get allSongs =>
      $$AllSongsTableTableManager(_db, _db.allSongs);
  $$AllAudioSourcesTableTableManager get allAudioSources =>
      $$AllAudioSourcesTableTableManager(_db, _db.allAudioSources);
  $$AllMusicInfosTableTableManager get allMusicInfos =>
      $$AllMusicInfosTableTableManager(_db, _db.allMusicInfos);
  $$CurrentPlaylistItemsTableTableManager get currentPlaylistItems =>
      $$CurrentPlaylistItemsTableTableManager(_db, _db.currentPlaylistItems);
  $$SongSheetItemsTableTableManager get songSheetItems =>
      $$SongSheetItemsTableTableManager(_db, _db.songSheetItems);
}
