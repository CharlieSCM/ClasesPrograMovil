import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.now().subtract(Duration(days: 7)),
              lastDay: DateTime.now().add(Duration(days: 7)),
              focusedDay: DateTime.now(),
              onDaySelected: (date, focusedDay) {
                print(date);
              },
            ),
          ],
        ),
      ),
    );
  }
}