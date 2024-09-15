import 'package:path/path.dart'; // Import path for database path operations
import 'package:sqflite/sqflite.dart'; // Import sqflite for database operations
import 'package:flutter_contact_crud/models/contact.dart'; // Import your Contact model

class ContactService {
  static final ContactService _instance = ContactService._internal();
  factory ContactService() => _instance;
  static Database? _database; // Make _database nullable

  ContactService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!; // Return existing database if it's not null
    _database = await _initDatabase(); // Initialize the database if it's null
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'contacts.db'), // Properly join database path
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phoneNumber TEXT, email TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertContact(Contact contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> contacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
      return Contact(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phoneNumber: maps[i]['phoneNumber'],
        email: maps[i]['email'],
      );
    });
  }

  Future<void> updateContact(Contact contact) async {
    final db = await database;
    await db.update(
      'contacts',
      contact.toMap(),
      where: "id = ?",
      whereArgs: [contact.id],
    );
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete(
      'contacts',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
