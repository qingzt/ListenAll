import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/home/index.dart';
import 'package:listenall/pages/home/widgets/home_icon_group.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/style/index.dart';

class SongSheetList extends StatelessWidget {
  SongSheetList({super.key});
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeIconGroup(),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 8, bottom: 8),
              child: Text(
                '我的歌单',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: SmartRefresher(
                  onRefresh: () async {
                    await _.initData();
                    _refreshController.refreshCompleted();
                  },
                  controller: _refreshController,
                  child: ListView.builder(
                    itemCount: _.songSheets.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor: Colors.transparent,
                              ),
                              onPressed: () {
                                Get.toNamed(
                                    '/song_sheet?songSheetName=${_.songSheets[index].name}');
                              },
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    httpHeaders: const {
                                      'User-Agent':
                                          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                                    },
                                    fit: BoxFit.cover,
                                    height: 70,
                                    width: 70,
                                    imageUrl:
                                        _.songSheets[index].newInfo!.albumArt,
                                    placeholder: (context, url) => Image.asset(
                                        'assets/img/default_album.png'),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                            'assets/img/default_album.png'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      _.songSheets[index].name,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
