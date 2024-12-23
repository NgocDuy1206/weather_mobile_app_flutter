import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Utils.getText('Alerts'),
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white, // Màu nền AppBar trắng
        elevation: 1, // Hiệu ứng bóng nhỏ
      ),
      backgroundColor: Colors.white, // Màu nền sáng
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sticky Notifications Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('Sticky Notifications'),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                Utils.getText('Weather alerts'),
                style: TextStyle(color: Colors.black54),
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
              inactiveTrackColor: Colors.black26,
            ),
            SizedBox(height: 16.0),

            // Types of Content Section Title
            Text(
              Utils.getText('Types of Content'),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),

            // Weather Highlights Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('Weather Highlights'),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                Utils.getText('Get forecasts'),
                style: TextStyle(color: Colors.black54),
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
              inactiveTrackColor: Colors.black26,
            ),

            // NWS Alerts Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('NWS Alerts'),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                Utils.getText('Get weather alerts'),
                style: TextStyle(color: Colors.black54),
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
              inactiveTrackColor: Colors.black26,
            ),

            // Weather News Toggle
            SwitchListTile(
              title: Text(
                Utils.getText('Weather News'),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                Utils.getText('Get weather news & videos'),
                style: TextStyle(color: Colors.black54),
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
              inactiveTrackColor: Colors.black26,
            ),

            // Location Setting
            ListTile(
              title: Text(
                Utils.getText('Location'),
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                'Nam Từ Liêm, VN',
                style: TextStyle(color: Colors.black54),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                // Hiển thị hộp thoại chọn vị trí
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        Utils.getText('Current Location'),
                        style: TextStyle(color: Colors.black),
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Utils.getText('Use Current Location'),
                            style: TextStyle(color: Colors.black),
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
