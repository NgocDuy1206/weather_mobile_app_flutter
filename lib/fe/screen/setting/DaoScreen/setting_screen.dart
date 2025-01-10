import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/settings_screen.dart';
import '../display_search_manageLocation/add_widget_screen.dart';
import '../display_search_manageLocation/manage_location_screen.dart';
import 'notification_screen.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:provider/provider.dart';
import '../../../../be/state_management/setting_manager.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy theme hiện tại
    String selectedTheme = Provider.of<SettingManager>(context).theme;
    Color textColor = selectedTheme == "dark" ? Colors.white : Colors.black;
    Color subtitleColor = selectedTheme == "dark" ? Colors.grey : Colors.black54;
    Color appBarColor = selectedTheme == "dark" ? Colors.black : Colors.white;
    Color iconColor = selectedTheme == "dark" ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getText('Settings'), style: TextStyle(color: textColor)),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor), // Đặt màu icon tùy theo theme
      ),
      body: Container(
        color: selectedTheme == "dark" ? Colors.black87 : Colors.white, // Màu nền thay đổi theo theme
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ListTile(
              leading: Icon(Icons.location_on, color: iconColor),
              title: Text(Utils.getText('Manage Locations'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: subtitleColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.widgets, color: iconColor),
              title: Text(Utils.getText('Add Widgets'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: subtitleColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWidgetScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications, color: iconColor),
              title: Text(Utils.getText('Daily Timer Notification'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: subtitleColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: iconColor),
              title: Text(Utils.getText('More Settings'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: subtitleColor),
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
