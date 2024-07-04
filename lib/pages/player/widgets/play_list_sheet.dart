import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class PlayListSheet extends StatelessWidget {
  PlayListSheet({super.key});
  final ScrollController _scrollController = ScrollController();
  void scrollToCurrentPlaying(BuildContext context) {
    // 获取当前播放项的索引
    var currentIndex = Get.find<PlayerController>().currentPlayListItemIndex;
    // 计算滚动位置
    final position = currentIndex * 60.0; // 假设每个项的高度为60
    // 执行滚动
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToCurrentPlaying(context));
    return GetBuilder<PlayerController>(
      id: 'playlist',
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _.playList.length,
            itemBuilder: (context, index) {
              bool isCurrent = index == _.currentPlayListItemIndex;
              return SizedBox(
                height: 60,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: ListTile(
                    tileColor: isCurrent
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                    title: Text(
                      _.playList[index].basicInfo.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "${_.playList[index].basicInfo.artist}-${_.playList[index].basicInfo.album}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      _.selectToPlay(index);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _.removePlaylistItem(index);
                      },
                    ),
                    selected: isCurrent,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
