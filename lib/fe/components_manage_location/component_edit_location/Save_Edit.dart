import 'package:flutter/material.dart';

import '../../../configs/utils.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, // Đặt nút Save ở giữa
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF16304B), // Màu nền của nút
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15), // Kích thước nút nhỏ hơn
        ),
        child: Text(
          Utils.getText('SAVE CHANGES'),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
