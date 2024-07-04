import 'music_basic_info.dart';

class SongWithSource {
  MusicBasicInfo basicInfo;
  final String id;
  final String sourceType;

  SongWithSource({
    required this.basicInfo,
    required this.id,
    required this.sourceType,
  });
}
