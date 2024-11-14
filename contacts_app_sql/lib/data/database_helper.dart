import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Contact {
  final int? id;
  final String name;
  final String phone;

  // Constructor for creating a Contact object
  Contact({this.id, required this.name, required this.phone});

  // Converts the Contact object to a Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  // Converts a Map to a Contact object (for reading from the database)
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}

// Database manager class
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance; // Singleton pattern
  DatabaseHelper._internal();

  static Database? _database;

  // Lazy-loaded database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database (creates the file and table)
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate:
          _createDb, // Creates the table when the database is first created
    );
  }

  // Creates the "contacts" table in the database
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');
  }

// Inserts a new contact into the database
  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  // Fetches all contacts from the database
  Future<List<Contact>> fetchAllContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');
    return List<Contact>.from(maps.map((map) => Contact.fromMap(map)));
  }

  // Updates an existing contact in the database
  Future<int> updateContact(Contact contact) async {
    final db = await database;
    return await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  // Deletes a contact by its ID
  Future<int> deleteContact(int id) async {
    final db = await database;
    return await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clears all contacts from the database
  Future<void> clearDatabase() async {
    final db = await database;
    await db.execute('DELETE FROM contacts');
  }
}
