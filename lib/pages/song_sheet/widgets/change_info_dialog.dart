import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/index.dart';

class ChangeInfoDialog extends StatelessWidget {
  const ChangeInfoDialog({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController(
        text: Get.find<SongSheetController>().songSheet[index].title);
    final TextEditingController artistController = TextEditingController(
        text: Get.find<SongSheetController>().songSheet[index].artist);
    final TextEditingController albumController = TextEditingController(
        text: Get.find<SongSheetController>().songSheet[index].album);
    return AlertDialog(
      title: const Text('修改信息'),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 4,
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: '歌曲名', border: OutlineInputBorder()),
            ),
            TextField(
              controller: artistController,
              decoration: const InputDecoration(
                  labelText: '歌手', border: OutlineInputBorder()),
            ),
            TextField(
              controller: albumController,
              decoration: const InputDecoration(
                  labelText: '专辑', border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () async {
            await Get.find<SongSheetController>().changeSongInfo(
                index: index,
                title: titleController.text,
                artist: artistController.text,
                album: albumController.text);
            Get.back();
          },
          child: const Text('确定'),
        ),
      ],
    );
  }
}
