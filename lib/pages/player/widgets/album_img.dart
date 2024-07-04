import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class AlbumImg extends StatelessWidget {
  const AlbumImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: GetBuilder<PlayerController>(
        id: 'musicInfo',
        builder: (_) {
          return CachedNetworkImage(
            fit: BoxFit.cover,
            height: min(MediaQuery.of(context).size.width / 4 * 3,
                MediaQuery.of(context).size.height / 2), // Add this line
            width: min(MediaQuery.of(context).size.width / 4 * 3,
                MediaQuery.of(context).size.height / 2),
            imageUrl: _.currentMusicInfo!.albumArt,
            placeholder: (context, url) =>
                Image.asset('assets/img/default_album.png'),
            errorWidget: (context, url, error) =>
                Image.asset('assets/img/default_album.png'),
          );
        },
      )),
    );
  }
}
