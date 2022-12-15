import 'package:sqflite/sqflite.dart';

OnDatabaseCreateFn createDatabase = (db, version) async {
  await db.execute('''
    CREATE TABLE plant (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      gone TEXT
    )
  ''');
  await db.execute('''
    CREATE TABLE plant_log (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      plantId INTEGER NOT NULL,
      photo TEXT,
      description TEXT NOT NULL,
      writtenAt TEXT NOT NULL,
      types TEXT NOT NULL
    )
  ''');
  await db.execute('''
    CREATE TABLE schedule (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      duration TEXT,
      dateTime TEXT,
      done INTEGER NOT NULL,
      plantId INTEGER
    )
  ''');
};

class Queries {
  //
  // Plant
  //

  static const String insertOrUpdatePlant = '''
    INSERT OR REPLACE INTO plant (id, name, createdAt, gone)
    VALUES (?, ?, ?, ?)
  ''';

  static const String queriesAllPlants = '''
    SELECT * FROM plant
  ''';

  static const String deletePlant = '''
    DELETE FROM plant WHERE id = ?
  ''';

  //
  // Log
  //

  static const String insertNewPlantLogEntry = '''
    INSERT INTO plant_log_entry (id, plant_id, photo, description, writtenAt, types)
    VALUES (?, ?, ?, ?, ?, ?)
  ''';

  static const String queriesAllPlantLogs = '''
    SELECT * FROM plant_log_entry
  ''';

  static const String updatePlantLogEntry = '''
    UPDATE plant_log_entry SET photo = ?, description = ?, writtenAt = ?, types = ?
    WHERE id = ?
  ''';

  static const String deletePlantLogEntry = '''
    DELETE FROM plant_log_entry WHERE id = ?
  ''';
}
