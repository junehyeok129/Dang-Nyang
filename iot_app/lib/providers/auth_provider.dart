import 'package:flutter/foundation.dart';

class AuthProvider with ChangeNotifier {
  String? _username;
  String? _password;

  String? get username => _username;
  String? get password => _password;

  Future<bool> login(String username, String password) async {
    // 여기에서 로그인 로직을 구현합니다.
    // 실제로는 서버와 통신하여 로그인을 시도하고 성공 여부를 확인해야 합니다.
    
    // 예제에서는 간단하게 username과 password를 저장하고 성공으로 가정합니다.
    _username = username;
    _password = password;
    notifyListeners();

    return true; // 로그인 성공 시 true 반환
  }
}
