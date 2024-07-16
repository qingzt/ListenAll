import 'package:media_kit/media_kit.dart';

import 'bilibili.dart';
import 'kuwo.dart';
import 'netease.dart';
import 'qq.dart';

abstract class AudioSourceProvider {
  factory AudioSourceProvider(String source, String id) {
    switch (source) {
      case 'bilibili':
        return BilibiliAudioSourceProvider(id);
      case 'netease':
        return NeteaseAudioSourceProvider(id);
      case 'qq':
        return QQAudioSourceProvider(id);
      case 'kuwo':
        return KuwoAudioSourceProvider(id);
      default:
        return DefaultAudioSourceProvider(id);
    }
  }
  abstract String id;
  Future<Media?> getMedia();
}

class DefaultAudioSourceProvider implements AudioSourceProvider {
  DefaultAudioSourceProvider(this.id);
  @override
  String id;
  @override
  Future<Media?> getMedia() async {
    return null;
  }
}
