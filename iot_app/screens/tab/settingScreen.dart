import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // SharedPreferences를 사용하기 위해 추가
import 'package:iot_app/screens/home_screen.dart';
import 'package:iot_app/screens/login_screen.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('환경설정'),
      ),
      body: Container(
        color: Color(0xfffff1cd),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _logout(context);
                },
                child: Text('로그아웃'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 로그아웃 함수
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
