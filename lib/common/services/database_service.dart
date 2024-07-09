import 'dart:io';

import 'package:drift/drift.dart' as drift;
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../api/index.dart';
import '../models/index.dart';

class DatabaseService extends GetxService {
  final database = AppDatabase();
  late Box box;
  static DatabaseService get to => Get.find<DatabaseService>();
  static AppDatabase get db => Get.find<DatabaseService>().database;
  Future<DatabaseService> init() async {
    super.onInit();
    var dbFolder = await getApplicationDocumentsDirectory();
    if (Platform.isWindows) {
      var executablePath = Platform.resolvedExecutable;
      var executableDir = dirname(executablePath);
      dbFolder = Directory(executableDir);
    }
    box = await Hive.openBox('state', path: dbFolder.path);
    return this;
  }

  int get currentPlayListItemIndex =>
      box.get('currentPlayListItemIndex', defaultValue: 0);
  set currentPlayListItemIndex(int value) =>
      box.put('currentPlayListItemIndex', value);

  Future<bool> add2AllSong(BasicMusicInfo song) async {
    var res = await database.managers.allSongs
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .getSingleOrNull();
    if (res != null) {
      return false;
    }
    await database.managers.allSongs.create(
        (o) => o(album: song.album, artist: song.artist, title: song.title));
    return true;
  }

  Future<bool> removeFromAllSong(BasicMusicInfo song) async {
    var res = await database.managers.allSongs
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .getSingleOrNull();
    if (res == null) {
      return false;
    }
    await database.managers.allSongs
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .delete();
    return true;
  }

