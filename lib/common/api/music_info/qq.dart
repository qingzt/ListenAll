import 'package:dio/dio.dart';

import '../../models/index.dart';
import '../dio_groups.dart';
import '../index.dart';

class QQMusicInfoProvider implements MusicInfoProvider {
  QQMusicInfoProvider(this.id);
  @override
  String id;

  @override
  Future<ExtendMusicInfo?> getMusicInfo() async {
    try {
      final res =
          (await DioGroups().qq.post('https://u.y.qq.com/cgi-bin/musicu.fcg',
                  data: {
                    'comm': {
                      'ct': '19',
                      'cv': '1859',
                      'uin': '0',
                    },
                    'req': {
                      'method': 'get_song_detail_yqq',
                      'module': 'music.pf_song_detail_svr',
                      'param': {
                        'song_type': 0,
                        'song_mid': id,
                      }
                    }
                  },
                  options: Options(headers: {
                    'User-Agent':
                        'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)',
                  })))
              .data;
      final data = res['req']['data']['track_info'];
      String? imgUrl = data['album']['mid'];
      if (imgUrl == null) {
        imgUrl = data['singer'][0]['mid'];
        imgUrl =
            "https://y.gtimg.cn/music/photo_new/T001R500x500M000$imgUrl.jpg";
      } else {
        imgUrl =
            "https://y.gtimg.cn/music/photo_new/T002R500x500M000$imgUrl.jpg";
      }
      final res2 = (await DioGroups().qq.get(
              'https://i.y.qq.com/lyric/fcgi-bin/fcg_query_lyric_new.fcg?songmid=$id&g_tk=5381&format=json&inCharset=utf8&outCharset=utf-8&nobase64=1'))
          .data;
      String lyric = res2['lyric'] ?? '';
      String tlyric = res2['trans'] ?? '';
      if (lyric.startsWith("[00:00:00]")) {
        lyric = "";
      }
      if (tlyric.startsWith("[00:00:00]")) {
        tlyric = "";
      }
      return ExtendMusicInfo(lyrics: lyric, albumArt: imgUrl, tlyrics: tlyric);
    } on Exception catch (e) {
      print("caught: $e");
    }
    return null;
  }
}
