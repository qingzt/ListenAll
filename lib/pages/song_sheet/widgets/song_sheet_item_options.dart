import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/index.dart';
import 'package:listenall/pages/song_sheet/widgets/change_info_dialog.dart';

import 'remove_confirm_dialog.dart';

class SongSheetItemOptions extends StatelessWidget {
  const SongSheetItemOptions({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          child: ListView(
            children: [
              ListTile(
                title: const Text('添加到播放列表'),
                onTap: () async {
                  await Get.find<SongSheetController>().add2Playlist(index);
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('修改信息'),
                onTap: () async {
                  await Get.dialog(ChangeInfoDialog(index: index));
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('从歌单中移除'),
                onTap: () async {
                  if (Get.find<SongSheetController>().songSheetName == "所有歌曲") {
                    Get.dialog(RemoveConfirmDialog(index: index));
                  } else {
                    await Get.find<SongSheetController>().remove(index);
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
