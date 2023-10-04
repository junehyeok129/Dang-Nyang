import 'package:flutter/material.dart';

class BoxData {
  const BoxData({
    required this.title,
    required this.data,
  });

  final String title;
  final String data;
}

class StatisticBox extends StatefulWidget {
  const StatisticBox({
    required this.data,
    required this.suffix,
    super.key,
  });

  final List<BoxData> data;
  final String suffix;

  @override
  State<StatisticBox> createState() => _StatisticBoxState();
}

class _StatisticBoxState extends State<StatisticBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Color(0xfff9e9bd),
      child: Column(
        children: seperatorList(
          widget.data
              .map((e) => statisticWidget(
                    title: e.title,
                    value: e.data,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget statisticWidget({
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xfffae2a2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 4),
          Text(
            widget.suffix,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }

  List<Widget> seperatorList(List<Widget> list) {
    final result = <Widget>[];

    for (var e in list) {
      result.add(e);
      result.add(SizedBox(height: 8));
    }

    if (result.isNotEmpty) result.removeLast();

    return result;
  }
}
