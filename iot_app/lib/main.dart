import 'package:flutter/material.dart';
import 'package:iot_app/screens/home_screen.dart'; // 홈 화면 파일을 불러옴
import 'package:iot_app/screens/login_screen.dart'; // 로그인 화면 파일을 불러옴

void main(List<String> args) {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "댕냥워치",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      home: LoginScreen(), // 초기 화면으로 로그인 화면을 설정
    );
  }
}
