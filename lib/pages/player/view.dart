import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/index.dart';
import 'index.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerController());
    return const Scaffold(
        appBar: ListenAllAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: AlbumImg(),
              ),
              CurrentMusicInfo(),
              PlayerProgressIndicator(),
              ActionButtons(),
            ],
          ),
        ));
  }
}
