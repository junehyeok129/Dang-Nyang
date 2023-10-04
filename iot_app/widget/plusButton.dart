import 'package:flutter/material.dart';

class PlusButtonPage extends StatelessWidget {
  final int number1;
  final int number2;

  PlusButtonPage({required this.number1, required this.number2});

  @override
  Widget build(BuildContext context) {
    int result = number1 + number2;

    return Scaffold(
      appBar: AppBar(
        title: Text("더하기 결과"),
      ),
      body: Center(
        child: Text(
          "더하기 결과: $result",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
