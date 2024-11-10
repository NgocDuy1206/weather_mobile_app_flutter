import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/warnings_alerts_screen.dart';

import '../../../../configs/utils.dart';
import 'language_and_units_screen.dart';


class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingsScreen> {
  bool autoRefresh = true;
  bool useCurrentLocation = true;
  int refreshInterval = 15;
  String selectedTheme = "Dark"; // Biến lưu trữ chủ đề đã chọn

  @override
  Widget build(BuildContext context) {
    // Đặt màu chữ dựa trên chủ đề
    Color textColor = selectedTheme == "Dark" ? Colors.white : Colors.black;
    Color subtitleColor = selectedTheme == "Dark" ? Colors.grey : Colors.black54;
    var provider = Provider.of<SettingManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: selectedTheme == "Dark" ? Colors.black87 : Colors.white, // Thay đổi màu nền theo chủ đề
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.notifications, color: textColor),
              title: Text('Warnings & Alerts', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: textColor),
              onTap: () {
                // Navigate to Warnings & Alerts screen
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WarningsAlertsScreen()),
                );
              },
            ),
            Divider(color: subtitleColor),
            ListTile(
              leading: Icon(Icons.language, color: textColor),
              title: Text(Utils.getText('language_unit'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: textColor),
              onTap: () {
                // Navigate to Language and Units screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageAndUnitsScreen()),
                );
              },
            ),
            Divider(color: subtitleColor),
            ListTile(
              leading: Icon(Icons.color_lens, color: textColor),
              title: Text('App Theme', style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: textColor),
              onTap: () {
                // Gọi hàm để hiển thị dialog
                _showThemeDialog();
              },
            ),
            Divider(color: subtitleColor),
            SizedBox(height: 20),
            Text('More Settings', style: TextStyle(color: subtitleColor)),
            SwitchListTile(
              title: Text('Auto-Refresh', style: TextStyle(color: textColor)),
              subtitle: Text(
                'Select your interval to automatically refresh notifications',
                style: TextStyle(color: subtitleColor),
              ),
              value: autoRefresh,
              onChanged: (value) {
                setState(() {
                  autoRefresh = value;
                });
              },
            ),
            if (autoRefresh)
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: DropdownButton<int>(
                  value: refreshInterval,
                  dropdownColor: selectedTheme == "Dark" ? Colors.black : Colors.white,
                  items: [5, 10, 15, 30, 60].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        '$value minutes',
                        style: TextStyle(color: textColor),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      refreshInterval = value!;
                    });
                  },
                ),
              ),
            SwitchListTile(
              title: Text('Use Current Location', style: TextStyle(color: textColor)),
              subtitle: Text(
                'Get hyperlocal weather updates for your pinpoint location',
                style: TextStyle(color: subtitleColor),
              ),
              value: useCurrentLocation,
              onChanged: (value) {
                setState(() {
                  useCurrentLocation = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Hàm hiển thị dialog chọn chủ đề
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Theme"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text("Light"),
                value: "Light",
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value.toString();
                  });
                  Navigator.of(context).pop(); // Đóng dialog sau khi chọn
                },
              ),
              RadioListTile(
                title: Text("Dark"),
                value: "Dark",
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value.toString();
                  });
                  Navigator.of(context).pop(); // Đóng dialog sau khi chọn
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog nếu nhấn nút Cancel
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
