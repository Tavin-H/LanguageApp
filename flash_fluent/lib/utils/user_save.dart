import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CompletionEntry {
  final String exercise;
  final int completed;

  CompletionEntry({required this.exercise, required this.completed});
}

class UserSaveSerice {
  static Database? _db;
  static final UserSaveSerice instance = UserSaveSerice._constructor();

  final String _completionTableName = "completion";

  final String _completionIdColumnName = "id";
  final String _completionExerciseName = "exercise";
  final String _completionCompletedColumnName = "completed";

  UserSaveSerice._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    print("Opening Completion Datbase!");
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "save_data.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE IF NOT EXISTS $_completionTableName (
        $_completionIdColumnName INTEGER PRIMARY KEY,
        $_completionExerciseName TEXT NOT NULL,
        $_completionCompletedColumnName INT
      )
    ''');
      },
      onOpen: (db) async {
        await db.execute('''
      CREATE TABLE IF NOT EXISTS $_completionTableName (
        $_completionIdColumnName INTEGER PRIMARY KEY,
        $_completionExerciseName TEXT NOT NULL,
        $_completionCompletedColumnName INT
      )
    ''');
      },
    );
    return database;
  }

  void purgeData() async {
    final db = await database;
    db.delete(_completionTableName);
  }

  Future<void> addEntry(String exercise, int completed) async {
    final db = await database;
    await db.insert(_completionTableName, {
      _completionExerciseName: exercise,
      _completionCompletedColumnName: completed,
    });
  }

  Future<List<CompletionEntry>> getEntries() async {
    final db = await database;
    final data = await db.query(_completionTableName);
    List<CompletionEntry> entries = data
        .map(
          (e) => CompletionEntry(
            exercise: e["exercise"] as String,
            completed: e["completed"] as int,
          ),
        )
        .toList();
    return entries;
  }

  Future<bool> queryLessonExistance(String exerciseTitle) async {
    final db = await database;

    print("Found db!");
    print("DB isOpen: ${db.isOpen}"); // bet this prints false
    final List<Map<String, dynamic>> results = await db.query(
      _completionTableName,
      where: '$_completionExerciseName = ?',
      whereArgs: [exerciseTitle],
    );
    print("Found entries!");

    return results.isNotEmpty;
  }

  Future<int> queryLessonCompletion(String exerciseTitle) async {
    final db = await database;

    final List<Map<String, dynamic>> results = await db.query(
      _completionTableName,
      where: '$_completionExerciseName = ?',
      whereArgs: [exerciseTitle],
    );
    if (results.isNotEmpty) {
      return results[0]["completed"];
    }
    return -1;
  }
}
