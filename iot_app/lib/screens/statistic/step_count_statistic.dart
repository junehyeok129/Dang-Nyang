import 'package:flutter/material.dart';
import 'package:iot_app/screens/statistic/components/statistic_box.dart';

class StepCountStatistic extends StatefulWidget {
  const StepCountStatistic({super.key});

  @override
  State<StepCountStatistic> createState() => _StepCountStatisticState();
}

class _StepCountStatisticState extends State<StepCountStatistic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '걸음수',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.arrow_left,
                      color: Color(0xffEFDAA3),
                    ),
                  ),
                  Text(
                    '2021.08.01',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.arrow_right,
                      color: Color(0xffEFDAA3),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      'Total Steps',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(width: 6),
                    Text(
                      '11301',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                height: 180,
                width: double.infinity,
                color: Colors.grey[350],
                child: Text('그래프 그리기'),
              ),
              SizedBox(height: 28),
              StatisticBox(
                data: [
                  BoxData(title: '하루당 걸음수', data: '11,100'),
                  BoxData(title: '어제 걸음수', data: '12,001'),
                  BoxData(title: '이번주 걸음수', data: '142,120'),
                  BoxData(title: '지난주 걸음수', data: '142,120'),
                ],
                suffix: 'step',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
