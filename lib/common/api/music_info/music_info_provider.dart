import 'package:listenall/common/api/music_info/netease.dart';

import '../../models/extend_music_info.dart';
import 'bilibili.dart';

abstract class MusicInfoProvider {
  factory MusicInfoProvider(String source, String id) {
    switch (source) {
      case 'bilibili':
        return BilibiliMusicInfoProvider(id);
      case 'netease':
        return NeteaseMusicInfoProvider(id);
      default:
        return DefaultMusicInfoProvider(id);
    }
  }

  abstract String id;
  Future<ExtendMusicInfo?> getMusicInfo();
}

class DefaultMusicInfoProvider implements MusicInfoProvider {
  DefaultMusicInfoProvider(this.id);
  @override
  String id;
  @override
  Future<ExtendMusicInfo?> getMusicInfo() async {
    return null;
  }
}
