import 'package:flutter/material.dart';

class QuickLabelOption extends StatefulWidget {
  final String label;
  final IconData icon;

  QuickLabelOption({required this.label, required this.icon});

  @override
  _QuickLabelOptionState createState() => _QuickLabelOptionState();
}

class _QuickLabelOptionState extends State<QuickLabelOption> {
  bool _isHovered = false;
  bool _isSelected = false; // Track if the option is selected

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected; // Toggle selection state
          });
          print('Selected: ${widget.label}');
        },
        child: Chip(
          label: Row(
            children: [
              Icon(widget.icon, color: _isSelected || _isHovered ? Colors.blue : Colors.white), // Change icon color
              SizedBox(width: 8), // Space between icon and label
              Text(
                widget.label,
                style: TextStyle(color: _isSelected || _isHovered ? Colors.blue : Colors.white), // Change text color
              ),
            ],
          ),
          backgroundColor: Color(0xFF141D26), // Keep the background color same
          shape: RoundedRectangleBorder(
            side: BorderSide(color: _isSelected ? Colors.blue : Colors.grey, width: 1), // Thinner border
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
        ),
      ),
    );
  }
}
