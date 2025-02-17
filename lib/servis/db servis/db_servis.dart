import 'package:adv_exam_2/model/book_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static DbHelper dbHelper = DbHelper._();

  Database? _database;
  final String tebName = 'book';

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initData();
      return _database;
    }
  }

  Future<Database> initData() async {
    final filePath = await getDatabasesPath();
    final dbPath = path.join(filePath, "myDb.db");

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tebName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, genre TEXT, status TEXT, rating INTEGER)');
      },
    );
  }

  Future<void> addData(
    var title,
    var author,
    var genre,
    var status,
    var rating,
  ) async {
    final db = await database;
    String sql =
        "INSERT INTO $tebName(title, author, genre, status, rating) VALUES(?,?,?,?,?)";
    List r = [title, author, genre, status, rating];
    await db!.rawInsert(sql, r);
  }

  Future<void> update(BookModel book) async {
    final db = await database;
    db!.update(
      tebName,
      BookModel.toMap(book),
      where: "id = ?",
      whereArgs: [book.id],
    );
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    db!.delete(tebName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> readData() async {
    final db = await database;
    return await db!.query(tebName);
  }
}
