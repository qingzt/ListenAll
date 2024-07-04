import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'new_song_sheet_dialog.dart';

class ChooseSongSheetDialog extends StatelessWidget {
  const ChooseSongSheetDialog({super.key, required this.searchIndex});
  final int searchIndex;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加到播放列表'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.3,
        child: GetBuilder<NetworkSearchController>(
          builder: (_) {
            return ListView.builder(
              itemCount: _.songSheets.length + 1,
              itemBuilder: (context, index) {
                if (index == _.songSheets.length) {
                  return ListTile(
                    title: const Text('新建播放列表'),
                    onTap: () {
                      Get.dialog(NewSongSheetDialog(searchIndex: searchIndex));
                    },
                  );
                }
                return ListTile(
                  title: Text(_.songSheets[index].name),
                  onTap: () {
                    _.add2SongSheet(searchIndex, _.songSheets[index].name);
                    Get.back();
                  },
                );
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('取消'))
      ],
    );
  }
}
