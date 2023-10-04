import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:iot_app/screens/statistic/components/date_period_widget.dart';
import 'package:iot_app/screens/statistic/components/statistic_box.dart';
import 'package:iot_app/screens/statistic/components/text_info_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'dart:convert';

class HeartRateStatistic extends StatefulWidget {
  const HeartRateStatistic({Key? key}) : super(key: key);

  @override
  State<HeartRateStatistic> createState() => _HeartRateStatisticState();
}
class HeartRateData {
  final DateTime time;
  final int heartRate;

  HeartRateData({required this.time, required this.heartRate});

  factory HeartRateData.fromJson(Map<String, dynamic> json) {
    return HeartRateData(
      time: DateTime.parse(json['Time']),
      heartRate: json['HeartRate'],
    );
  }
}
class _HeartRateStatisticState extends State<HeartRateStatistic> {
  List<DataPoint> heartRateData = [];

  @override
  void initState() {
    super.initState();
    fetchHeartRateData();
  }

  Future<void> fetchHeartRateData() async {
    final apiUrl = 'http://127.0.0.1:5000/get_heart_rate_data'; // Flask 서버의 URL로 변경
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      String jsonString = jsonDecode(response.body);
      print(jsonString);
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      print(jsonResponse);
      print(jsonResponse.runtimeType);
      final data = jsonResponse.map((item) {
        final DateTime date = DateTime.parse(item['Time']);
        final double heartRate = item['HeartRate'];
        return DataPoint(date, heartRate);

      }).toList();

      setState(() {
        heartRateData = data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

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
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(
                    labelStyle: TextStyle(color: Colors.black), // X축 글자 색상 변경
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(color: Colors.black), // Y축 글자 색상 변경
                  ),
                  series: <ChartSeries>[
                    LineSeries<DataPoint, DateTime>(
                      dataSource: heartRateData,
                      xValueMapper: (DataPoint data, _) => data.time,
                      yValueMapper: (DataPoint data, _) => data.heartRate,
                    ),
                  ],
                  // 그래프를 터치하면 해당 정보를 표시
                  tooltipBehavior: TooltipBehavior(enable: true),
                ),
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

class DataPoint {
  final DateTime time;
  final double heartRate;

  DataPoint(this.time, this.heartRate);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('심박수 그래프'),
        ),
        body: HeartRateStatistic(),
      ),
    );
  }
}
