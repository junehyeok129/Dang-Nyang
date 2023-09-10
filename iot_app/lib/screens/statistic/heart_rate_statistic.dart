import 'package:flutter/material.dart';
import 'package:iot_app/screens/statistic/components/date_period_widget.dart';
import 'package:iot_app/screens/statistic/components/statistic_box.dart';
import 'package:iot_app/screens/statistic/components/text_info_widget.dart';

class HeartRateStatistic extends StatefulWidget {
  const HeartRateStatistic({super.key});

  @override
  State<HeartRateStatistic> createState() => _HeartRateStatisticState();
}

class _HeartRateStatisticState extends State<HeartRateStatistic> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '심박수',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 6),
        Expanded(
          child: ListView(
            children: [
              SizedBox(height: 6),
              DatePeriodWidget(
                onDatePeriodChanged: (datePeriod) {
                  // 날짜 변경
                },
              ),
              SizedBox(height: 14),
              TextInfoWidget(
                value: '68~72',
                suffix: 'BPM',
                date: '2023.08.01',
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
                  BoxData(title: '휴식기 심박수', data: '72~88'),
                  BoxData(title: '운동시 심박수', data: '62~88'),
                  BoxData(title: '고심박수 알림', data: '--'),
                  BoxData(title: '저심박수 알림', data: '--'),
                ],
                suffix: 'BPM',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
