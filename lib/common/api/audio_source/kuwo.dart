import 'package:listenall/common/api/dio_groups.dart';
import 'package:media_kit/media_kit.dart';

import '../index.dart';

class KuwoAudioSourceProvider implements AudioSourceProvider {
  KuwoAudioSourceProvider(this.id);
  @override
  String id;

  @override
  Future<Media?> getMedia() async {
    try {
      final res = (await DioGroups().kuwo.get(
              "https://www.kuwo.cn/api/v1/www/music/playUrl?mid=$id&type=music&httpsStatus=1&reqId=&plat=web_www&from="))
          .data;
      String url = res['data']['url'];
      return Media(url,
          httpHeaders: {"cookie": DioGroups().kuwo.options.headers["cookie"]});
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }
}
