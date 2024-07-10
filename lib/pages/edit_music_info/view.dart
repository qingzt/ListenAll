import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/common/models/index.dart';
import 'package:listenall/common/widgets/index.dart';

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
