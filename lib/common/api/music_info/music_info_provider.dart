import '../../models/music_info.dart';
import 'bilibili.dart';

abstract class MusicInfoProvider {
  factory MusicInfoProvider(String source, String id) {
    switch (source) {
      case 'bilibili':
        return BilibiliMusicInfoProvider(id);
      default:
        return DefaultMusicInfoProvider(id);
    }
  }

  abstract String id;
  Future<MusicInfo?> getMusicInfo();
}

class DefaultMusicInfoProvider implements MusicInfoProvider {
  DefaultMusicInfoProvider(this.id);
  @override
  String id;
  @override
  Future<MusicInfo?> getMusicInfo() async {
    return MusicInfo(
      title: "未知",
      artist: "未知",
      album: "未知",
      lyrics: "",
      albumArt: "",
    );
  }
}