  Future<bool> add2AudioSource(SongWithSource song) async {
    final basicInfo = song.basicInfo;
    var res = await database.managers.allSongs
        .filter((o) =>
            o.title.equals(basicInfo.title) &
            o.artist.equals(basicInfo.artist) &
            o.album.equals(basicInfo.album))
        .getSingleOrNull();
    if (res == null) {
      await database.managers.allSongs.create((o) => o(
          album: basicInfo.album,
          artist: basicInfo.artist,
          title: basicInfo.title));
    }
    var res2 = await database.managers.allAudioSources
        .filter((o) =>
            o.title.equals(basicInfo.title) &
            o.artist.equals(basicInfo.artist) &
            o.album.equals(basicInfo.album))
        .orderBy((o) => o.id.asc())
        .get();
    int priority = 0;
    if (res2.isNotEmpty) {
      priority = res2.last.priority + 1;
    }
    try {
      for (var item in song.audioSources) {
        database.managers.allAudioSources.create((o) => o(
            album: basicInfo.album,
            artist: basicInfo.artist,
            title: basicInfo.title,
            sourceType: item.sourceType,
            sourceId: item.sourceId,
            priority: priority));
        priority++;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> add2MusicInfo(SongWithSource song) async {
    final basicInfo = song.basicInfo;
    var res = await database.managers.allSongs
        .filter((o) =>
            o.title.equals(basicInfo.title) &
            o.artist.equals(basicInfo.artist) &
            o.album.equals(basicInfo.album))
        .getSingleOrNull();
    if (res == null) {
      await database.managers.allSongs.create((o) => o(
          album: basicInfo.album,
          artist: basicInfo.artist,
          title: basicInfo.title));
    }
    var res2 = await database.managers.allMusicInfos
        .filter((o) =>
            o.title.equals(basicInfo.title) &
            o.artist.equals(basicInfo.artist) &
            o.album.equals(basicInfo.album))
        .orderBy((o) => o.id.asc())
        .get();
    int priority = 0;
    if (res2.isNotEmpty) {
      priority = res2.last.priority + 1;
    }
    try {
      for (var item in song.musicInfos) {
        database.managers.allMusicInfos.create((o) => o(
            album: basicInfo.album,
            artist: basicInfo.artist,
            title: basicInfo.title,
            sourceType: item.sourceType,
            sourceId: item.sourceId,
            priority: priority));
        priority++;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> add2CurrentPlaylist(BasicMusicInfo song) async {
    var res = await database.managers.currentPlaylistItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .orderBy((o) => o.id.asc())
        .get();
    if (res.isNotEmpty) {
      return false;
    }
    int orderId = await database.managers.currentPlaylistItems.count();
    await database.managers.currentPlaylistItems.create((o) => o(
        album: song.album,
        artist: song.artist,
        title: song.title,
        orderId: orderId));
    return true;
  }

  Future<bool> add2CurrentPlaylistByIndex(
      BasicMusicInfo song, int index) async {
    var res = await database.managers.currentPlaylistItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .orderBy((o) => o.id.asc())
        .get();
    if (res.isNotEmpty) {
      return false;
    }
    var objs = await database.managers.currentPlaylistItems
        .filter((o) => o.orderId.isBiggerOrEqualTo(index))
        .get();
    objs = objs.map((e) => e.copyWith(orderId: e.orderId + 1)).toList();
    await database.managers.currentPlaylistItems.bulkReplace(objs);
    await database.managers.currentPlaylistItems.create((o) => o(
        album: song.album,
        artist: song.artist,
        title: song.title,
        orderId: index));
    return true;
  }

  Future<List<PlayableItem>> getCurrentPlaylist() async {
    List<PlayableItem> res = [];
    var data = await database.managers.currentPlaylistItems
        .orderBy((o) => o.orderId.asc())
        .get();
    for (var item in data) {
      var sources = await database.managers.allAudioSources
          .filter((o) =>
              o.title.equals(item.title) &
              o.artist.equals(item.artist) &
              o.album.equals(item.album))
          .orderBy((o) => o.priority.asc())
          .get();
      var infors = await database.managers.allMusicInfos
          .filter((o) =>
              o.title.equals(item.title) &
              o.artist.equals(item.artist) &
              o.album.equals(item.album))
          .orderBy((o) => o.priority.asc())
          .get();
      var musicSources = sources
          .map((e) => AudioSourceProvider(e.sourceType, e.sourceId))
          .toList();
      var musicInfos = infors
          .map((e) => MusicInfoProvider(e.sourceType, e.sourceId))
          .toList();
      res.add(PlayableItem(
        basicInfo: BasicMusicInfo(
            album: item.album, artist: item.artist, title: item.title),
        sources: musicSources,
        infos: musicInfos,
      ));
    }
    return res;
  }

  Future<void> removeCurrentPlaylistItem(BasicMusicInfo song) async {
    CurrentPlaylistItem? current = (await database.managers.currentPlaylistItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .getSingleOrNull());
    if (current == null) return;
    var objs = await database.managers.currentPlaylistItems
        .filter((o) => o.orderId.isBiggerThan(current.orderId))
        .get();
    objs = objs.map((e) => e.copyWith(orderId: e.orderId - 1)).toList();
    await database.managers.currentPlaylistItems.bulkReplace(objs);
    await database.managers.currentPlaylistItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .delete();
  }

  Future<bool> likeOrUnlike(BasicMusicInfo song) async {
    var res = await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals("我喜欢的音乐"))
        .getSingleOrNull();
    if (res != null) {
      var objs = await database.managers.songSheetItems
          .filter((o) => o.orderId.isBiggerThan(res.orderId))
          .get();
      objs = objs.map((e) => e.copyWith(orderId: e.orderId - 1)).toList();
      await database.managers.songSheetItems.bulkReplace(objs);
      await database.managers.songSheetItems
          .filter((o) =>
              o.title.equals(song.title) &
              o.artist.equals(song.artist) &
              o.album.equals(song.album))
          .delete();
      return false;
    }
    int orderId = await database.managers.songSheetItems.count();
    await database.managers.songSheetItems.create((o) => o(
        album: song.album,
        artist: song.artist,
        title: song.title,
        orderId: orderId,
        playlistname: "我喜欢的音乐"));
    return true;
  }

  Future<bool> add2SongSheet(BasicMusicInfo song, String songSheetName) async {
    var res = await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals(songSheetName))
        .getSingleOrNull();
    if (res != null) {
      return false;
    }
    int orderId = await database.managers.songSheetItems.count();
    await database.managers.songSheetItems.create((o) => o(
        album: song.album,
        artist: song.artist,
        title: song.title,
        orderId: orderId,
        playlistname: songSheetName));
    return true;
  }

  Future<void> removeSongSheetItem(
      BasicMusicInfo song, String songSheetName) async {
    var res = await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals(songSheetName))
        .getSingleOrNull();
    if (res == null) return;
    var objs = await database.managers.songSheetItems
        .filter((o) => o.orderId.isBiggerThan(res.orderId))
        .get();
    objs = objs.map((e) => e.copyWith(orderId: e.orderId - 1)).toList();
    await database.managers.songSheetItems.bulkReplace(objs);
    await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals(songSheetName))
        .delete();
  }

  Future<bool> isLike(BasicMusicInfo song) async {
    var res = await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals("我喜欢的音乐"))
        .getSingleOrNull();
    return res != null;
  }

  Future<List<SongSheet>> getSongSheets() async {
    var subQuery = database.songSheetItems.selectOnly()
      ..join([])
      ..addColumns([database.songSheetItems.id.max()])
      ..groupBy([database.songSheetItems.playlistname]);
    var query = database.select(database.songSheetItems)
      ..where((tbl) {
        return tbl.id.isInQuery(subQuery);
      });
    var res = await query.get();
    List<SongSheet> songSheets = [];
    for (var item in res) {
      if (item.playlistname == "我喜欢的音乐") continue;
      var info = await database.managers.allAudioSources
          .filter((o) =>
              o.title.equals(item.title) &
              o.artist.equals(item.artist) &
              o.album.equals(item.album))
          .getSingleOrNull();
      var musicInfo = MusicInfoProvider(info!.sourceType, info.sourceId);
      var song = SongSheet(name: item.playlistname, newInfo: musicInfo);
      songSheets.add(song);
    }
    return songSheets;
  }

  Future<bool> newSongSheet(BasicMusicInfo song, String songSheetName) async {
    await add2AllSong(song);
    var res = await database.managers.allMusicInfos
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .getSingleOrNull();
    if (res == null) {
      return false;
    }
    var res2 = await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals(songSheetName))
        .getSingleOrNull();
    if (res2 != null) {
      return false;
    }
    int orderId = await database.managers.songSheetItems.count();
    await database.managers.songSheetItems.create((o) => o(
        album: song.album,
        artist: song.artist,
        title: song.title,
        orderId: orderId,
        playlistname: songSheetName));
    return true;
  }

