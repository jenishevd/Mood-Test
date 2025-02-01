import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final List<String> months = List.generate(12, (index) {
    DateTime monthDate = DateTime(DateTime.now().year, index + 1, 1);
    return monthDate.monthNameCapitalized();
  });

  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    initializeDateFormatting('ru_RU', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: AppColors.textGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text('Сегодня',
                style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              DateFormat('yyyy').format(DateTime.now()),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return MonthCalendar(month: index + 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthCalendar extends StatefulWidget {
  final int month;
  const MonthCalendar({required this.month});

  @override
  _MonthCalendarState createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime firstDay = DateTime(DateTime.now().year, widget.month, 1);
    int daysInMonth = DateTime(firstDay.year, firstDay.month + 1, 0).day;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            firstDay.monthNameCapitalized(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(4.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: daysInMonth,
            itemBuilder: (context, index) {
              DateTime currentDate =
                  DateTime(DateTime.now().year, widget.month, index + 1);
              bool isToday = currentDate.day == today.day &&
                  currentDate.month == today.month &&
                  currentDate.year == today.year;

              return Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isToday
                      ? Colors.orange.withOpacity(0.5)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isToday ? Colors.white : Colors.black,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

extension DateTimeExtensions on DateTime {
  String monthNameCapitalized() {
    return DateFormat.MMMM('ru_RU').format(this)[0].toUpperCase() +
        DateFormat.MMMM('ru_RU').format(this).substring(1);
  }
}
