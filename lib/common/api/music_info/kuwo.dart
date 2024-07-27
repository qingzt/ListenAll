import 'dart:convert';

import '../../models/index.dart';
import '../dio_groups.dart';
import 'music_info_provider.dart';

class KuwoMusicInfoProvider implements MusicInfoProvider {
  KuwoMusicInfoProvider(this.id);
  @override
  String id;

  @override
  Future<ExtendMusicInfo?> getMusicInfo() async {
    String formatLyric(List<Map<String, dynamic>> arr) {
      String num2str(int num) {
        return num.toString().padLeft(2, '0');
      }

      return arr.fold('', (String str, Map<String, dynamic> item) {
        double t = double.parse(item['time']);
        int m = t ~/ 60;
        int s = t.toInt() % 60;
        int ms = ((t - m * 60 - s) * 100).toInt();
        return '$str[${num2str(m)}:${num2str(s)}.${num2str(ms)}]${item['lineLyric']}\n';
      });
    }

    try {
      final res1 = (await DioGroups()
          .kuwo
          .get("https://m.kuwo.cn/newh5/singles/songinfoandlrc?musicId=$id"));
      final res = jsonDecode(res1.data);
      String imgUrl = res['data']['songinfo']['pic'];
      imgUrl = imgUrl.replaceFirst("240", "500");
      List<Map<String, dynamic>> rawlyric = [];
      List<Map<String, dynamic>> rawTlyric = [];
      double currentTime = -1;
      for (int i = 0; i < res['data']['lrclist'].length; i++) {
        if (res['data']['lrclist'][i]['lineLyric'] != "//" &&
            res['data']['lrclist'][i]['lineLyric'] != "" &&
            res['data']['lrclist'][i]['lineLyric'] != null) {
          if (double.parse(res['data']['lrclist'][i]['time']) == currentTime) {
            rawTlyric.add(res['data']['lrclist'][i]);
            currentTime = double.parse(res['data']['lrclist'][i]['time']);
          } else {
            rawlyric.add(res['data']['lrclist'][i]);
            currentTime = double.parse(res['data']['lrclist'][i]['time']);
          }
        }
      }
      String lyric = "";
      String tlyric = "";
      if (rawTlyric.isEmpty) {
        lyric = formatLyric(rawlyric);
      } else {
        lyric = formatLyric(rawTlyric);
        tlyric = formatLyric(rawlyric);
      }
      return ExtendMusicInfo(lyrics: lyric, albumArt: imgUrl, tlyrics: tlyric);
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }
}
