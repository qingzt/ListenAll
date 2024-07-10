import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/common/style/index.dart';
import 'package:listenall/common/widgets/index.dart';
import 'package:listenall/pages/edit_music_info/index.dart';
import 'package:listenall/pages/edit_music_info/widgets/edit_music_info_page_search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChooseSourcePage extends StatelessWidget {
  const ChooseSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ListenAllAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const EditMusicInfoPageSearchBar(),
            GetBuilder<EditMusicInfoController>(
              builder: (_) {
                return Expanded(
                    child: ScrollConfiguration(
                  behavior: MyCustomScrollBehavior(),
                  child: SmartRefresher(
                    controller: _.refreshController,
                    enablePullUp: true,
                    onRefresh: () {
                      _.search();
                    },
                    onLoading: _.nextPage,
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
                              ),
                            ),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () async {
                                      _.addAudioSourceFromSearch(index);
                                    },
                                    child: const Text("添加音源")),
                                TextButton(
                                    onPressed: () {
                                      _.addMusicInfoFromSearch(index);
                                    },
                                    child: const Text("添加信息源"))
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
