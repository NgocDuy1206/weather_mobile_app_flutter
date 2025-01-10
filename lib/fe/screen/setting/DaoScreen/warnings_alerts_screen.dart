import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../be/state_management/setting_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/push_notification.dart';

class WarningsAlertsScreen extends StatefulWidget {
  @override
  _WarningsAlertsScreenState createState() => _WarningsAlertsScreenState();
}

class _WarningsAlertsScreenState extends State<WarningsAlertsScreen> {
  bool isStickyNotificationsEnabled = false;
  bool isWeatherHighlightsEnabled = true;
  bool isNWSAlertsEnabled = true;
  bool isWeatherNewsEnabled = true;
  bool isCurrentLocationSelected = false;
  String currentLocation = '';
  String weatherInfo = ''; // Thông tin thời tiết giả lập

  @override
  Widget build(BuildContext context) {
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
          Utils.getText('Notification'),
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: iconColor),
        backgroundColor: appBarColor,
        elevation: 1,
      ),
      backgroundColor: bodyColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Các công tắc bật/tắt thông báo
            SwitchListTile(
              title: Text(
                Utils.getText('Instant Notification'),
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
                  if (value && currentLocation.isNotEmpty) {
                    // Tách vĩ độ và kinh độ từ currentLocation
                    double lat = 21.0285; // Lấy vĩ độ từ currentLocation
                    double lon = 105.8542; // Lấy kinh độ từ currentLocation

                    PushNotificationService().sendWeatherNotification(currentLocation, lat, lon); // Truyền đủ 3 đối số
                  }
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

            // Vị trí hiện tại
            ListTile(
              title: Text(
                Utils.getText('Location'),
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                currentLocation, // Hiển thị vị trí hiện tại
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
                                if (isCurrentLocationSelected) {
                                  _getCurrentLocation(); // Lấy vị trí hiện tại khi chọn
                                } else {
                                  currentLocation = ''; // Vị trí mặc định
                                }
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

  // Hàm để lấy vị trí hiện tại của người dùng
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kiểm tra xem dịch vụ vị trí có bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Dịch vụ vị trí không bật, thông báo cho người dùng
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    // Lấy vị trí hiện tại của người dùng
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = 'Lat: ${position.latitude}, Long: ${position.longitude}, Ha Noi'; // Hiển thị vị trí
    });
  }
}
