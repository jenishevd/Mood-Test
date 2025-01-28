import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

DateTime today = DateTime.now();

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TableCalendar(
                  focusedDay: today,
                  firstDay: DateTime(2025),
                  lastDay: DateTime(2025, 12, 31))
            ],
          ),
        ),
      ),
    );
  }
}
