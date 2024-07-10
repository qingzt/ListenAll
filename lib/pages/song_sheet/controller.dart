import 'package:get/get.dart';
import 'package:listenall/common/models/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/services/index.dart';

class SongSheetController extends GetxController {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  final String songSheetName;
  SongSheetController(this.songSheetName);
  List<BasicMusicInfo> songSheet = [];
  ExtendMusicInfo? leadingSongInfo;
  initData() async {
    songSheet = await DatabaseService.to.getSongSheetItems(songSheetName);
    update(["song_sheet"]);
    if (songSheet.isNotEmpty) {
      DatabaseService.to.getSongInfo(songSheet.last).then((value) {
        leadingSongInfo = value;
        update(["leading"]);
      });
    } else {
      leadingSongInfo = null;
      update(["leading"]);
    }
    refreshController.refreshCompleted();
  }

  void onTap(int index) async {
    await AudioService.to.changePlaylist(songSheet);
    await AudioService.to.selectToPlay(index);
  }

  Future<bool> add2Playlist(int index) async {
    return AudioService.to.add2CurrentPlayList(songSheet[index]);
  }

  Future<void> remove(int index) async {
    await DatabaseService.to
        .removeSongSheetItem(songSheet[index], songSheetName);
    initData();
  }

  Future<void> removeFromAllSong(int index) async {
    await DatabaseService.to.removeFromAllSong(songSheet[index]);
    initData();
  }

  Future<void> changeSongInfo(
      {required int index,
      required String title,
      required String artist,
      required String album}) async {
    // final newInfo = BasicMusicInfo(title: title, artist: artist, album: album);
    // await DatabaseService.to.changeSongInfo(songSheet[index], newInfo);
    // initData();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
