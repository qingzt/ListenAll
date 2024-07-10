import 'package:get/get.dart';

import '../../pages/index.dart';
import 'index.dart';

class RoutePages {
  // 列表
  static List<GetPage> list = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteNames.networkSearch,
      page: () => const NetworkSearchPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
        name: RouteNames.player,
        page: () => const PlayerPage(),
        transition: Transition.downToUp),
    GetPage(
      name: RouteNames.songSheet,
      page: () => const SongSheetPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.editMusicInfo,
      page: () => const EditMusicInfoPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
