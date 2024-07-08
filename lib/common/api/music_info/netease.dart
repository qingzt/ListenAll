import 'dart:convert';

import 'package:listenall/common/api/dio_groups.dart';

import '../../models/index.dart';
import 'music_info_provider.dart';

class NeteaseMusicInfoProvider implements MusicInfoProvider {
  NeteaseMusicInfoProvider(this.id);
  @override
  String id;
  @override
  Future<MusicInfo?> getMusicInfo() async {
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
      final res2 = await dio.post('/api/v3/song/detail', data: {
        'data': {
          'c': '[{"id":$id}]',
        },
        'options': {
          'crypto': 'eapi',
        }
      });
      final data2 = jsonDecode(res2.data);
      String title = data2['songs'][0]['name'];
      String artist = data2['songs'][0]['ar'].map((e) => e['name']).join("/");
      String album = data2['songs'][0]['al']['name'];
      String albumArt = data2['songs'][0]['al']['picUrl'];
      return MusicInfo(
        title: title,
        artist: artist,
        album: album,
        lyrics: lyrics,
        albumArt: albumArt,
      );
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
