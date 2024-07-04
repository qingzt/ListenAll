import 'package:get/get.dart';

import '../../common/models/index.dart';
import '../../common/services/index.dart';

class HomeController extends GetxController {
  HomeController();

  List<SongSheet> songSheets = [];

  initData() async {
    songSheets = [];
    songSheets = await DatabaseService.to.getSongSheets();
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
