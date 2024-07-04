import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/index.dart';

import 'choose_song_sheet_dialog.dart';

class CurrentSongOptions extends StatelessWidget {
  const CurrentSongOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('添加到歌单'),
              onTap: () async {
                Get.find<PlayerController>().flushSongSheet();
                await Get.dialog(
                  ChooseSongSheetDialog(
                    searchIndex:
                        Get.find<PlayerController>().currentPlayListItemIndex,
                  ),
                );
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
