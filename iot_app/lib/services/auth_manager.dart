import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static const String _keyUserId = 'user_id';

  static Future<void> storeUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_keyUserId, userId);
  }

  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserId);
  }

  static Future<void> clearUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyUserId);
  }
}
