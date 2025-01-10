import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/warnings_alerts_screen.dart';
import '../../../../configs/utils.dart';
import 'language_and_units_screen.dart';
import 'dart:async'; // Import thư viện Timer

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/push_notification.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingsScreen> {
  bool autoRefresh = false;
  bool useCurrentLocation = false;
  int refreshInterval = 1; // Thay đổi mặc định thành 1 phút
  late String selectedTheme; // Sử dụng late để chỉ khởi tạo sau
  String minutes = Utils.getText('minutes');
  late Timer _timer; // Định nghĩa Timer
  final PushNotificationService _pushNotificationService = PushNotificationService(); // Khởi tạo đối tượng PushNotificationService

  @override
  void initState() {
    super.initState();
    // Lấy giá trị theme từ SettingManager
    selectedTheme = Provider.of<SettingManager>(context, listen: false).theme;
    _pushNotificationService.initialize(); // Khởi tạo PushNotificationService
  }

  @override
  void dispose() {
    // Hủy Timer khi màn hình bị đóng
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
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
              title: Text(Utils.getText('Notification'), style: TextStyle(color: textColor)),
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
                  if (autoRefresh) {
                    // Bắt đầu Timer khi bật tính năng Auto-Refresh
                    _startAutoRefresh();
                  } else {
                    // Dừng Timer nếu Auto-Refresh bị tắt
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                  }
                });
              },
            ),
            if (autoRefresh)
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: DropdownButton<int>(
                  value: refreshInterval,
                  dropdownColor: selectedTheme == "dark" ? Colors.black : Colors.white,
                  items: [1, 5, 15, 30, 60].map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('$value $minutes', style: TextStyle(color: textColor)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      refreshInterval = value!;
                    });
                    // Cập nhật lại Timer khi thay đổi thời gian
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                    _startAutoRefresh();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _startAutoRefresh() {
    // Sử dụng Timer để hiển thị thông báo sau khoảng thời gian chọn
    _timer = Timer.periodic(Duration(minutes: refreshInterval), (timer) {
      // Gửi thông báo khi đến thời gian
      _showWeatherUpdateNotification();
    });
  }

  void _showWeatherUpdateNotification() {
    // Gửi thông báo cập nhật thời tiết
    // Gọi phương thức sendWeatherNotification từ PushNotificationService
    String location = "";  // Ví dụ, thay đổi vị trí nếu cần
    double lat = 21.0285;  // Vĩ độ của Hà Nội
    double lon = 105.8542;  // Kinh độ của Hà Nội

    // Gọi phương thức gửi thông báo
    _pushNotificationService.sendWeatherNotification(location, lat, lon);
  }

  void _showThemeDialog() {
    Color textColor = selectedTheme == "dark" ? Colors.white : Colors.black;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Lấy theme hiện tại
        bool isDarkMode = Provider.of<SettingManager>(context).theme == "dark";

        return AlertDialog(
          title: Text(Utils.getText('Select Theme')),
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
          // Thay đổi màu nền tùy theo theme
          titleTextStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          // Màu chữ tiêu đề
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text(Utils.getText('Light'), style: TextStyle(color: textColor)),
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
                title: Text(Utils.getText('Dark'), style: TextStyle(color: textColor)),
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
              child: Text(Utils.getText('Cancel'), style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            ),
          ],
        );
      },
    );
  }
}