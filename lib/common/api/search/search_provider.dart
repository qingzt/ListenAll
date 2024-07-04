import 'package:media_kit/media_kit.dart';

import '../../models/song_with_source.dart';

abstract class SearchProvider {
  Future<Media?> getMedia(String id);
  Future<List<SongWithSource>?> search(String query, {int page = 1});
}
