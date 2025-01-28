import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget(
      {super.key,
      required this.currentSliderValue,
      required this.onChanged,
      required this.StringMin,
      required this.StringMax});

  final double currentSliderValue;
  final String StringMin;
  final String StringMax;

  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 2,
                      height: 8,
                      color: Color.fromRGBO(225, 221, 216, 1)),
                  Container(
                      width: 2,
                      height: 8,
                      color: Color.fromRGBO(225, 221, 216, 1)),
                  Container(
                      width: 2,
                      height: 8,
                      color: Color.fromRGBO(225, 221, 216, 1)),
                  Container(
                      width: 2,
                      height: 8,
                      color: Color.fromRGBO(225, 221, 216, 1)),
                  Container(
                      width: 2,
                      height: 8,
                      color: Color.fromRGBO(225, 221, 216, 1)),
                  Container(
                      width: 2,
                      height: 8,
                      color: Color.fromRGBO(225, 221, 216, 1)),
                ],
              ),
            ),
            Slider(
              value: currentSliderValue,
              min: 0,
              max: 100,
              divisions: 5,
              onChanged: onChanged,
              activeColor: AppColors.primaryOrange,
              inactiveColor: Colors.grey[100],
              thumbColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringMin,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w400)),
                  Text(StringMax,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
