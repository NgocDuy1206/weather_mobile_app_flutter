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
  late String selectedTheme; // Sử dụng late để chỉ khởi tạo sau
  String minutes = Utils.getText('minutes');

  @override
  void initState() {
    super.initState();
    // Lấy giá trị theme từ SettingManager
    selectedTheme = Provider.of<SettingManager>(context, listen: false).theme;
  }

  @override
  Widget build(BuildContext context) {
    // Đặt màu chữ dựa trên theme
    Color textColor = selectedTheme == "dark" ? Colors.white : Colors.black;
    Color subtitleColor = selectedTheme == "dark" ? Colors.grey : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Utils.getText('More Settings'),
          style: TextStyle(color: selectedTheme == "dark" ? Colors.white : Colors.black),
        ),
        backgroundColor: selectedTheme == "dark" ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: selectedTheme == "dark" ? Colors.white : Colors.black),
      ),
      body: Container(
        color: selectedTheme == "dark" ? Colors.black87 : Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Alerts
            ListTile(
              leading: Icon(Icons.notifications, color: textColor),
              title: Text(Utils.getText('Alerts'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: textColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WarningsAlertsScreen()),
                );
              },
            ),
            Divider(color: subtitleColor),

            // Language and Units
            ListTile(
              leading: Icon(Icons.language, color: textColor),
              title: Text(Utils.getText('language_unit'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: textColor),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageAndUnitsScreen()),
                );
              },
            ),
            Divider(color: subtitleColor),

            // App Theme
            ListTile(
              leading: Icon(Icons.color_lens, color: textColor),
              title: Text(Utils.getText('App Theme'), style: TextStyle(color: textColor)),
              trailing: Icon(Icons.arrow_forward_ios, color: textColor),
              onTap: () {
                _showThemeDialog();
              },
            ),
            Divider(color: subtitleColor),

            SizedBox(height: 20),
            Text(Utils.getText('Additional Settings'), style: TextStyle(color: subtitleColor)),

            // Auto-Refresh
            SwitchListTile(
              title: Text(Utils.getText('Auto-Refresh'), style: TextStyle(color: textColor)),
              subtitle: Text(Utils.getText('Select your'), style: TextStyle(color: subtitleColor)),
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
                  dropdownColor: selectedTheme == "dark" ? Colors.black : Colors.white,
                  items: [5, 10, 15, 30, 60].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(
                        '$value $minutes',
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

            // Use Current Location
            SwitchListTile(
              title: Text(Utils.getText('Use Current Location'), style: TextStyle(color: textColor)),
              subtitle: Text(Utils.getText('Get hyperlocal'), style: TextStyle(color: subtitleColor)),
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

  // Hiển thị Dialog chọn chủ đề
  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Utils.getText('Select Theme')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text(Utils.getText('Light')),
                value: "light",
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value.toString();
                  });
                  // Cập nhật theme vào SettingManager
                  Provider.of<SettingManager>(context, listen: false).updateTheme("light");
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile(
                title: Text(Utils.getText('Dark')),
                value: "dark",
                groupValue: selectedTheme,
                onChanged: (value) {
                  setState(() {
                    selectedTheme = value.toString();
                  });
                  // Cập nhật theme vào SettingManager
                  Provider.of<SettingManager>(context, listen: false).updateTheme("dark");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(Utils.getText('Cancel')),
            ),
          ],
        );
      },
    );
  }
}
