import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:student_information/model_class.dart';

class MyDbHelper {
  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'contact.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    final sql =
        '''CREATE TABLE tbl_contact(id INTEGER PRIMARY KEY,name Text,phone Text,address Text, dob Text, gender Text, images Text)''';
    await db.execute(sql);
  }

  static Future<int> inserContact(Contact contact) async {
    Database db = await MyDbHelper.initDb();
    return await db.insert('tbl_contact', contact.toMap());
  }

  static Future<List<Contact>> readContact() async {
    Database db = await MyDbHelper.initDb();
    var contact = await db.query('tbl_contact');
    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        : [];
    return contactList;
  }

  static Future<int> updateContact(Contact contact) async {
    Database db = await MyDbHelper.initDb();
    return await db.update('tbl_contact', contact.toMap(),
        where: 'id =?', whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(int id) async {
    Database db = await MyDbHelper.initDb();

    return await db.delete('tbl_contact', where: 'id =?', whereArgs: [id]);
  }
}
