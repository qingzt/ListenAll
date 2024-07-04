import 'package:get/get.dart';

import '../../common/api/index.dart';
import '../../common/models/index.dart';
import '../../common/services/index.dart';

class NetworkSearchController extends GetxController {
  NetworkSearchController(this._searchQuery);
  SearchProvider currentSearchProvider = BilibiliSearchProvider();
  final String _searchQuery;

  initData() async {
    songSheets = await DatabaseService.to.getSongSheets();
    update(["network_search"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    initData();
    search(_searchQuery);
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
    currentSearchProvider.search(query).then((value) {
      if (value != null) {
        searchResult = value;
        isSearching = false;
        update();
      } else {
        isSearching = false;
        update();
      }
    });
  }

  Future<void> nextPage() async {
    if (isLoadMore) return;
    isLoadMore = true;
    page++;
    final res = await currentSearchProvider.search(_searchQuery, page: page);
    if (res != null) {
      searchResult.addAll(res);
      isLoadMore = false;
      update();
    }
  }

  void addToPlayList(SongWithSource songInfo) async {
    await add2AllSongFromSearch(songInfo);
    await AudioService.to.add2CurrentPlayListAndPlay(songInfo.basicInfo);
  }

  Future<bool> add2AllSongFromSearch(SongWithSource song) async {
    var res = await DatabaseService.to.add2AllSong(song.basicInfo);
    res = await DatabaseService.to.add2AudioSource(song);
    res = await DatabaseService.to.add2MusicInfo(song);
    return res;
  }

  Future<bool> add2CurrentPlaylistNext(int index) async {
    await add2AllSongFromSearch(searchResult[index]);
    return await AudioService.to
        .add2CurrentPlayNext(searchResult[index].basicInfo);
  }

  void add2SongSheet(int searchIndex, String songSheetName) async {
    var songInfo = searchResult[searchIndex];
    await add2AllSongFromSearch(songInfo);
    await DatabaseService.to.add2SongSheet(songInfo.basicInfo, songSheetName);
  }

  void newSongSheet(int searchIndex, String songSheetName) async {
    var songInfo = searchResult[searchIndex];
    await add2AllSongFromSearch(songInfo);
    await DatabaseService.to.newSongSheet(songInfo.basicInfo, songSheetName);
    await initData();
  }
}
