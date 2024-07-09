import 'package:collection/collection.dart';
import './lyric_ui/lyric_ui.dart';
import './lyric_helper.dart';
import 'lyrics_line_model.dart';

///lyric model
class LyricsReaderModel {
  List<LyricsLineModel> lyrics = [];

  getCurrentLine(int progress) {
    var lastEndTime = 0;
    for (var i = 0; i < lyrics.length; i++) {
      var element = lyrics[i];
      if (progress >= (element.startTime ?? 0) &&
          progress < (element.endTime ?? 0)) {
        return i;
      }
      lastEndTime = element.endTime ?? 0;
    }
    if (progress > lastEndTime) {
      return lyrics.length - 1;
    } else {
      return 0;
    }
  }

  double computeScroll(int toLine, int playLine, LyricUI ui) {
    if (toLine <= 0) return 0;
    var targetLine = lyrics[toLine];
    double offset = 0;
    if (!targetLine.hasExt && !targetLine.hasMain) {
      offset += ui.getBlankLineHeight() + ui.getLineSpace();
    } else {
      offset += ui.getLineSpace();
      offset += LyricHelper.centerOffset(
          targetLine, toLine == playLine, ui, playLine);
    }
    //需要特殊处理往上偏移的第一行
    return -LyricHelper.getTotalHeight(
            lyrics.sublist(0, toLine), playLine, ui) +
        firstCenterOffset(playLine, ui) -
        offset;
  }

  double firstCenterOffset(int playIndex, LyricUI lyricUI) {
    return LyricHelper.centerOffset(
        lyrics.firstOrNull, playIndex == 0, lyricUI, playIndex);
  }

  double lastCenterOffset(int playIndex, LyricUI lyricUI) {
    return LyricHelper.centerOffset(
        lyrics.lastOrNull, playIndex == lyrics.length - 1, lyricUI, playIndex);
  }
}

class LyricSpanInfo {
  int index = 0;
  int length = 0;
  int duration = 0;
  int start = 0;
  String raw = "";

  double drawWidth = 0;
  double drawHeight = 0;

  int get end => start + duration;

  int get endIndex => index + length;
}

extension LyricsReaderModelExt on LyricsReaderModel? {
  get isNullOrEmpty => this?.lyrics == null || this!.lyrics.isEmpty;
}
