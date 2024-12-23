import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/settings_screen.dart';
import '../display_search_manageLocation/add_widget_screen.dart';
import '../display_search_manageLocation/manage_location_screen.dart';
import 'notification_screen.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getText('Settings'), style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Đặt màu đen cho icon back
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.black),
              title: Text(Utils.getText('Manage Locations'), style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.widgets, color: Colors.black),
              title: Text(Utils.getText('Add Widgets'), style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWidgetScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.black),
              title: Text(Utils.getText('Daily Summary Notification'), style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.black),
              title: Text(Utils.getText('More Settings'), style: TextStyle(color: Colors.black)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
