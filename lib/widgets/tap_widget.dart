import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TapWidget extends StatefulWidget {
  const TapWidget({super.key});

  @override
  State<TapWidget> createState() => _TapWidgetState();
}

class _TapWidgetState extends State<TapWidget> {
  String currentDate = '';
  String selectedMood = ''; // Для отслеживания выбранного настроения

  final Map<String, List<String>> moodWords = {
    'Радость': ['Счастье', 'Удовлетворение', 'Эйфория', 'Оптимизм'],
    'Страх': ['Тревога', 'Беспокойство', 'Паника', 'Неуверенность'],
    'Бешенство': ['Гнев', 'Раздражение', 'Ярость', 'Злость'],
    'Грусть': ['Печаль', 'Тоска', 'Одиночество', 'Разочарование'],
    'Спокойствие': ['Расслабленность', 'Мир', 'Гармония', 'Баланс'],
    'Сила': ['Энергия', 'Мощь', 'Уверенность', 'Вдохновение'],
  };

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
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          currentDate =
              DateFormat('d MMMM H:mm', 'ru_RU').format(DateTime.now());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            currentDate.isEmpty ? 'Загрузка...' : currentDate,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Что чувствуешь?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 118,
                    child: ListView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      children: moodWords.keys.map((mood) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Сброс, если нажато на уже выбранное настроение
                              if (selectedMood == mood) {
                                selectedMood = '';
                              } else {
                                selectedMood = mood;
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: selectedMood == mood
                                  ? Colors.blueAccent
                                  : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.emoji_emotions,
                                    color: selectedMood == mood
                                        ? Colors.white
                                        : Colors.black),
                                const SizedBox(height: 8),
                                Text(
                                  mood,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: selectedMood == mood
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (selectedMood.isNotEmpty)
                    Wrap(
                      spacing:
                          10.0, // Расстояние между контейнерами по горизонтали
                      runSpacing: 10.0, // Расстояние между строками
                      children: moodWords[selectedMood]!.map((word) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            word,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        );
                      }).toList(),
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
