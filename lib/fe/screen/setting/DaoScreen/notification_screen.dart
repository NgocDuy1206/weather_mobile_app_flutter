import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:provider/provider.dart';
import '../../../../be/state_management/setting_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/push_notification.dart';
import 'dart:async'; // Thêm để sử dụng Timer

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isNotificationEnabled = true;
  bool showInfoMessage = false; // Trạng thái hiển thị thông báo
  String Select_time = Utils.getText('Select time');
  TimeOfDay selectedTime = TimeOfDay(hour: 5, minute: 30);
  bool isCurrentLocationSelected = false;
  String currentLocation = '';
  late PushNotificationService pushNotificationService; // Khởi tạo đối tượng PushNotificationService
  bool isNotified = false; // Biến để theo dõi trạng thái thông báo

  @override
  void initState() {
    super.initState();
    pushNotificationService = PushNotificationService(); // Khởi tạo PushNotificationService
    pushNotificationService.initialize();  // Khởi tạo PushNotificationService
    _loadTime(); // Gọi hàm để tải thời gian đã lưu
    _startTimer(); // Bắt đầu timer để kiểm tra thời gian
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

  // Hàm lấy vị trí hiện tại của người dùng
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

  // Hàm kiểm tra thời gian và gửi thông báo
  void _checkTimeAndNotify() async {
    final now = TimeOfDay.now();
    final currentTime = DateTime.now(); // Lấy giờ, phút, giây hiện tại từ DateTime

    // Chỉ thông báo khi giờ, phút và giây là 0 (tức là bắt đầu một phút mới)
    if (selectedTime.hour == currentTime.hour &&
        selectedTime.minute == currentTime.minute &&
        currentTime.second == 0 &&
        !isNotified) {

      // Cập nhật trạng thái thông báo đã được gửi
      setState(() {
        isNotified = true;
      });

      String location = "";  // Ví dụ, thay đổi vị trí nếu cần
      double lat = 21.0285;  // Vĩ độ của Hà Nội
      double lon = 105.8542;  // Kinh độ của Hà Nội

      // Gọi phương thức gửi thông báo
      pushNotificationService.sendWeatherNotification(location, lat, lon);
    } else if (currentTime.second != 0) {
      // Reset lại trạng thái khi giây không phải là 0 (khi bắt đầu một giây mới)
      setState(() {
        isNotified = false;
      });
    }
  }

  // Hàm bắt đầu Timer để kiểm tra thời gian mỗi giây
  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _checkTimeAndNotify(); // Kiểm tra mỗi giây
    });
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
        title: Text(Utils.getText('Daily Timer Notification'), style: TextStyle(color: textColor)),
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
                        Utils.getText('Get daily timer notification'),
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
                  value: isCurrentLocationSelected,
                  onChanged: (value) {
                    setState(() {
                      isCurrentLocationSelected = value;
                    });
                    if (isCurrentLocationSelected) {
                      _getCurrentLocation();  // Lấy vị trí khi bật
                    } else {
                      setState(() {
                        currentLocation = '';  // Đặt lại khi tắt
                      });
                    }
                  },
                  activeColor: Colors.blue,
                  inactiveTrackColor: switchInactiveTrackColor,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            // Hiển thị vị trí khi bật công tắc "Use Current Location"
            if (isCurrentLocationSelected && currentLocation.isNotEmpty)
              Text(
                '$currentLocation',
                style: TextStyle(color: textColor, fontSize: 14.0),
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
