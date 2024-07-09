import '../lyrics_line_model.dart';
import 'lyrics_parse.dart';
import 'parser_lrc.dart';
import 'parser_qrc.dart';

///smart parser
///Parser is automatically selected
class ParserSmart extends LyricsParse {
  ParserSmart(String lyric) : super(lyric);

  @override
  List<LyricsLineModel> parseLines({bool isMain = true}) {
    var qrc = ParserQrc(lyric);
    if (qrc.isOK()) {
      return qrc.parseLines(isMain: isMain);
    }
    return ParserLrc(lyric).parseLines(isMain: isMain);
  }
}
