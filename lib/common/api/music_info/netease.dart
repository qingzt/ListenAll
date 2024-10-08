import 'dart:convert';

import '../../models/index.dart';
import '../dio_groups.dart';
import 'music_info_provider.dart';

class NeteaseMusicInfoProvider implements MusicInfoProvider {
  NeteaseMusicInfoProvider(this.id);
  @override
  String id;
  @override
  Future<ExtendMusicInfo?> getMusicInfo() async {
    try {
      final dio = DioGroups().netease;
      final res = await dio.post('/api/song/lyric', data: {
        'data': {
          'id': id,
          'lv': -1,
          'tv': -1,
          'kv': -1,
          'rv': -1,
          '_nmclfl': 1
        },
        'options': {
          'crypto': 'eapi',
        }
      });
      final data = jsonDecode(res.data);
      final lyrics = data['lrc']['lyric'];
      final tlyrics = data['tlyric']['lyric'];
      final res2 = await dio.post('/api/v3/song/detail', data: {
        'data': {
          'c': '[{"id":$id}]',
        },
        'options': {
          'crypto': 'eapi',
        }
      });
      Map<String, dynamic> data2;
      if (res2.data is String) {
        data2 = jsonDecode(res2.data);
      } else {
        data2 = res2.data;
      }
      if (data2['songs'] == null) {
        return null;
      }
      String albumArt = data2['songs'][0]['al']['picUrl'];
      return ExtendMusicInfo(
          lyrics: lyrics, albumArt: albumArt, tlyrics: tlyrics);
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
