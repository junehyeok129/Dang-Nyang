import 'package:flutter/material.dart';

enum DatePeriod {
  week,
  month,
  year,
}

class DatePeriodWidget extends StatefulWidget {
  const DatePeriodWidget({
    required this.onDatePeriodChanged,
    super.key,
  });

  final Function(DatePeriod datePeriod) onDatePeriodChanged;

  @override
  State<DatePeriodWidget> createState() => _DatePeriodWidgetState();
}

class _DatePeriodWidgetState extends State<DatePeriodWidget> {
  DatePeriod _datePeriod = DatePeriod.week;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 24),
        dateWidget(
          '1주',
          _datePeriod == DatePeriod.week,
          () {
            setState(() {
              _datePeriod = DatePeriod.week;
            });
            widget.onDatePeriodChanged(_datePeriod);
          },
        ),
        dateWidget(
          '1개월',
          _datePeriod == DatePeriod.month,
          () {
            setState(() {
              _datePeriod = DatePeriod.month;
            });
            widget.onDatePeriodChanged(_datePeriod);
          },
        ),
        dateWidget(
          '1년',
          _datePeriod == DatePeriod.year,
          () {
            setState(() {
              _datePeriod = DatePeriod.year;
            });
            widget.onDatePeriodChanged(_datePeriod);
          },
        ),
        SizedBox(width: 24),
      ],
    );
  }

  Widget dateWidget(String date, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: 50,
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffefdaa3) : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
