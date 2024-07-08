import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/index.dart';

class Leading extends StatelessWidget {
  const Leading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SongSheetController>(
      id: "leading",
      builder: (_) {
        return FlexibleSpaceBar(
          background: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                _.leadingSongInfo == null
                    ? Image.asset('assets/img/default_album.png')
                    : CachedNetworkImage(
                        httpHeaders: const {
                          'User-Agent':
                              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                        },
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: _.leadingSongInfo!.albumArt,
                        placeholder: (context, url) =>
                            Image.asset('assets/img/default_album.png'),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/img/default_album.png'),
                      ),
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.3),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: _.leadingSongInfo == null
                            ? Image.asset('assets/img/default_album.png')
                            : CachedNetworkImage(
                                httpHeaders: const {
                                  'User-Agent':
                                      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                                },
                                fit: BoxFit.cover,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.height * 0.2,
                                imageUrl: _.leadingSongInfo!.albumArt,
                                placeholder: (context, url) =>
                                    Image.asset('assets/img/default_album.png'),
                                errorWidget: (context, url, error) =>
                                    Image.asset('assets/img/default_album.png'),
                              ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            _.songSheetName,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          collapseMode: CollapseMode.parallax,
        );
      },
    );
  }
}
