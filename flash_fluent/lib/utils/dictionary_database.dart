import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

class DictionaryEntry {
  final String english;
  final String target;

  DictionaryEntry({required this.english, required this.target});

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) {
    return DictionaryEntry(target: json['target'], english: json['source']);
  }
}

class DictionaryDatabaseService {
  static Database? _db;
  static final DictionaryDatabaseService instance =
      DictionaryDatabaseService._constructor();

  final String _wordsTableName = "words";
  final String _wordsIdColumnName = "id";
  final String _wordsEnglishColumnName = "english";
  final String _wordsTargetColumnName = "target";

  final String _examplesTableName = "examples";
  final String _exampleSourceIdColumnName = "source";
  final String _exampleColumnName = "examples";

  DictionaryDatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  void purgeData() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "dictionary_db.db");

    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    await deleteDatabase(databasePath);
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
					$_wordsIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
					$_wordsEnglishColumnName TEXT NOT NULL,
					$_wordsTargetColumnName TEXT NOT NULL
				)
				''');
        db.execute('''
				CREATE TABLE $_examplesTableName (
					$_exampleSourceIdColumnName INTEGER,
					$_exampleColumnName TEXT NOT NULL
				)
				''');
      },
      onOpen: (db) async {},
    );
    final List<Map<String, dynamic>> count = await database.rawQuery(
      'SELECT COUNT(*) as count FROM $_wordsTableName',
    );
    if (count.first['count'] == 0) {
      // PASS the database instance directly to the function
      await loadDictionaryFromJson(database);
    }
    return database;
  }

  Future<int> addEntry(
    String english,
    String target, {
    Transaction? txn,
  }) async {
    final db = txn ?? await database;
    int key = await db.insert(_wordsTableName, {
      _wordsEnglishColumnName: english,
      _wordsTargetColumnName: target,
    });
    return key;
  }

  Future<void> addExample(
    int foreignKey,
    String example, {
    Transaction? txn,
  }) async {
    final db = txn ?? await database;
    await db.insert(_examplesTableName, {
      _exampleColumnName: example,
      _exampleSourceIdColumnName: foreignKey,
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

  Future<void> loadDictionaryFromJson(Database db) async {
    final String response = await rootBundle.loadString(
      'assets/word_data.json',
    );
    final List<dynamic> data = json.decode(response);
    await db.transaction((txn) async {
      for (var item in data) {
        int id = await addEntry(item['source'], item['target'], txn: txn);
        for (String example in item['examples']) {
          await addExample(id, example, txn: txn);
        }

        /*
      await txn.insert(_wordsTableName, {
        _wordsEnglishColumnName: item['source'],
        _wordsTargetColumnName: item['target'],
      });
			*/
      }
    });
    return;
  }

  Future<List<String>> queryExampeles(int id) async {
    final db = await database;
    final List<String> examples = [];

    final List<Map<String, dynamic>> results = await db.query(
      _examplesTableName,
      where: '$_exampleSourceIdColumnName = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      for (Map<String, dynamic> result in results) {
        examples.add(result[_exampleColumnName] as String);
      }
    }
    return examples;
  }

  Future<(String, List<String>)> queryWordInfo(String targetWord) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      _wordsTableName,
      where: '$_wordsTargetColumnName = ?',
      whereArgs: [targetWord],
    );
    if (results.isNotEmpty) {
      String english = results[0][_wordsEnglishColumnName];
      List<String> examples = await queryExampeles(
        results[0][_wordsIdColumnName],
      );

      return (english, examples);
    }
    return ("", [""]);
  }
}
