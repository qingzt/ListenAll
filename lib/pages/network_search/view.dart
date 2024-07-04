
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/widgets/index.dart';
import '../player/widgets/player_bar.dart';
import 'index.dart';
import 'widgets/choose_song_sheet_dialog.dart';
import 'widgets/search_page_search_bar.dart';

class NetworkSearchPage extends StatelessWidget {
  NetworkSearchPage({super.key});
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    final searchQuery = Get.parameters['query'] ?? '';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const ListenAllAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            SearchPageSearchBar(keywords: searchQuery),
            GetBuilder<NetworkSearchController>(
              init: NetworkSearchController(searchQuery),
              initState: (_) {},
              builder: (_) {
                return Expanded(
                    child: SmartRefresher(
                  enablePullUp: true,
                  onRefresh: () async {
                    await _.initData();
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await _.nextPage();
                    _refreshController.loadComplete();
                  },
                  controller: _refreshController,
                  child: ListView.builder(
                    itemCount: _.searchResult.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title:
                                  Text(_.searchResult[index].basicInfo.title),
                              subtitle: Text(
                                  "${_.searchResult[index].basicInfo.artist} - ${_.searchResult[index].basicInfo.album}"),
                              onTap: () {
                                _.addToPlayList(_.searchResult[index]);
                              },
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.playlist_add),
                                onPressed: () async {
                                  _
                                      .add2CurrentPlaylistNext(index)
                                      .then((value) {
                                    if (value) {
                                      Get.snackbar("添加成功", "已添加到下一首播放",
                                          snackPosition: SnackPosition.BOTTOM,
                                          overlayColor:
                                              Colors.black.withOpacity(0.5));
                                    } else {
                                      Get.snackbar("添加失败", "可能已经在播放列表中",
                                          snackPosition: SnackPosition.BOTTOM,
                                          overlayColor:
                                              Colors.black.withOpacity(0.5));
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.more_horiz),
                                onPressed: () {
                                  Get.dialog(ChooseSongSheetDialog(
                                      searchIndex: index));
                                },
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ));
              },
            ),
            const PlayerBar()
          ],
        ),
      ),
    );
  }
}
