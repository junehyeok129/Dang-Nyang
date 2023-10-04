import 'package:flutter/material.dart';
import 'package:iot_app/screens/home_screen.dart';
import 'package:iot_app/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff1cd),
      appBar: AppBar(
        backgroundColor: Color(0xfffff1cd),
        title: Text('로그인',
          style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
              labelText: 'ID',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // 포커스된 입력 필드의 박스 색상
              ),
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // 비활성화된 입력 필드의 박스 색상
              ),
                ),
              style: TextStyle(color: Colors.black), // 텍스트 색상
            ),
            SizedBox(height: 8),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // 포커스된 입력 필드의 박스 색상
              ),
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black), // 비활성화된 입력 필드의 박스 색상
              ),
                ),
              style: TextStyle(color: Colors.black), // 텍스트 색상
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(BuildContext context) async {
  String username = _usernameController.text;
  String password = _passwordController.text;

  final response = await http.post(
    Uri.parse('http://127.0.0.1:5000/login'), // 실제 서버 주소로 변경
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    if (responseData['success']) {
      // SharedPreferences를 사용하여 로그인 상태를 저장
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('ID 또는 비밀번호가 일치하지 않습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('에러'),
          content: Text('로그인 실패.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
}