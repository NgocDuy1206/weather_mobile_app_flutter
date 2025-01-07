import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:provider/provider.dart';
import '../../../../be/state_management/setting_manager.dart';

class WarningsAlertsScreen extends StatefulWidget {
  @override
  _WarningsAlertsScreenState createState() => _WarningsAlertsScreenState();
}

class _WarningsAlertsScreenState extends State<WarningsAlertsScreen> {
  // Trạng thái của các công tắc bật/tắt
  bool isStickyNotificationsEnabled = true;
  bool isWeatherHighlightsEnabled = true;
  bool isNWSAlertsEnabled = true;
  bool isWeatherNewsEnabled = true;

  // Trạng thái của ô tích trong hộp thoại "Current Location"
  bool isCurrentLocationSelected = false;

  @override
  Widget build(BuildContext context) {
    // Lấy theme hiện tại
    String selectedTheme = Provider.of<SettingManager>(context).theme;
    Color textColor = selectedTheme == "dark" ? Colors.white : Colors.black;
    Color subtitleColor = selectedTheme == "dark" ? Colors.grey : Colors.black54;
    Color appBarColor = selectedTheme == "dark" ? Colors.black : Colors.white;
    Color iconColor = selectedTheme == "dark" ? Colors.white : Colors.black;
    Color bodyColor = selectedTheme == "dark" ? Colors.black87 : Colors.white;
    Color switchInactiveTrackColor = selectedTheme == "dark" ? Colors.black26 : Colors.black26;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Utils.getText('Alerts'),
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: iconColor),
        backgroundColor: appBarColor,
        elevation: 1,
      ),
      backgroundColor: bodyColor, // Màu nền của body thay đổi theo theme
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sticky Notifications Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('Sticky Notifications'),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                Utils.getText('Weather alerts'),
                style: TextStyle(color: subtitleColor),
              ),
              value: isStickyNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  isStickyNotificationsEnabled = value;

                  // Tắt các công tắc khác nếu Sticky Notifications bị tắt
                  if (!value) {
                    isWeatherHighlightsEnabled = false;
                    isNWSAlertsEnabled = false;
                    isWeatherNewsEnabled = false;
                  }
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: switchInactiveTrackColor,
            ),
            SizedBox(height: 16.0),

            // Types of Content Section Title
            Text(
              Utils.getText('Types of Content'),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8.0),

            // Weather Highlights Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('Weather Highlights'),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                Utils.getText('Get forecasts'),
                style: TextStyle(color: subtitleColor),
              ),
              value: isWeatherHighlightsEnabled,
              onChanged: isStickyNotificationsEnabled
                  ? (bool value) {
                setState(() {
                  isWeatherHighlightsEnabled = value;
                });
              }
                  : null, // Vô hiệu hóa nếu Sticky Notifications tắt
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: switchInactiveTrackColor,
            ),

            // NWS Alerts Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('NWS Alerts'),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                Utils.getText('Get weather alerts'),
                style: TextStyle(color: subtitleColor),
              ),
              value: isNWSAlertsEnabled,
              onChanged: isStickyNotificationsEnabled
                  ? (bool value) {
                setState(() {
                  isNWSAlertsEnabled = value;
                });
              }
                  : null,
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: switchInactiveTrackColor,
            ),

            // Weather News Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('Weather News'),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                Utils.getText('Get weather news & videos'),
                style: TextStyle(color: subtitleColor),
              ),
              value: isWeatherNewsEnabled,
              onChanged: isStickyNotificationsEnabled
                  ? (bool value) {
                setState(() {
                  isWeatherNewsEnabled = value;
                });
              }
                  : null,
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: switchInactiveTrackColor,
            ),

            // Location Setting
            ListTile(
              title: Text(
                Utils.getText('Location'),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                'Nam Từ Liêm, VN',
                style: TextStyle(color: subtitleColor),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: iconColor),
              onTap: () {
                // Hiển thị hộp thoại chọn vị trí
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: bodyColor,
                      title: Text(
                        Utils.getText('Current Location'),
                        style: TextStyle(color: textColor),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Utils.getText('Use Current Location'),
                            style: TextStyle(color: textColor),
                          ),
                          Checkbox(
                            value: isCurrentLocationSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                isCurrentLocationSelected = value ?? false;
                              });
                              Navigator.of(context).pop(); // Đóng hộp thoại sau khi chọn
                            },
                            activeColor: Colors.blue,
                            checkColor: Colors.white,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
