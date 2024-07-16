import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/models/index.dart';
import '../../common/widgets/listenall_app_bar.dart';
import 'index.dart';
import 'widgets/basic_info_input.dart';
import 'widgets/source_edit.dart';

class EditMusicInfoPage extends StatelessWidget {
  const EditMusicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    SongWithSource? songWithSource = Get.arguments;
    Get.put(EditMusicInfoController(oldSongWithSource: songWithSource));
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ListenAllAppBar(),
      body: SafeArea(
          child: Column(
        children: [
          BasicInfoInput(),
          Expanded(child: SourceEdit()),
        ],
      )),
    );
  }
}
