import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final String name;
  final String address;
  final String temperature;
  final Color circleColor;
  final IconData icon;
  final double iconAngle;

  const LocationTile({
    Key? key,
    required this.name,
    required this.address,
    required this.temperature,
    required this.circleColor,
    required this.icon,
    this.iconAngle = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: circleColor,
        child: Transform.rotate(
          angle: iconAngle * 3.14159 / 180,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0), // Add padding to shift the icon
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(name, style: TextStyle(color: Colors.white)),
              SizedBox(width: 8),
              Icon(Icons.brightness_3, color: Colors.yellow),
              SizedBox(width: 4),
              Text(temperature, style: TextStyle(color: Colors.white)),
            ],
          ),
          Text(address, style: TextStyle(color: Colors.grey[400])),
        ],
      ),
    );
  }
}
