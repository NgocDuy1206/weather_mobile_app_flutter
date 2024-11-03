import 'package:flutter/material.dart';

import 'display_search_manageLocation/search_screen.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 1')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Color(0xFF1A0A1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                //Nhảy sang search_screen
                return SearchScreenModal();
              },
            );
          },
          child: Text('Mở Tìm Kiếm'),
        ),
      ),
    );
  }
}