import 'package:drift/drift.dart';

class AllSongs extends Table {
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get album => text()();

  @override
  Set<Column> get primaryKey => {title, artist, album};
}
