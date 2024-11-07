import 'package:flutter/material.dart';

class LocationHeader extends StatelessWidget {
  final String location;

  LocationHeader({required this.location});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.white),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            location,
            style: TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
