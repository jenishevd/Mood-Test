import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class MoodButtonsWidget extends StatefulWidget {
  const MoodButtonsWidget(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onTap});

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<MoodButtonsWidget> createState() => _MoodButtonsWidgetState();
}

class _MoodButtonsWidgetState extends State<MoodButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 88,
        height: 20,
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.primaryOrange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFB6A1C0).withOpacity(0.1),
              offset: Offset(2, 4),
              blurRadius: 10.8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: widget.isSelected ? Colors.white : AppColors.textMood,
            ),
          ),
        ),
      ),
    );
  }
}

class MoodButtonGroup extends StatefulWidget {
  const MoodButtonGroup({super.key});

  @override
  State<MoodButtonGroup> createState() => _MoodButtonGroupState();
}

class _MoodButtonGroupState extends State<MoodButtonGroup> {
  int selectedIndex = -1;

  void _onButtonTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: MoodButtonsWidget(
            text: 'Mood $index',
            isSelected: selectedIndex == index,
            onTap: () => _onButtonTapped(index),
          ),
        );
      }),
    );
  }
}