  Future<List<BasicMusicInfo>> getSongSheetItems(String songSheetName) async {
    if (songSheetName == "所有歌曲") {
      var res = await database.managers.allSongs.get();
      return res
          .map((e) =>
              BasicMusicInfo(album: e.album, artist: e.artist, title: e.title))
          .toList();
    }
    var res = await database.managers.songSheetItems
        .filter((o) => o.playlistname.equals(songSheetName))
        .orderBy((o) => o.orderId.asc())
        .get();
    return res
        .map((e) =>
            BasicMusicInfo(album: e.album, artist: e.artist, title: e.title))
        .toList();
  }

  Future<ExtendMusicInfo?> getSongInfo(BasicMusicInfo info) async {
    var res = await database.managers.allMusicInfos
        .filter((o) =>
            o.title.equals(info.title) &
            o.artist.equals(info.artist) &
            o.album.equals(info.album))
        .get();
    if (res.isEmpty) {
      return null;
    }
    return MusicInfoProvider(res[0].sourceType, res[0].sourceId).getMusicInfo();
  }

  Future<bool> changeCurrentPlaylist(List<BasicMusicInfo> songs) async {
    await database.managers.currentPlaylistItems.delete();
    for (var song in songs) {
      await database.managers.currentPlaylistItems.create((o) => o(
          album: song.album,
          artist: song.artist,
          title: song.title,
          orderId: songs.indexOf(song)));
    }
    return true;
  }

  Future<bool> deleteItemFromSongSheet(
      BasicMusicInfo song, String songSheetName) async {
    var res = await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals(songSheetName))
        .getSingleOrNull();
    if (res == null) return false;
    var objs = await database.managers.songSheetItems
        .filter((o) => o.orderId.isBiggerThan(res.orderId))
        .get();
    objs = objs.map((e) => e.copyWith(orderId: e.orderId - 1)).toList();
    await database.managers.songSheetItems.bulkReplace(objs);
    await database.managers.songSheetItems
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album) &
            o.playlistname.equals(songSheetName))
        .delete();
    return true;
  }

  Future<bool> changeSongInfo(
      BasicMusicInfo song, BasicMusicInfo newInfo) async {
    var res = await database.managers.allSongs
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .getSingleOrNull();
    if (res == null) return false;
    await database.managers.allSongs
        .filter((o) =>
            o.title.equals(song.title) &
            o.artist.equals(song.artist) &
            o.album.equals(song.album))
        .update((o) => o(
            album: drift.Value(newInfo.album),
            artist: drift.Value(newInfo.artist),
            title: drift.Value(newInfo.title)));
    return true;
  }
}
