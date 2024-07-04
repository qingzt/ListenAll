import 'package:dio/dio.dart';
import 'package:media_kit/media_kit.dart';

import '../../models/music_basic_info.dart';
import '../../models/song_with_source.dart';
import '../audio_source/bilibili.dart';
import 'search_provider.dart';

class BilibiliSearchProvider extends SearchProvider {
  @override
  Future<List<SongWithSource>?> search(String query, {int page = 1}) async {
    final Dio dio = Dio();
    dio.options.headers['user-agent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3';
    dio.options.headers['referer'] = 'https://www.bilibili.com/';
    dio.options.headers['cookie'] = 'SESSDATA=xxx';
    try {
      var dataResponse = await dio.get(
          'https://api.bilibili.com/x/web-interface/search/type?search_type=video&keyword=$query&page=$page');
      var data = dataResponse.data['data']['result'];
      List<SongWithSource> result = [];
      for (var item in data) {
        String title = item['title'];
        title = title.replaceAll(RegExp(r'<[^>]*>'), '');
        final basicInfo = MusicBasicInfo(
          title: title,
          artist: item['author'],
          album: "无",
        );
        result.add(SongWithSource(
          basicInfo: basicInfo,
          id: item['bvid'],
          sourceType: "bilibili",
        ));
      }
      return result;
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }

  @override
  Future<Media?> getMedia(String id) async {
    return BilibiliAudioSourceProvider(id).getMedia();
  }
}
