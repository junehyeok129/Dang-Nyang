import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> openDatabaseHelper() async {
    return openDatabase(
      join(await getDatabasesPath(), 'data.db'),
      version: 1,
    );
  }

Future<bool> login(String username, String password) async {
  final db = await openDatabaseHelper();

  final userResult = await db.query(
    'User',
    columns: ['Password'], // Select only the 'Password' column
    where: 'ID = ?',
    whereArgs: [username],
  );
  print(username);
  print(userResult);
  if (userResult.isEmpty) {
    // 사용자가 존재하지 않을 경우
    return false;
  }

  final user = userResult.first;
  final savedPassword = user['Password'];

  if (password == savedPassword) {
    // 비밀번호가 일치할 경우
    return true;
  } else {
    // 비밀번호가 일치하지 않을 경우
    return false;
  }
}
Future<bool> isUsernameAvailable(String username) async {
    final db = await openDatabaseHelper();
    final userResult = await db.query(
      'User',
      columns: ['ID'],
      where: 'ID = ?',
      whereArgs: [username],
    );
    return userResult.isEmpty;
  }

}

