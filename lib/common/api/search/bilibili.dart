import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:listenall/common/api/dio_groups.dart';
import 'package:listenall/common/models/source_item.dart';

import '../../models/music_basic_info.dart';
import '../../models/song_with_source.dart';
import 'search_provider.dart';

class BilibiliSearchProvider extends SearchProvider {
  @override
  Future<List<SongWithSource>?> search(String query, {int page = 1}) async {
    final Dio dio = DioGroups().bilibili;
    try {
      var dataResponse = await dio.get(
          'https://api.bilibili.com/x/web-interface/search/type?search_type=video&keyword=$query&page=$page');
      var data = dataResponse.data['data']['result'];
      List<SongWithSource> result = [];
      for (var item in data) {
        String title = item['title'];
        title = title.replaceAll(RegExp(r'<[^>]*>'), '');
        final basicInfo = BasicMusicInfo(
          title: title,
          artist: item['author'],
          album: "无",
        );
        result.add(SongWithSource(basicInfo: basicInfo, audioSources: [
          SourceItem(sourceType: "bilibili", sourceId: item['bvid'])
        ], musicInfos: [
          SourceItem(sourceType: "bilibili", sourceId: item['bvid'])
        ]));
      }
      return result;
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }

  @override
  Icon getSearchIcon() {
    return const Icon(IconData(58889, fontFamily: 'BiliBili_Netease'));
  }
}
