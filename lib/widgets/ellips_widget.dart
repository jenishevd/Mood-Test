import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class EllipseWidget extends StatelessWidget {
  final String url;
  final String text;

  const EllipseWidget({super.key, required this.url, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 83,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
              color: Color(0xFFB6A1C0).withOpacity(0.1),
              offset: Offset(2, 4),
              blurRadius: 10.8,
              spreadRadius: 0),
        ],
      ),
      child: Center(
          child: Column(
        children: [
          SizedBox(height: 23),
          Image.asset(url, width: 53, height: 50, fit: BoxFit.cover),
          SizedBox(height: 1),
          Text(text,
              style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 11,
                  fontWeight: FontWeight.w400)),
        ],
      )),
    );
  }
}
