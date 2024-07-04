import 'package:dio/dio.dart';
import 'package:media_kit/media_kit.dart';
import 'audio_source_provider.dart';

class BilibiliAudioSourceProvider implements AudioSourceProvider {
  BilibiliAudioSourceProvider(this.id);
  @override
  String id;
  @override
  Future<Media?> getMedia() async {
    final Dio dio = Dio();
    dio.options.headers['user-agent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3';
    dio.options.headers['referer'] = 'https://www.bilibili.com/';
    var bvidAndPNo = id.split(' ');
    String bvid = "";
    String? pNo;
    if (bvidAndPNo.length == 1) {
      bvid = bvidAndPNo[0];
    } else {
      bvid = bvidAndPNo[0];
      pNo = bvidAndPNo[1];
    }
    try {
      var dataResponse = await dio
          .get('https://api.bilibili.com/x/web-interface/view?bvid=$bvid');
      var data = dataResponse.data;
      var cid = "";
      if (pNo != null) {
        var pages = data['data']['pages'];
        var page = pages[int.parse(pNo) - 1];
        if (page == null) {
          return null;
        }
        cid = page['cid'].toString();
      } else {
        cid = data['data']['cid'].toString();
      }

      var playUrlResponse = await dio.get(
          'https://api.bilibili.com/x/player/playurl?fnval=16&bvid=$bvid&cid=$cid');
      var playUrl = playUrlResponse.data;
      var url = playUrl['data']['dash']['audio'][0]['baseUrl'];

      return Media(url, httpHeaders: {
        'user-agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
        'referer': 'https://www.bilibili.com/'
      });
    } catch (e) {
      print("caught: $e");
    }
    return null; // 发生错误时返回null或者其他错误指示
  }
}
