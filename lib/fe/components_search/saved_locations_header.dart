import 'package:flutter/material.dart';

import '../screen/setting/display_search_manageLocation/manage_location_screen.dart';


//Phần header Saved Location và Manage
class SavedLocationsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Saved Locations', style: TextStyle(color: Colors.white, fontSize: 18)), // Increased font size
          TextButton(
            onPressed: () {
              // Navigate to ManageScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageScreen()),
              );
            },
            child: Text('Manage', style: TextStyle(color: Colors.blue, fontSize: 16)), // Increased font size
          ),
        ],
      ),
    );
  }
}

