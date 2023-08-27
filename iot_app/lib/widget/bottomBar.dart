import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  // const Bottom({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(
                icon: Icon(
                  Icons.home,
                  size: 18,
                ),
                child: Text(
                  '홈',
                  style: TextStyle(
                    fontSize: 9,
                  ),
                )),
            Tab(
                icon: Image.asset('images/bottomBar/heartAttack.png',width: 18,height: 18,),
                text: '건강',
                  ),
            Tab(
                icon: Icon(
                  Icons.calendar_today,
                  size: 18,
                ),
                child: Text(
                  '일정',
                  style: TextStyle(
                    fontSize: 9,
                  ),
                )),
            Tab(
                icon: Icon(
                  Icons.person,
                  size: 18,
                ),
                child: Text(
                  '마이',
                  style: TextStyle(
                    fontSize: 9,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

