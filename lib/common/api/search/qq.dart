import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../dio_groups.dart';
import 'search_provider.dart';

class QQSearchProvider extends SearchProvider {
  @override
  Icon getSearchIcon() {
    return const Icon(IconData(58629, fontFamily: 'SearchIcon'));
  }

  @override
  Future<List<SongWithSource>?> search(String query, {int page = 1}) async {
    try {
      List<SongWithSource> result = [];
      final dio = DioGroups().qq;
      const int pageSize = 20;
      final res =
          (await dio.post('https://u.y.qq.com/cgi-bin/musicu.fcg', data: {
        'comm': {
          'ct': '19',
          'cv': '1859',
          'uin': '0',
        },
        'req': {
          'method': 'DoSearchForQQMusicDesktop',
          'module': 'music.search.SearchCgiService',
          'param': {
            'query': query,
            'page_num': page,
            'num_per_page': pageSize,
            'search_type': 0,
          }
        }
      }))
              .data;
      List<Map<String, dynamic>> data;
      data = List.castFrom(res['req']['data']['body']['song']['list']);
      for (var item in data) {
        final basicInfo = BasicMusicInfo(
          title: item['name'],
          artist: item['singer'].map((e) => e['name']).join('/'),
          album: item['album']['name'],
        );
        result.add(SongWithSource(
          basicInfo: basicInfo,
          audioSources: [
            SourceItem(
              sourceType: 'qq',
              sourceId: item['file']['media_mid'],
            ),
          ],
          musicInfos: [
            SourceItem(
              sourceType: 'qq',
              sourceId: item['file']['media_mid'],
            ),
          ],
        ));
      }
      return result;
    } on Exception catch (e) {
      print('caught: $e');
      return null;
    }
  }
}
