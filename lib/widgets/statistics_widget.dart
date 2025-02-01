import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class MoodStatistics extends StatefulWidget {
  final int? selectedParentIndex; // Make it nullable
  final double currentStress;
  final double currentSelfEsteem;

  MoodStatistics({
    required this.selectedParentIndex,
    required this.currentStress,
    required this.currentSelfEsteem,
  });

  @override
  _MoodStatisticsState createState() => _MoodStatisticsState();
}

class _MoodStatisticsState extends State<MoodStatistics> {
  double stressValue = 0.0;
  double selfEsteemValue = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        stressValue = widget.currentStress / 10;
        selfEsteemValue = widget.currentSelfEsteem / 10;
      });
    });
  }

  String getQuote() {
    if (widget.selectedParentIndex == null) {
      return "Как ты себя чувствуешь сегодня?";
    }
    if (widget.selectedParentIndex == 0) return "Радость – это улыбка души! 😊";
    if (widget.selectedParentIndex == 1) {
      return "Страх – это всего лишь шаг перед победой! 💪";
    }
    if (widget.selectedParentIndex == 2) {
      return "Злость – энергия, направь ее в созидание! 🔥";
    }
    if (widget.selectedParentIndex == 3) {
      return "Грусть – это тень, а ты – свет! ☀️";
    }
    if (widget.selectedParentIndex == 4) {
      return "Спокойствие – твоя суперсила! 🧘";
    }
    return "Ты сильнее, чем думаешь! 🌟";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Твоя статистика",
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: stressValue,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
            minHeight: 14.0,
          ),
          SizedBox(height: 10),
          Text("Стресс: ${widget.currentStress.toStringAsFixed(1)} / 10"),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: selfEsteemValue,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            minHeight: 14.0,
          ),
          SizedBox(height: 10),
          Text(
              "Самооценка: ${widget.currentSelfEsteem.toStringAsFixed(1)} / 10"),
          SizedBox(height: 30),
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                getQuote(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
