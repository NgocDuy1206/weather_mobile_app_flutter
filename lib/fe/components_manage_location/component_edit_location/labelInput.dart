import 'package:flutter/material.dart';

class LabelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Add a label" text above the input field
        Text(
          'Add a label',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 6),

        // Input field with the desired decoration
        TextField(
          decoration: InputDecoration(
            hintText: 'e.g. Home',
            hintStyle: TextStyle(color: Colors.white54),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0), // Reduced vertical padding
          ),
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white, // Cursor color
        ),
        SizedBox(height: 3), // Reduced space below the TextField
      ],
    );
  }
}
