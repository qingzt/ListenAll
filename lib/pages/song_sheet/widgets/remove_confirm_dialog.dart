import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/index.dart';

class RemoveConfirmDialog extends StatelessWidget {
  const RemoveConfirmDialog({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('是否从所有歌曲中移除'),
      content: const Text('所有歌单中的同名歌曲也会被移除'),
      actions: [
        TextButton(
          onPressed: () async {
            await Get.find<SongSheetController>().removeFromAllSong(index);
            Get.back();
            Get.back();
          },
          child: const Text('确定'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
      ],
    );
  }
}
