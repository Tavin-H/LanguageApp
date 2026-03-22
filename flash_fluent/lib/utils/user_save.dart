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

  final String _lessonTableName = "completion";

  final String _lessonIdColumnName = "id";
  final String _lessonExerciseName = "exercise";
  final String _lessonCompletedColumnName = "completed";
  final String _lessonBookmarkedColumnName = "bookmarked";

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
      CREATE TABLE IF NOT EXISTS $_lessonTableName (
        $_lessonIdColumnName INTEGER PRIMARY KEY,
        $_lessonExerciseName TEXT NOT NULL,
        $_lessonCompletedColumnName INT,
				$_lessonBookmarkedColumnName INT
      )
    ''');
      },
      onOpen: (db) async {
        await db.execute('''
      CREATE TABLE IF NOT EXISTS $_lessonTableName (
        $_lessonIdColumnName INTEGER PRIMARY KEY,
        $_lessonExerciseName TEXT NOT NULL,
        $_lessonCompletedColumnName INT,
				$_lessonBookmarkedColumnName INT
      )
    ''');
      },
    );
    return database;
  }

  void purgeData() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "save_data.db");

    if (_db != null) {
      await _db!.close();
      _db = null;
    }

    await deleteDatabase(databasePath);
    print("Database deleted and reset!");
  }

  Future<void> addEntry(String exercise, int completed, int bookmarked) async {
    final db = await database;
    await db.insert(_lessonTableName, {
      _lessonExerciseName: exercise,
      _lessonCompletedColumnName: completed,
      _lessonBookmarkedColumnName: bookmarked,
    });
  }

  Future<List<CompletionEntry>> getEntries() async {
    final db = await database;
    final data = await db.query(_lessonTableName);
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

    final List<Map<String, dynamic>> results = await db.query(
      _lessonTableName,
      where: '$_lessonExerciseName = ?',
      whereArgs: [exerciseTitle],
    );

    return results.isNotEmpty;
  }

  Future<(int, int)> queryLessonInfo(String exerciseTitle) async {
    final db = await database;
    print("Checking for $exerciseTitle");

    final List<Map<String, dynamic>> results = await db.query(
      _lessonTableName,
      where: '$_lessonExerciseName = ?',
      whereArgs: [exerciseTitle],
    );
    if (results.isNotEmpty) {
      return (results[0]["completed"] as int, results[0]["bookmarked"] as int);
    }
    return (-1, -1);
  }

  Future<int> queryLessonBookmarked(String exerciseTitle) async {
    final db = await database;

    final List<Map<String, dynamic>> results = await db.query(
      _lessonTableName,
      where: '$_lessonExerciseName = ?',
      whereArgs: [exerciseTitle],
    );
    if (results.isNotEmpty) {
      return results[0]["bookmarked"];
    }
    return -1;
  }

  Future<bool> saveCompletedLesson(String exerciseTitle, bool completed) async {
    final integerBool = completed ? 1 : 0;
    final db = await database;

    bool exists = await queryLessonExistance(exerciseTitle);

    if (exists) {
      int count = await db.update(
        _lessonTableName,
        {_lessonCompletedColumnName: integerBool}, // The data to update
        where: '$_lessonExerciseName = ?', // The filter
        whereArgs: [exerciseTitle], // The value for the filter
      );
      return count == 1;
    } else {
      await addEntry(exerciseTitle, integerBool, 0);
      return true;
    }
  }

  Future<bool> saveBookmarkLesson(String exerciseTitle, bool bookmarked) async {
    final integerBool = bookmarked ? 1 : 0;
    final db = await database;

    bool exists = await queryLessonExistance(exerciseTitle);

    if (exists) {
      print("Lesson exits $integerBool");
      int count = await db.update(
        _lessonTableName,
        {_lessonBookmarkedColumnName: integerBool}, // The data to update
        where: '$_lessonExerciseName = ?', // The filter
        whereArgs: [exerciseTitle], // The value for the filter
      );
      return count == 1;
    } else {
      print("Lesson does not exist $integerBool");
      await addEntry(exerciseTitle, 0, integerBool);
      return true;
    }
  }
}
