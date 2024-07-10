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
    update();
    songSheetCoverUrls = List.filled(songSheets.length, null);
    for (var i = 0; i < songSheets.length; i++) {
      songSheets[i].newInfo?.getMusicInfo().then((value) {
        if (value != null) {
          songSheetCoverUrls[i] = value.albumArt;
          update();
        }
      });
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
