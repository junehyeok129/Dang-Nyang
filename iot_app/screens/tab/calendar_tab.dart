import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  @override
  Widget build(BuildContext context) {
    return MonthView(
      controller: EventController(),
      borderColor: Color(0xfffff1cd),
      headerBuilder: (date) {
        return Container(
          height: 50,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color(0xfffff1cd),
          ),
          alignment: Alignment.center,
          child: Text(
            DateFormat('yyyy년 MM월').format(date),
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        );
      },
      weekDayBuilder: (day) {
        var format = '';
        switch (day) {
          case 1:
            format = '월';
          case 2:
            format = '화';
          case 3:
            format = '수';
          case 4:
            format = '목';
          case 5:
            format = '금';
          case 6:
            format = '토';
          default:
            format = '일';
        }

        return Container(
          height: 50,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color(0xfff9e9bd),
            border: Border.all(color: Color(0xfffff1cd), width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            format,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        );
      },
      cellBuilder: (date, event, isToday, isInMonth) {
        return Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Color(0xfff9e9bd),
          ),
          alignment: Alignment.topCenter,
          child: Text(
            '${date.day}',
            style: TextStyle(
              fontSize: 12,
              color: isInMonth ? Colors.black : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
