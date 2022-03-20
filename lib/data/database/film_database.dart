import 'package:movie_ticket/data/models/film_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FilmDatabase {
  static final FilmDatabase instance = FilmDatabase.init();

  static Database? _database;

  final textType = 'TEXT';
  final integerType = 'INTEGER';
  final boolType = 'BOOLEAN';
  final doubleType = 'DOUBLE';

  FilmDatabase.init();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB('film.db');
    return _database;
  }

  Future<Database?> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await createFilmsFavoriteTable(db);
    await createFilmsCartTable(db);
  }

  Future<void> createFilmsFavoriteTable(Database db) async {
    final sqlCreateTableFilm = '''
    CREATE TABLE $tableFavoriteFilm (
      ${FilmDataFields.adult} $boolType,
      ${FilmDataFields.backdropPath} $textType,
      ${FilmDataFields.id} $integerType UNIQUE NOT NULL,
      ${FilmDataFields.originalLanguage} $textType,
      ${FilmDataFields.originalTitle} $textType,
      ${FilmDataFields.overview} $textType,
      ${FilmDataFields.popularity} $doubleType,
      ${FilmDataFields.posterPath} $textType,
      ${FilmDataFields.releaseDate} $textType,
      ${FilmDataFields.title} $textType,
      ${FilmDataFields.video} $boolType,
      ${FilmDataFields.voteAverage} $doubleType,
      ${FilmDataFields.voteCount} $integerType )
    ''';

    await db.execute(sqlCreateTableFilm);
  }

  Future<void> createFilmsCartTable(Database db) async {
    final sqlCreateTableCart = '''
    CREATE TABLE $tableCartFilm (
      ${FilmDataFields.adult} $boolType,
      ${FilmDataFields.backdropPath} $textType,
      ${FilmDataFields.id} $integerType UNIQUE NOT NULL,
      ${FilmDataFields.originalLanguage} $textType,
      ${FilmDataFields.originalTitle} $textType,
      ${FilmDataFields.overview} $textType,
      ${FilmDataFields.popularity} $doubleType,
      ${FilmDataFields.posterPath} $textType,
      ${FilmDataFields.releaseDate} $textType,
      ${FilmDataFields.title} $textType,
      ${FilmDataFields.video} $boolType,
      ${FilmDataFields.voteAverage} $doubleType,
      ${FilmDataFields.voteCount} $integerType )
    ''';

    await db.execute(sqlCreateTableCart);
  }

  Future<int> addFilmsFavorite(FilmData filmData) async {
    final db = await instance.database;
    int id = await db!.insert(tableFavoriteFilm, filmData.toJsonDB());
    return id;
  }

  Future<bool> deleteFilmsFavoriteByID(int id) async {
    final db = await instance.database;
    int count = await db!.delete(tableFavoriteFilm,
        where: '${FilmDataFields.id} = ?', whereArgs: [id]);
    return count != 0 ? true : false;
  }

  Future<List<FilmData>?> readAllFilmsFavorite() async {
    final db = await instance.database;

    final maps = await db!.query(tableFavoriteFilm);
    if (maps.isNotEmpty) {
      return maps.map((element) => FilmData.fromJsonDB(element)).toList();
    } else {
      return null;
    }
  }

  Future<bool> checkFavorite(int id) async {
    final db = await instance.database;
    final result = await db!.rawQuery('''
    SELECT COUNT(*) FROM $tableFavoriteFilm WHERE ${FilmDataFields.id} LIKE '$id'
    ''');
    return result.first['COUNT(*)'] as int != 0 ? true : false;
  }

  Future<int> addFilmsCart(FilmData filmData) async {
    final db = await instance.database;
    int id = await db!.insert(tableCartFilm, filmData.toJsonDB());
    return id;
  }

  Future<bool> deleteFilmsCartByID(int id) async {
    final db = await instance.database;
    int count = await db!.delete(tableCartFilm,
        where: '${FilmDataFields.id} = ?', whereArgs: [id]);
    return count != 0 ? true : false;
  }

  Future<List<FilmData>?> readAllFilmsCart() async {
    final db = await instance.database;

    final maps = await db!.query(tableCartFilm);
    if (maps.isNotEmpty) {
      return maps.map((element) => FilmData.fromJsonDB(element)).toList();
    } else {
      return null;
    }
  }

  Future<bool> checkCart(int id) async {
    final db = await instance.database;
    final result = await db!.rawQuery('''
    SELECT COUNT(*) FROM $tableCartFilm WHERE ${FilmDataFields.id} LIKE '$id'
    ''');
    return result.first['COUNT(*)'] as int != 0 ? true : false;
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
