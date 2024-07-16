import 'package:listenall/common/api/dio_groups.dart';
import 'package:media_kit/media_kit.dart';

import '../index.dart';

class QQAudioSourceProvider implements AudioSourceProvider {
  QQAudioSourceProvider(this.id);
  @override
  String id;

  @override
  Future<Media?> getMedia() async {
    try {
      const quality = {'s': 'M500', 'e': '.mp3', 'bitrate': '128kbps'};
      final data = {
        'req_1': {
          'module': 'vkey.GetVkeyServer',
          'method': 'CgiGetVkey',
          'param': {
            'filename': ['${quality['s']}$id$id${quality['e']}'],
            'guid': '10000',
            'songmid': [id],
            'songtype': [0],
            'uin': '0',
            'loginflag': 1,
            'platform': '20',
          },
        },
        'loginUin': '0',
        'comm': {'uin': '0', 'format': 'json', 'ct': 24, 'cv': 0}
      };
      final res = await DioGroups()
          .qq
          .post('https://u.y.qq.com/cgi-bin/musicu.fcg', data: data);
      String url = res.data['req_1']['data']['midurlinfo'][0]['purl'];
      if (url == "") {
        return null;
      }
      url = "http://ws.stream.qqmusic.qq.com/$url";
      return Media(url);
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }
}
