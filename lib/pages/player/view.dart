import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/index.dart';
import 'index.dart';
import 'widgets/lyrics.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({super.key});

  Widget _buildForDefault() {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: ListenAllAppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: '专辑'),
                Tab(text: '歌词'),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      AlbumImg(),
                      Lyrics(),
                    ],
                  ),
                ),
                CurrentMusicInfo(),
                PlayerProgressIndicator(),
                ActionButtons(),
              ],
            ),
          )),
    );
  }

  Widget _buildForLargeScreen() {
    return const Scaffold(
        appBar: ListenAllAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: AlbumImg()),
                    Expanded(child: Lyrics()),
                  ],
                ),
              ),
              CurrentMusicInfo(),
              PlayerProgressIndicator(),
              ActionButtons(),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerController());
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return _buildForLargeScreen();
        } else {
          return _buildForDefault();
        }
      },
    );
  }
}
