import 'package:flutter/material.dart';

import '../../../components_manage_location/dashed_separator.dart';
import '../../../components_manage_location/instruction_text.dart';
import '../../../components_manage_location/location_item_manage.dart';


//Màn quản lý vị trí - Manage Location
class ManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Locations'),
        backgroundColor: Color(0xFF1A0A1A),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Color(0xFF1A0A1A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Transform.rotate(
                angle: 30 * 3.14159 / 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Icon(Icons.navigation, color: Colors.white, size: 24),
                ),
              ),
            ),
            title: Text('Cầu Giấy', style: TextStyle(color: Colors.white)),
            subtitle: Text('Cầu Giấy, Cầu Giấy, VN', style: TextStyle(color: Colors.white54)),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'SAVED LOCATIONS',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Cách đều mép hai bên
            child: Text(
              'Click, hold and move the lever to change the position of your locations.',
              textAlign: TextAlign.left, // Căn trái cho văn bản
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),

          SizedBox(height: 10),
          LocationItemManage(
            label: 'Hoi An Corner Coffee',
            location: 'Hoàn Kiếm, Hà Nội, VN',
            onEdit: () {
              // Handle edit action
            },
            onDelete: () {
              // Handle delete action
            },
          ),
          DashedSeparator(),
          LocationItemManage(
            label: 'Đà Nẵng',
            location: 'Đà Nẵng, VN',
            onEdit: () {
              // Handle edit action
            },
            onDelete: () {
              // Handle delete action
            },
          ),
          DashedSeparator(),
          SizedBox(height: 16),
          InstructionText(
            text: 'Tap on the edit icon to add a label. For e.g., Home, Office.',
          ),
        ],
      ),
    );
  }
}
