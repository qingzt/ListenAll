import 'package:drift/drift.dart';

class CurrentPlaylistItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get album => text()();
  IntColumn get orderId => integer()();
  @override
  List<String> get customConstraints => [
        'FOREIGN KEY (title, artist, album) REFERENCES all_songs(title, artist, album) ON DELETE CASCADE ON UPDATE CASCADE',
      ];
}
