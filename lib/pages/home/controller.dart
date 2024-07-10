import 'package:get/get.dart';

import '../../common/models/index.dart';
import '../../common/services/index.dart';

class HomeController extends GetxController {
  HomeController();

  List<SongSheet> songSheets = [];
  List<String?> songSheetCoverUrls = [];

  initData() async {
    songSheets = [];
    songSheets = await DatabaseService.to.getSongSheets();
    songSheetCoverUrls = List.filled(songSheets.length, null);
    for (var i = 0; i < songSheets.length; i++) {
      final songSheet = songSheets[i];
      final res = await songSheet.newInfo?.getMusicInfo();
      songSheetCoverUrls[i] = res?.albumArt;
    }
    update();
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void flush() {}

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
