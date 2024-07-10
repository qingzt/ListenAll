import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/common/api/search/netease.dart';
import 'package:listenall/common/models/index.dart';
import 'package:listenall/common/models/source_item.dart';
import 'package:listenall/common/services/index.dart';
import 'package:listenall/common/widgets/snack_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/api/index.dart';

class EditMusicInfoController extends GetxController {
  EditMusicInfoController({this.oldSongWithSource});
  SongWithSource? oldSongWithSource;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController albumController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  int currentSourceIndex = 0;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final List<SearchProvider> allSources = [
    NeteaseSearchProvider(),
    BilibiliSearchProvider(),
  ];

  String? title;
  String? artist;
  String? album;
  List<SourceItem> audioSources = [];
  List<SourceItem> musicInfos = [];
  List<SongWithSource> searchResult = [];
  int page = 1;

  _initData() {
    update();
  }

  Future<bool> save() async {
    final basicInfo = BasicMusicInfo(
      title: titleController.text,
      artist: artistController.text,
      album: albumController.text,
    );
    final songWithSource = SongWithSource(
      basicInfo: basicInfo,
      audioSources: audioSources,
      musicInfos: musicInfos,
    );
    bool res = false;
    if (oldSongWithSource == null) {
      res = await DatabaseService.to.addSong(songWithSource);
    } else {
      if (oldSongWithSource!.basicInfo != basicInfo) {
        res = await DatabaseService.to
            .updateBasicSongInfo(oldSongWithSource!.basicInfo, basicInfo);
      } else {
        res = true;
      }
      if (oldSongWithSource!.audioSources != audioSources && res) {
        res = await DatabaseService.to.updateAudioSources(songWithSource);
      } else {
        res = false;
      }
      if (oldSongWithSource!.musicInfos != musicInfos && res) {
        res = await DatabaseService.to.updateMusicInfos(songWithSource);
      } else {
        res = false;
      }
    }
    if (!res) {
      MyToast.show(message: '保存失败');
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    if (oldSongWithSource != null) {
      title = oldSongWithSource!.basicInfo.title;
      titleController.text = oldSongWithSource!.basicInfo.title;
      searchController.text = oldSongWithSource!.basicInfo.title;
      artist = oldSongWithSource!.basicInfo.artist;
      artistController.text = oldSongWithSource!.basicInfo.artist;
      album = oldSongWithSource!.basicInfo.album;
      albumController.text = oldSongWithSource!.basicInfo.album;
      audioSources = oldSongWithSource!.audioSources.map((e) => e).toList();
      musicInfos = oldSongWithSource!.musicInfos.map((e) => e).toList();
    }
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void removeAudioSource(SourceItem sourceItem) {
    audioSources.remove(sourceItem);
    update();
  }

  void removeMusicInfo(SourceItem sourceItem) {
    musicInfos.remove(sourceItem);
    update();
  }

  void addAudioSourceFromSearch(int index) {
    final sourceItem = searchResult[index].audioSources[0];
    if (audioSources.contains(sourceItem)) {
      MyToast.show(message: '已经添加过了');
      return;
    }
    audioSources.add(sourceItem);
    MyToast.show(message: '添加成功');
    update();
  }

  void addMusicInfoFromSearch(int index) {
    final sourceItem = searchResult[index].musicInfos[0];
    if (musicInfos.contains(sourceItem)) {
      MyToast.show(message: '已经添加过了');
      return;
    }
    musicInfos.add(sourceItem);
    MyToast.show(message: '添加成功');
    update();
  }

  void changeSource(SearchProvider source) {
    final index = allSources.indexWhere((element) => element == source);
    currentSourceIndex = index;
    update();
    search();
  }

  void search() async {
    final query = searchController.text;
    page = 1;
    allSources[currentSourceIndex].search(query).then((value) {
      if (value != null) {
        searchResult = value;
        update();
      } else {
        update();
      }
      refreshController.refreshCompleted();
    });
  }

  Future<void> nextPage() async {
    page++;
    final res = await allSources[currentSourceIndex]
        .search(searchController.text, page: page);
    if (res != null) {
      searchResult.addAll(res);
      update();
    }
    refreshController.loadComplete();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
