import 'lyric_inline_draw_info.dart';
import 'package:flutter/cupertino.dart';

///lyric draw model
class LyricDrawInfo {
  double get otherMainTextHeight => otherMainTextPainter?.height ?? 0;

  double get otherExtTextHeight => otherExtTextPainter?.height ?? 0;

  double get playingMainTextHeight => playingMainTextPainter?.height ?? 0;

  double get playingExtTextHeight => playingExtTextPainter?.height ?? 0;
  TextPainter? otherMainTextPainter;
  TextPainter? otherExtTextPainter;
  TextPainter? playingMainTextPainter;
  TextPainter? playingExtTextPainter;
  List<LyricInlineDrawInfo> inlineDrawList = [];
}
