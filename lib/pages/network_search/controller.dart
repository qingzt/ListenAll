import 'package:get/get.dart';
import 'package:listenall/common/widgets/snack_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/api/index.dart';
import '../../common/api/search/netease.dart';
import '../../common/models/index.dart';
import '../../common/services/index.dart';

class NetworkSearchController extends GetxController {
  NetworkSearchController(this._searchQuery);
  int currentSourceIndex = 0;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final String _searchQuery;
  final List<SearchProvider> allSources = [
    NeteaseSearchProvider(),
    BilibiliSearchProvider(),
  ];

  initData() async {
    songSheets = await DatabaseService.to.getSongSheets();
    update(["network_search"]);
  }

  void onTap() {}

  void changeSource(SearchProvider source) {
    final index = allSources.indexWhere((element) => element == source);
    currentSourceIndex = index;
    update(['searchBar']);
    search(_searchQuery);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  int page = 1;
  bool isSearching = true;
  bool isLoadMore = false;
  List<SongWithSource> searchResult = [];
  List<SongSheet> songSheets = [];
  void search(String query) async {
    page = 1;
    isSearching = true;
    allSources[currentSourceIndex].search(query).then((value) {
      if (value != null) {
        searchResult = value;
        isSearching = false;
        update();
      } else {
        isSearching = false;
        update();
      }
      refreshController.refreshCompleted();
    });
  }

  Future<void> nextPage() async {
    if (isLoadMore) return;
    isLoadMore = true;
    page++;
    final res =
        await allSources[currentSourceIndex].search(_searchQuery, page: page);
    if (res != null) {
      searchResult.addAll(res);
      isLoadMore = false;
      update();
    }
    refreshController.loadComplete();
  }

  void addToPlayList(SongWithSource songInfo) async {
    if (!await add2AllSongFromSearch(songInfo)) {
      return;
    }
    await AudioService.to.add2CurrentPlayListAndPlay(songInfo.basicInfo);
  }

  Future<bool> add2AllSongFromSearch(SongWithSource song) async {
    final res1 = await AudioSourceProvider(song.sourceType, song.id).getMedia();
    if (res1 == null) {
      MySnackBar.show(message: '歌曲可能需要会员', title: '无法播放该歌曲');
      return false;
    }
    var res = await DatabaseService.to.add2AllSong(song.basicInfo);
    res = await DatabaseService.to.add2AudioSource(song);
    res = await DatabaseService.to.add2MusicInfo(song);
    return res;
  }

  Future<bool> add2CurrentPlaylistNext(int index) async {
    if (!await add2AllSongFromSearch(searchResult[index])) {
      return false;
    }
    return await AudioService.to
        .add2CurrentPlayNext(searchResult[index].basicInfo);
  }

  void add2SongSheet(int searchIndex, String songSheetName) async {
    var songInfo = searchResult[searchIndex];
    if (!await add2AllSongFromSearch(songInfo)) {
      return;
    }
    await DatabaseService.to.add2SongSheet(songInfo.basicInfo, songSheetName);
  }

  void newSongSheet(int searchIndex, String songSheetName) async {
    var songInfo = searchResult[searchIndex];
    if (!await add2AllSongFromSearch(songInfo)) {
      return;
    }
    await DatabaseService.to.newSongSheet(songInfo.basicInfo, songSheetName);
    await initData();
  }
}
