import 'package:calendar_test_project/global.dart';
import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget(
      {super.key,
      required this.currentSliderValue,
      required this.onChanged,
      required this.stringMin,
      required this.stringMax});

  final double currentSliderValue;
  final String stringMin;
  final String stringMax;

  final void Function(double)? onChanged;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  bool _isActive = false;
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
            GestureDetector(
              onTap: () {
                setState(() {
                  _isActive = !_isActive;
                });
              },
              child: AbsorbPointer(
                absorbing: !_isActive,
                child: Slider(
                    value: widget.currentSliderValue,
                    min: 0,
                    max: 10,
                    onChanged: widget.onChanged,
                    activeColor: _isActive ? Colors.orange : Colors.grey,
                    inactiveColor: Colors.grey[100],
                    thumbColor: Colors.white,
                    onChangeEnd: (value) {
                      setState(() {
                        currentSliderValue = value; // Обновляем значение
                      });
                      print(widget
                          .currentSliderValue); // Теперь напечатает новое значение
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.stringMin,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w400)),
                  Text(widget.stringMax,
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

Widget buildSlider(String title, double value, String minLabel, String maxLabel,
    ValueChanged<double> onChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          color: AppColors.textDark,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 20),
      SliderWidget(
        currentSliderValue: value,
        onChanged: onChanged,
        stringMin: minLabel,
        stringMax: maxLabel,
      ),
    ],
  );
}
