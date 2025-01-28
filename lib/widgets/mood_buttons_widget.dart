import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class MoodButtonsWidget extends StatelessWidget {
  const MoodButtonsWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Color(0xFFB6A1C0).withOpacity(0.1),
                offset: Offset(2, 4),
                blurRadius: 10.8,
                spreadRadius: 0),
          ],
        ),
        height: 15,
        child: Text(text,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack)));
  }
}
