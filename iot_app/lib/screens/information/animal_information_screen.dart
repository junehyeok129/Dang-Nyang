import 'package:flutter/material.dart';
import 'package:iot_app/widget/animal_profile.dart';
import 'package:iot_app/widget/custom_pie_chart.dart';

class AnimalInformationScreen extends StatefulWidget {
  const AnimalInformationScreen({super.key});

  @override
  State<AnimalInformationScreen> createState() =>
      _AnimalInformationScreenState();
}

class _AnimalInformationScreenState extends State<AnimalInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff1cd),
      body: SafeArea(
        child: Column(
          children: [
            AnimalProfile(
              name: '삐삐',
              type: '말티푸/여아',
            ),
            Expanded(
              child: Column(
                children: [
                  donutChartWidget(),
                  SizedBox(height: 30),
                  animalStatusWidget(),
                  SizedBox(height: 30),
                  Image.asset('assets/images/pets.png'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget donutChartWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPieChart(
          value: 40,
          height: 180,
          width: 180,
          lineWidth: 6,
          backColor: Color(0xffEFDAA3),
          valueColor: Colors.white,
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(150),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '0%',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/thermometer.png'),
                    SizedBox(width: 4),
                    Text(
                      '36.5 C',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/heart-attack.png'),
                    SizedBox(width: 4),
                    Text(
                      '88BPM',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget animalStatusWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: EdgeInsets.symmetric(horizontal: 42),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Text(
        '삐삐는 휴식 중이에요',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xffffb800),
        ),
      ),
    );
  }
}
