import 'package:listenall/common/api/dio_groups.dart';
import 'package:media_kit/media_kit.dart';
import 'dart:convert';

import '../index.dart';

class NeteaseAudioSourceProvider implements AudioSourceProvider {
  NeteaseAudioSourceProvider(this.id);
  @override
  String id;
  @override
  Future<Media?> getMedia() async {
    try {
      var response = await DioGroups().netease.post(
        '/api/song/enhance/player/url',
        data: {
          'data': {
            'ids': [id],
            'br': 999000,
          },
          'options': {
            'cookie': {
              'os': 'pc',
            },
            'crypto': 'eapi'
          }
        },
      );
      var data = jsonDecode(response.data);
      String? url = data['data'][0]['url'];
      if (url == null) {
        return null;
      }
      return Media(url);
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
