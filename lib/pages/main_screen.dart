import 'dart:async';
import 'package:calendar_test_project/pages/calendar_screen.dart';
import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:calendar_test_project/widgets/ellips_widget.dart';
import 'package:calendar_test_project/widgets/mood_buttons_widget.dart';
import 'package:calendar_test_project/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String currentDate = '';

  @override
  void initState() {
    super.initState();
    _initializeDate();
  }

  //timer
  Future<void> _initializeDate() async {
    await initializeDateFormatting('ru_RU', null);
    setState(() {
      currentDate = DateFormat('d MMMM H:mm', 'ru_RU').format(DateTime.now());
    });
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentDate =
              DateFormat('d MMMM H:mm', 'ru_RU').format(DateTime.now());
        });
      }
    });
  }

  //for sliders
  double _currentSliderValue = 40;
  double _currentSliderValue2 = 40;

  //for ellipse
  bool _tappedHappy = false;
  bool _tappedFear = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.backgroundWhiteColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            currentDate.isEmpty ? 'Загрузка...' : currentDate,
            style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarScreen()),
                );
              },
              icon: Image.asset('assets/icons/calendar.png',
                  width: 24, height: 24),
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  SizedBox(height: 30),
                  Text(
                    'Что чувствуешь?',
                    style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 118,
                    child: ListView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          child: EllipseWidget(
                              url: 'assets/pics/happy.png', text: 'Радость'),
                          onTap: () {
                            _tappedHappy = !_tappedHappy;
                          },
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          child: EllipseWidget(
                              url: 'assets/pics/fear.png', text: 'Страх'),
                          onTap: () {
                            _tappedFear = !_tappedFear;
                          },
                        ),
                        SizedBox(width: 12),
                        EllipseWidget(
                            url: 'assets/pics/rage.png', text: 'Бешенство'),
                        SizedBox(width: 12),
                        EllipseWidget(
                            url: 'assets/pics/sad.png', text: 'Грусть'),
                        SizedBox(width: 12),
                        EllipseWidget(
                            url: 'assets/pics/calmness.png',
                            text: 'Спокойствие'),
                        SizedBox(width: 12),
                        EllipseWidget(
                            url: 'assets/pics/power.png', text: 'Сила'),
                      ],
                    ),
                  ),
                  if (_tappedHappy)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodButtonsWidget(text: 'Возбуждение'),
                              MoodButtonsWidget(text: 'Восторг'),
                              MoodButtonsWidget(text: 'Игривость'),
                              MoodButtonsWidget(text: 'Наслаждение'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodButtonsWidget(text: 'Очарование'),
                              MoodButtonsWidget(text: 'Осознанность'),
                              MoodButtonsWidget(text: 'Смелость'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodButtonsWidget(text: 'Удовольствие'),
                              MoodButtonsWidget(text: 'Чувственность'),
                              MoodButtonsWidget(text: 'Энергичность'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MoodButtonsWidget(text: 'Экстравагантность'),
                          ],
                        ),
                      ],
                    ),
                  if (_tappedFear)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodButtonsWidget(text: 'Грусть'),
                              MoodButtonsWidget(text: 'Депрессия'),
                              MoodButtonsWidget(text: 'Игривость'),
                              MoodButtonsWidget(text: 'Наслаждение'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 120),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodButtonsWidget(text: 'Очарование'),
                              MoodButtonsWidget(text: 'Осознанность'),
                              MoodButtonsWidget(text: 'Смелость'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MoodButtonsWidget(text: 'Удовольствие'),
                              MoodButtonsWidget(text: 'Чувственность'),
                              MoodButtonsWidget(text: 'Энергичность'),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MoodButtonsWidget(text: 'Экстравагантность'),
                          ],
                        ),
                      ],
                    ),
                  SizedBox(height: 36),
                  Text(
                    'Уровень стресса',
                    style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  SliderWidget(
                    currentSliderValue: _currentSliderValue,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                    StringMin: 'Низкий',
                    StringMax: 'Высокий',
                  ),
                  SizedBox(height: 36),
                  Text(
                    'Самооценка',
                    style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  SliderWidget(
                    currentSliderValue: _currentSliderValue2,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue2 = value;
                      });
                    },
                    StringMin: 'Неуверенность',
                    StringMax: 'Уверенность',
                  ),
                  SizedBox(height: 36),
                  Text(
                    'Заметки',
                    style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Color(0xFFB6A1C0).withOpacity(0.1),
                          offset: Offset(2, 4),
                          blurRadius: 10.8,
                          spreadRadius: 0),
                    ], borderRadius: BorderRadius.circular(20.0)),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Введите заметку',
                        filled: true,
                        fillColor: Colors.white, // Цвет фона
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
