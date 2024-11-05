import 'package:flutter/material.dart';

import 'display_search_manageLocation/add_widget_screen.dart';
import 'display_search_manageLocation/manage_location_screen.dart';
import 'display_search_manageLocation/search_screen.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 1')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Color(0xFF1A0A1A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (BuildContext context) {
                    return SearchScreenModal();
                  },
                );
              },
              child: Text('Search'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageScreen()),
                );
              },
              child: Text('Manage'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWidgetScreen()),
                );
              },
              child: Text('Add Widget'),
            ),
          ],
        ),
      ),
    );
  }
}