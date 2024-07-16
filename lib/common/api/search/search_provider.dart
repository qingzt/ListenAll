import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../index.dart';
import 'kuwo.dart';

abstract class SearchProvider {
  Future<List<SongWithSource>?> search(String query, {int page = 1});
  Icon getSearchIcon();
  static List<SearchProvider> providers = [
    NeteaseSearchProvider(),
    KuwoSearchProvider(),
    BilibiliSearchProvider(),
    QQSearchProvider(),
  ];
}
