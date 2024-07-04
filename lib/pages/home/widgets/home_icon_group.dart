import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/home/widgets/icon_button_with_text.dart';

import '../../../common/routers/index.dart';

class HomeIconGroup extends StatelessWidget {
  const HomeIconGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButtonWithText(
          icon: Icons.favorite,
          text: '我喜欢的',
          onPressed: () {
            Get.toNamed(RouteNames.songSheet,
                parameters: {'songSheetName': "我喜欢的音乐"});
          },
        ),
        IconButtonWithText(
          icon: Icons.history,
          text: '所有歌曲',
          onPressed: () {
            Get.toNamed(RouteNames.songSheet,
                parameters: {'songSheetName': "所有歌曲"});
          },
        ),
        IconButtonWithText(
          icon: Icons.playlist_add,
          text: '自定义音乐',
          onPressed: () {},
        ),
      ],
    );
  }
}
