import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:provider/provider.dart';
import '../../../../be/state_management/setting_manager.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isNotificationEnabled = true;
  bool showInfoMessage = false; // Trạng thái hiển thị thông báo
  String Select_time = Utils.getText('Select time');
  TimeOfDay selectedTime = TimeOfDay(hour: 5, minute: 30);

  @override
  void initState() {
    super.initState();
    _loadTime(); // Gọi hàm để tải thời gian đã lưu
  }

  // Hàm lấy thời gian từ SharedPreferences
  Future<void> _loadTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int hour = prefs.getInt('selected_hour') ?? 5;  // Lấy giờ (mặc định là 5 nếu không có giá trị lưu)
    int minute = prefs.getInt('selected_minute') ?? 30;  // Lấy phút (mặc định là 30 nếu không có giá trị lưu)
    setState(() {
      selectedTime = TimeOfDay(hour: hour, minute: minute);
    });
  }

  // Hàm lưu thời gian vào SharedPreferences
  Future<void> _saveTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selected_hour', selectedTime.hour);
    prefs.setInt('selected_minute', selectedTime.minute);
  }

  // Hàm chọn thời gian
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;  // Cập nhật thời gian khi người dùng chọn
      });
      await _saveTime();  // Lưu thời gian đã chọn vào SharedPreferences
    }
  }

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
    Color dividerColor = selectedTheme == "dark" ? Colors.white24 : Colors.black26;

    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.getText('Daily Summary Notification'), style: TextStyle(color: textColor)),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: iconColor),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: iconColor),
            onPressed: () {
              setState(() {
                showInfoMessage = true; // Hiển thị thông báo khi nhấn vào icon info
              });
            },
          ),
        ],
      ),
      body: Container(
        color: bodyColor,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông báo hiển thị khi nhấn vào icon info
            Visibility(
              visible: showInfoMessage,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        Utils.getText('Get a daily'),
                        style: TextStyle(color: textColor, fontSize: 14.0),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: iconColor, size: 20.0),
                      onPressed: () {
                        setState(() {
                          showInfoMessage = false; // Ẩn thông báo khi nhấn vào icon close
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Utils.getText('Use Current Location'),
                  style: TextStyle(color: textColor, fontSize: 16.0),
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isNotificationEnabled = value;
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveTrackColor: switchInactiveTrackColor,
                ),
              ],
            ),
            SizedBox(height: 20.0),

            Row(
              children: [
                Icon(Icons.access_time, color: iconColor),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => _selectTime(context),  // Chọn thời gian khi nhấn vào
                  child: Text(
                    '${selectedTime.format(context)}',
                    style: TextStyle(color: textColor, fontSize: 16.0),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: iconColor),
                  onPressed: () => _selectTime(context),  // Chỉnh sửa thời gian
                ),
              ],
            ),
            Divider(color: dividerColor, thickness: 1.0),
          ],
        ),
      ),
    );
  }
}
