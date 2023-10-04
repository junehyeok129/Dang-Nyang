import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:iot_app/screens/tab/settingScreen.dart';
=======
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40

class MyTab extends StatefulWidget {
  const MyTab({super.key});

  @override
  State<MyTab> createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        profileWidget(310),
        SizedBox(height: 36),
        myBoxWidget(),
        SizedBox(height: 20),
        listWrapWidget(),
      ],
    );
  }

  Widget profileWidget(int days) {
    return Column(
      children: [
        SizedBox(height: 30),
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '삐삐와 함께한지 ',
              ),
              TextSpan(
                text: '$days',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffff0099),
                ),
              ),
              TextSpan(
                text: '일',
              )
            ],
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '말티푸/여아',
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget myBoxWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffffe297),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          myWidget('assets/images/report.png', '이상 징후 기록'),
          myWidget('assets/images/siren.png', '응급센터'),
<<<<<<< HEAD
          myWidget('assets/images/setting.png', '환경설정', onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SettingsScreen()),
  );
}),
=======
          myWidget('assets/images/setting.png', '환경설정'),
>>>>>>> 2f22ee43d93b3984ce0057dc7bbfd5d6f9725e40
        ],
      ),
    );
  }

  Widget myWidget(
    String asset,
    String title, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            asset,
            width: 70,
            height: 70,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget listWrapWidget() {
    return Column(
      children: [
        listWidget('공지'),
        listWidget('자주 묻는 질문'),
        listWidget('내원기록 모아보기'),
        listWidget('댕냥워치 친구소식 바로가기'),
        listWidget('문의하기'),
      ],
    );
  }

  Widget listWidget(
    String title, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
