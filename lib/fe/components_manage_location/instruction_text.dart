import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  final String text;

  InstructionText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white54, fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
