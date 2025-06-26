import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:visit_tracker/app/data/providers/local_data_provider/db_fields/activities_fields.dart';
import 'db_fields/customer_fields.dart';

class CreateDatabase {
  static const _version = 3;
  static const String _dbName = "visits.db";
  static Database? _database;

  static Future<Database> getDB() async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);

    return await openDatabase(
      path,
      version: _version,
      onCreate: _createTable,
      onConfigure: _configureDatabase,
    );
  }

  static Future<void> _configureDatabase(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  static Future<void> _createTable(Database db, int version) async {
    await _createCustomerTable(db);
    await _createCustomerActivitiesTable(db);
  }

  static Future<void> _createCustomerTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS ${CustomerFields.customerTableName}(
    ${CustomerFields.id} TEXT PRIMARY KEY,
    ${CustomerFields.customerName} TEXT NOT NULL
    )
    ''');

    //Creating index for faster queries
    await db.execute('''
    CREATE INDEX IF NOT EXISTS idx_customer_name
    ON ${CustomerFields.customerTableName}(${CustomerFields.customerName})
    ''');
  }

  static Future<void> _createCustomerActivitiesTable(Database db) async {
    try {
      await db.execute('''
    CREATE TABLE IF NOT EXISTS ${ActivitiesFields.activitiesTableName}(
    ${ActivitiesFields.id} TEXT PRIMARY KEY,
    ${ActivitiesFields.activity} TEXT,
    ${ActivitiesFields.description} TEXT,
    ${ActivitiesFields.location} TEXT NOT NULL,
    ${ActivitiesFields.status} TEXT,
    ${ActivitiesFields.createdAt} TEXT NOT NULL,
    ${ActivitiesFields.customerId} TEXT NOT NULL
    )
    ''');

      //Creating index for faster queries
      await db.execute('''
    CREATE INDEX IF NOT EXISTS idx_activity
    ON ${ActivitiesFields.activitiesTableName}(${ActivitiesFields.activity})
    ''');
    } catch (error) {
      print("=======.activity table error $error");
    }
  }
}
