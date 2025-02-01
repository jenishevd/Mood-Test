import 'dart:async';
import 'package:calendar_test_project/widgets/ellips_widget.dart';
import 'package:calendar_test_project/widgets/mood_buttons_widget.dart';
import 'package:calendar_test_project/widgets/slider_widget.dart';
import 'package:calendar_test_project/widgets/statistics_widget.dart';
import 'package:calendar_test_project/widgets/tapbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'calendar_screen.dart';
import 'utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String currentDate = '';
  int? activeIndex; // Активный индекс выбранной эмоции
  int? selectedMoodIndex; // Индекс выбранной под-кнопки
  int? selectedParentIndex; // Индекс выбранной родительской кнопки
  int selectedTabIndex =
      0; // Индекс выбранной вкладки (0 - "Дневник настроения", 1 - "Статистика")
  TextEditingController _controller = TextEditingController();
  double _currentSliderValue = 5;
  double _currentSliderValue2 = 5;

  bool get isSaveEnabled =>
      selectedMoodIndex != null &&
      selectedParentIndex != null &&
      _currentSliderValue > 0 &&
      _currentSliderValue2 > 0 &&
      _controller.text.isNotEmpty;

  void _showSavedPopup(String label) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(label),
            actions: <Widget>[
              TextButton(
                child: Text('Закрыть'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  bool _isVisible = false;
  void _toggleStatistic() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeDate();
  }

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

  final List<List<String>> moodSubmenus = [
    [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Осознанность',
      'Смелось',
      'Удовольствие',
      'Чувственность',
      'Энергичность',
    ],
    ['Грусть', 'Депрессия', 'Тревожность'],
    ['Злость', 'Агрессия', 'Негодование'],
    ['Тоска', 'Печаль', 'Сожаление'],
    ['Расслабленность', 'Миролюбие'],
    ['Энергия', 'Сила', 'Воодушевление'],
  ];

  String getEmotionText(int index) {
    const emotions = [
      'Радость',
      'Страх',
      'Злость',
      'Грусть',
      'Спокойствие',
      'Сила'
    ];
    return emotions[index];
  }

  String getEmotionImage(int index) {
    const images = ['happy', 'fear', 'rage', 'sad', 'calmness', 'power'];
    return images[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          currentDate.isEmpty ? 'Загрузка...' : currentDate,
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
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
            icon:
                Image.asset('assets/icons/calendar.png', width: 24, height: 24),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Ваш Tapbar
            TapbarWidget(
              onTabChanged: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
            ),
            // Экран с контентом
            Expanded(
              child: IndexedStack(
                index: selectedTabIndex,
                children: [
                  // Экран "Дневник настроения"
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            'Что чувствуешь?',
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 118,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: moodSubmenus.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      activeIndex =
                                          (activeIndex == index) ? null : index;
                                      selectedMoodIndex = null;
                                      selectedParentIndex = activeIndex;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: EllipseWidget(
                                      url:
                                          'assets/pics/${getEmotionImage(index)}.png',
                                      text: getEmotionText(index),
                                      color: selectedParentIndex == index
                                          ? Colors.orange
                                          : Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (activeIndex != null)
                            Column(
                              children: [
                                SizedBox(height: 20),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: moodSubmenus[activeIndex!]
                                      .map((text) => MoodButtonsWidget(
                                            text: text,
                                            isSelected:
                                                selectedMoodIndex != null &&
                                                    moodSubmenus[activeIndex!]
                                                            .indexOf(text) ==
                                                        selectedMoodIndex,
                                            onTap: () {
                                              setState(() {
                                                selectedMoodIndex =
                                                    moodSubmenus[activeIndex!]
                                                        .indexOf(text);
                                              });
                                            },
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          SizedBox(height: 36),
                          buildSlider('Уровень стресса', _currentSliderValue,
                              'Низкий', 'Высокий', (value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          }),
                          SizedBox(height: 36),
                          buildSlider('Самооценка', _currentSliderValue2,
                              'Неуверенность', 'Уверенность', (value) {
                            setState(() {
                              _currentSliderValue2 = value;
                            });
                          }),
                          SizedBox(height: 36),
                          Text(
                            'Заметки',
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Color(0xFFB6A1C0).withOpacity(0.1),
                                offset: Offset(2, 4),
                                blurRadius: 10.8,
                                spreadRadius: 0,
                              ),
                            ], borderRadius: BorderRadius.circular(20.0)),
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Введите заметку',
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 35),
                          ElevatedButton(
                            onPressed: isSaveEnabled
                                ? () {
                                    _toggleStatistic();
                                    _showSavedPopup('Сохранено в статистику');
                                  }
                                : () {
                                    _showSavedPopup('Все поля обязательны');
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSaveEnabled
                                  ? AppColors.primaryOrange
                                  : AppColors.greyFour,
                              minimumSize: const Size(double.infinity, 44),
                            ),
                            child: Text(
                              "Сохранить",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: isSaveEnabled
                                    ? Colors.white
                                    : AppColors.greyTwo,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Экран "Статистика"
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isSaveEnabled)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Введите сначала данные в Дневнике',
                                style: TextStyle(
                                  color: AppColors.textGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          if (_isVisible)
                            MoodStatistics(
                              currentSelfEsteem: _currentSliderValue2,
                              currentStress: _currentSliderValue,
                              selectedParentIndex: selectedMoodIndex,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
