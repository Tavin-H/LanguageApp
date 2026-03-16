import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DictionaryEntry {
  final String english;
  final String target;

  DictionaryEntry({required this.english, required this.target});
}

class DictionaryDatabaseService {
  static Database? _db;
  static final DictionaryDatabaseService instance =
      DictionaryDatabaseService._constructor();

  final String _wordsTableName = "words";
  final String _wordsIdColumnName = "id";
  final String _wordsEnglishColumnName = "english";
  final String _wordsTargetColumnName = "target";

  DictionaryDatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "dictionary_db.db");
    await deleteDatabase(databasePath);

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
				CREATE TABLE $_wordsTableName (
					$_wordsIdColumnName INTEGER PRIMARY KEY,
					$_wordsEnglishColumnName TEXT NOT NULL,
					$_wordsTargetColumnName TEXT NOT NULL
				)
				''');
      },
    );
    return database;
  }

  void addEntry(String english, String target) async {
    final db = await database;
    await db.insert(_wordsTableName, {
      _wordsEnglishColumnName: english,
      _wordsTargetColumnName: target,
    });
  }

  Future<List<DictionaryEntry>> getEntries() async {
    final db = await database;
    final data = await db.query(_wordsTableName);
    List<DictionaryEntry> entries = data
        .map(
          (e) => DictionaryEntry(
            target: e["target"] as String,
            english: e["english"] as String,
          ),
        )
        .toList();
    return entries;
  }
}
