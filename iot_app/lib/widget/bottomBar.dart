import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({this.onTap, Key? key}) : super(key: key);

  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Color(0xffffb800),
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.transparent,
          onTap: onTap,
          tabs: [
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Icon(
                Icons.home_outlined,
                size: 22,
              ),
              child: Text(
                '홈',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Icon(
                Icons.heart_broken_outlined,
                size: 22,
              ),
              child: Text(
                '건강',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 22,
              ),
              child: Text(
                '일정',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
            Tab(
              iconMargin: EdgeInsets.zero,
              icon: Icon(
                Icons.person_outlined,
                size: 22,
              ),
              child: Text(
                '마이',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
