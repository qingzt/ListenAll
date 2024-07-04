import 'package:listenall/common/api/audio_source/audio_source_provider.dart';
import 'package:listenall/common/api/music_info/music_info_provider.dart';

import 'music_basic_info.dart';

class PlayableItem {
  int currentSourceIndex = 0;
  int currentInfoIndex = 0;
  MusicBasicInfo basicInfo;
  List<AudioSourceProvider> sources;
  List<MusicInfoProvider> infos;
  PlayableItem(
      {required this.sources, required this.infos, required this.basicInfo});
}
