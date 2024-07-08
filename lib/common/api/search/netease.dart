import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/icon.dart';
import '../../models/index.dart';
import '../dio_groups.dart';
import '../index.dart';

class NeteaseSearchProvider extends SearchProvider {
  static const int _pageSize = 20;
  @override
  Future<List<SongWithSource>?> search(String query, {int page = 1}) async {
    List<SongWithSource> result = [];
    final int offset = (page - 1) * _pageSize;
    Dio dio = DioGroups().netease;
    try {
      final res = await dio.post("/api/search/pc", data: {
        'data': {"s": query, "offset": offset, "limit": _pageSize, "type": "1"},
        'options': {
          'crypto': 'api',
        }
      });
      final data = jsonDecode(res.data)["result"]["songs"];
      for (var item in data) {
        result.add(SongWithSource(
            basicInfo: MusicBasicInfo(
                title: item["name"],
                artist: item["artists"].map((e) => e["name"]).join("/"),
                album: item["album"]["name"]),
            id: item["id"].toString(),
            sourceType: "netease"));
      }
      return result;
    } catch (e) {
      print("caught: $e");
    }
    return null;
  }

  @override
  Icon getSearchIcon() {
    return const Icon(IconData(60285, fontFamily: 'BiliBili_Netease'));
  }
}
