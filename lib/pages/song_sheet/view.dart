import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/index.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/widgets/listenall_app_bar.dart';
import 'widgets/leading.dart';
import 'widgets/song_sheet_item_options.dart';

class SongSheetPage extends StatelessWidget {
  const SongSheetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final songSheetName = Get.parameters['songSheetName'] ?? '';
    return GetBuilder<SongSheetController>(
      init: SongSheetController(songSheetName),
      id: "song_sheet",
      builder: (_) {
        return Scaffold(
          appBar: const ListenAllAppBar(),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  onRefresh: _.initData,
                  controller: _.refreshController,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.3,
                          automaticallyImplyLeading: false,
                          flexibleSpace: const Leading()),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(_.songSheet[index].title),
                                  subtitle: Text(
                                      "${_.songSheet[index].artist} - ${_.songSheet[index].album}"),
                                  onTap: () {
                                    _.onTap(index);
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.playlist_add),
                                    onPressed: () async {
                                      await _.add2Playlist(index);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    onPressed: () {
                                      showMaterialModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return SongSheetItemOptions(
                                                index: index);
                                          });
                                    },
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        childCount: _.songSheet.length,
                      ))
                    ],
                  ),
                ),
              ),
              const PlayerBar()
            ],
          )),
        );
      },
    );
  }
}
