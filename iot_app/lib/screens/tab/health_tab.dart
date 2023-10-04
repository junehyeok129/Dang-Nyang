import 'package:flutter/material.dart';
import 'package:iot_app/screens/statistic/statistic_screen.dart';

class HealthTab extends StatefulWidget {
  const HealthTab({super.key});

  @override
  State<HealthTab> createState() => _HealthTabState();
}

class _HealthTabState extends State<HealthTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        button(
          text: '심박수',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StatisticScreen(initialPage: 0);
                },
              ),
            );
          },
        ),
        SizedBox(height: 14),
        button(
          text: '체온',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StatisticScreen(initialPage: 1);
                },
              ),
            );
          },
        ),
        SizedBox(height: 14),
        button(
          text: '걸음수',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StatisticScreen(initialPage: 2);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget button({required String text, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xffefdaa3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
