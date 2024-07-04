import 'package:drift/drift.dart';

class AllMusicInfos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get album => text()();
  TextColumn get sourceType => text()();
  TextColumn get sourceId => text()();
  IntColumn get priority => integer()();

  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (title, artist, album) REFERENCES all_songs(title, artist, album) ON DELETE CASCADE ON UPDATE CASCADE',
      ];
}
