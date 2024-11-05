import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String label;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  DeleteConfirmationDialog({
    required this.label,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF232B38), // Dark background color
      title: Center(
        child: Text(
          'Are you sure?',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'This will remove $label from your list of saved locations.',
              style: TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20), // Space between text and buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onCancel,
                  child: Text('No', style: TextStyle(color: Colors.blue)),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0), // Increases button height
                    backgroundColor: Color(0xFF232B38),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(width: 10), // Space between buttons
              Expanded(
                child: TextButton(
                  onPressed: onConfirm,
                  child: Text('Yes', style: TextStyle(color: Colors.blue)),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    backgroundColor: Color(0xFF232B38),
                    side: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
