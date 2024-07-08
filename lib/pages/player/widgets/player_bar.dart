import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/routers/index.dart';
import '../controller.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: GetBuilder<PlayerController>(
          id: 'playBar',
          builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(RouteNames.player);
                    },
                    style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                        foregroundColor: Theme.of(context).primaryColor),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _.currentMusicInfo != null
                              ? CachedNetworkImage(
                                  httpHeaders: const {
                                    'User-Agent':
                                        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                                  },
                                  fit: BoxFit.cover,
                                  height: 65,
                                  width: 65,
                                  imageUrl: _.currentMusicInfo!.albumArt,
                                  placeholder: (context, url) => Image.asset(
                                      'assets/img/default_album.png'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          'assets/img/default_album.png'),
                                )
                              : Image.asset('assets/img/default_album.png'),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _.currentMusicInfo == null
                                      ? '未知音乐'
                                      : _.currentMusicInfo!.title,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                Text(
                                  _.currentMusicInfo == null
                                      ? '未知歌手'
                                      : _.currentMusicInfo!.artist,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        iconSize: 25,
                        icon: const Icon(Icons.skip_previous),
                        onPressed: () {
                          _.previous();
                        },
                      ),
                      IconButton(
                        iconSize: 35,
                        icon: _.isBuffering
                            ? const CircularProgressIndicator()
                            : (_.isPlaying
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow)),
                        onPressed: () {
                          _.playOrPause();
                        },
                      ),
                      IconButton(
                        iconSize: 25,
                        icon: const Icon(Icons.skip_next),
                        onPressed: () {
                          _.next();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
