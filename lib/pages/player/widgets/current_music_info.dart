import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controller.dart';
import 'current_song_options.dart';

class CurrentMusicInfo extends StatelessWidget {
  const CurrentMusicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: GetBuilder<PlayerController>(
          id: 'musicInfo',
          builder: (_) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _.currentMusicInfo == null
                            ? '未知音乐'
                            : _.currentMusicInfo!.basicInfo.title,
                        style: const TextStyle(
                            fontSize: 20, overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        _.currentMusicInfo == null
                            ? '未知歌手'
                            : _.currentMusicInfo!.basicInfo.artist,
                        style: const TextStyle(
                            fontSize: 15, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                          _.isLike ? Icons.favorite : Icons.favorite_border),
                      iconSize: 30,
                      onPressed: () {
                        _.likeOrUnlike();
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz),
                      iconSize: 30,
                      onPressed: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return const CurrentSongOptions();
                            });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
