import 'music_basic_info.dart';
import 'source_item.dart';

class SongWithSource {
  BasicMusicInfo basicInfo;
  List<SourceItem> audioSources;
  List<SourceItem> musicInfos;

  SongWithSource(
      {required this.basicInfo,
      required this.audioSources,
      required this.musicInfos});
}
