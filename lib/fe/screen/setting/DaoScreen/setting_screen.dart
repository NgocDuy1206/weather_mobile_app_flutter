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
        title: Text(Utils.getText('Settings'), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white), // Đặt màu đen cho icon back
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.white),
              title: Text(Utils.getText('Manage Locations'), style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageScreen()),
                  );
                },
            ),
            ListTile(
              leading: Icon(Icons.widgets, color: Colors.white),
              title: Text(Utils.getText('Add Widgets'), style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddWidgetScreen()),
                  );
                },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: Colors.white),
              title: Text(Utils.getText('Daily Summary Notification'), style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(Utils.getText('More Settings'), style: TextStyle(color: Colors.white)),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
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
