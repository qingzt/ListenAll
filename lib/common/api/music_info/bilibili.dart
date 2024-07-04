import 'package:dio/dio.dart';

import '../../models/music_info.dart';
import 'music_info_provider.dart';

class BilibiliMusicInfoProvider implements MusicInfoProvider {
  BilibiliMusicInfoProvider(this.id);
  @override
  String id;
  @override
  Future<MusicInfo?> getMusicInfo() async {
    final Dio dio = Dio();
    dio.options.headers['user-agent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3';
    dio.options.headers['referer'] = 'https://www.bilibili.com/';
    dio.options.headers['cookie'] = 'SESSDATA=xxx';
    try {
      var dataResponse = await dio
          .get('https://api.bilibili.com/x/web-interface/view?bvid=$id');
      var data = dataResponse.data['data'];
      return MusicInfo(
        title: data['title'],
        artist: data['owner']['name'],
        album: "无",
        lyrics: "",
        albumArt: data['pic'],
      );
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }
}
