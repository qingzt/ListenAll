import 'dart:convert';
import 'package:flutter/material.dart';
import '../../models/index.dart';
import '../dio_groups.dart';
import '../index.dart';

class KuwoSearchProvider extends SearchProvider {
  @override
  Icon getSearchIcon() {
    return const Icon(IconData(58899, fontFamily: 'SearchIcon'));
  }

  @override
  Future<List<SongWithSource>?> search(String query, {int page = 1}) async {
    try {
      final res = jsonDecode((await DioGroups().kuwo.get(
                'https://www.kuwo.cn/search/searchMusicBykeyWord?vipver=1&client=kt&ft=music&cluster=0&strategy=2012&encoding=utf8&rformat=json&mobi=1&issubtitle=1&show_copyright_off=1&pn=${page - 1}&rn=20&all=$query',
              ))
          .data);
      final data = res['abslist'];
      final List<SongWithSource> result = [];
      for (var item in data) {
        final basicInfo = BasicMusicInfo(
          title: item['SONGNAME'],
          artist: item['ARTIST'],
          album: item['ALBUM'],
        );
        result.add(SongWithSource(
          basicInfo: basicInfo,
          audioSources: [
            SourceItem(
              sourceType: 'kuwo',
              sourceId: item['DC_TARGETID'],
            ),
          ],
          musicInfos: [
            SourceItem(
              sourceType: 'kuwo',
              sourceId: item['DC_TARGETID'],
            ),
          ],
        ));
      }
      return result;
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }
}
