import 'package:calendar_test_project/pages/utils/colors.dart';
import 'package:flutter/material.dart';

class TapbarWidget extends StatefulWidget {
  final Function(int) onTabChanged;

  const TapbarWidget({super.key, required this.onTabChanged});
  @override
  _TapbarWidgetState createState() => _TapbarWidgetState();
}

class _TapbarWidgetState extends State<TapbarWidget> {
  int selectedIndex = 0; // 0 - активная "Дневник настроения", 1 - "Статистика"

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.greyFour,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _buildTab(0, Icons.book, "Дневник настроения", 2),
            _buildTab(1, Icons.bar_chart, "Статистика", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, IconData icon, String text, int flex) {
    bool isSelected = selectedIndex == index;
    return Flexible(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          widget.onTabChanged(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    color: isSelected ? Colors.white : AppColors.greyTwo,
                    size: 20),
                SizedBox(width: 5),
                Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.greyTwo,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
