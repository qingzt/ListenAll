import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/common/widgets/snack_bar.dart';
import 'package:listenall/pages/edit_music_info/index.dart';
import 'package:listenall/pages/edit_music_info/widgets/choose_source_page.dart';

class SourceEdit extends StatelessWidget {
  const SourceEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        GetBuilder<EditMusicInfoController>(
          init: EditMusicInfoController(),
          initState: (_) {},
          builder: (_) {
            return SliverList(
                delegate: SliverChildListDelegate([
              ExpansionTile(
                title: const Text("音源"),
                leading: IconButton(
                    onPressed: () {
                      Get.to(() => const ChooseSourcePage(),
                          transition: Transition.rightToLeftWithFade);
                    },
                    icon: const Icon(Icons.add)),
                children: _.audioSources.map((e) {
                  return ListTile(
                      title: Text(e.sourceType),
                      subtitle: Text(e.sourceId),
                      leading: IconButton(
                        onPressed: () {
                          _.removeAudioSource(e);
                        },
                        icon: const Icon(Icons.delete),
                      ));
                }).toList(),
              ),
              ExpansionTile(
                  title: const Text("信息源"),
                  leading: IconButton(
                      onPressed: () {
                        Get.to(() => const ChooseSourcePage(),
                            transition: Transition.rightToLeftWithFade);
                      },
                      icon: const Icon(Icons.add)),
                  children: _.musicInfos.map((e) {
                    return ListTile(
                      title: Text(e.sourceType),
                      subtitle: Text(e.sourceId),
                      leading: IconButton(
                        onPressed: () {
                          _.removeMusicInfo(e);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  }).toList()),
              Center(
                child: TextButton(
                  onPressed: () async {
                    final res = await _.save();
                    if (res) {
                      Get.back();
                      MyToast.show(message: '保存成功');
                    }
                  },
                  child: const Text("保存"),
                ),
              )
            ]));
          },
        ),
      ],
    );
  }
}
