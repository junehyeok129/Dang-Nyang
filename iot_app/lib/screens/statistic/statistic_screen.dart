import 'package:flutter/material.dart';
import 'package:iot_app/screens/statistic/body_temperature_statistic.dart';
import 'package:iot_app/screens/statistic/heart_rate_statistic.dart';
import 'package:iot_app/screens/statistic/step_count_statistic.dart';
import 'package:iot_app/widget/animal_profile.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({
    required this.initialPage,
    super.key,
  });

  final int initialPage;

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF1CD),
      body: SafeArea(
        child: Column(
          children: [
            AnimalProfile(
              name: '삐삐',
              type: '말티푸/여아',
            ),
            SizedBox(height: 10),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HeartRateStatistic(),
                  BodyTemperatureStatistic(),
                  StepCountStatistic(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
