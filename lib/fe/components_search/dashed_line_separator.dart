import 'package:flutter/material.dart';

//Hiển thị nét đứt
class DashedLineSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: List.generate(60, (index) {
          return Expanded(
            child: Container(
              height: 1,
              color: index % 2 == 0 ? Colors.grey : Colors.transparent,
            ),
          );
        }),
      ),
    );
  }
}
