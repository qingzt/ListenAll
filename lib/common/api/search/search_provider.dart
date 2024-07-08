import 'package:flutter/material.dart';

import '../../models/song_with_source.dart';

abstract class SearchProvider {
  Future<List<SongWithSource>?> search(String query, {int page = 1});
  Icon getSearchIcon();
}
