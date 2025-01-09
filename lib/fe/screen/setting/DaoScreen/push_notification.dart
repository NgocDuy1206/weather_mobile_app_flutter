import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_location.dart';
import 'package:weather_mobile_app_flutter/be/api/api.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final GetApi _api = GetApi(); // Khởi tạo GetApi để lấy dữ liệu thời tiết

  // Phương thức gửi thông báo thời tiết

  Future<void> sendWeatherNotification(String location, double lat, double lon) async {
    try {
      // Lấy dữ liệu thời tiết hiện tại từ API
      WeatherLocation weatherLocation = await _api.getWeatherData(lat, lon);

      // Lấy mô tả thời tiết và nhiệt độ từ dữ liệu
      String weatherDescription = weatherLocation.current.weatherCode; // Mô tả thời tiết
      double temp = weatherLocation.current.temperature.toDouble(); // Nhiệt độ hiện tại
      double windSpeed = weatherLocation.current.windSpeed.toDouble(); // Tốc độ gió
      double humidity = weatherLocation.current.humidity.toDouble(); // Độ ẩm
      double uvIndex = weatherLocation.current.uvIndex.toDouble(); // Chỉ số UV
      double dewPoint = weatherLocation.current.dewPoint.toDouble(); // Điểm sương
      double pressure = weatherLocation.current.pressure.toDouble(); // Áp suất
      double aqi = weatherLocation.current.aqi.toDouble(); // Chỉ số chất lượng không khí (AQI)

      // Tạo nội dung thông báo đẩy
      String notificationBody =
          '$weatherDescription, Temp: $temp°C, Wind Speed: $windSpeed km/h, Humidity: $humidity%, UV Index: $uvIndex, Dew Point: $dewPoint°C, Pressure: $pressure hPa, AQI: $aqi';

      final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'weather_alerts_channel', // ID của channel
        'Weather Alerts', // Tiêu đề của channel
        channelDescription: 'Notification channel for weather alerts',
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: BigTextStyleInformation(notificationBody), // Sử dụng BigTextStyleInformation
        icon: '@mipmap/ic_launcher', // Đảm bảo icon mặc định
      );
      final NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      // Hiển thị thông báo đẩy
      await _localNotificationsPlugin.show(
        0, // Notification ID
        'Weather Notification',
        notificationBody, // Nội dung ngắn gọn cho thông báo hiển thị trên thanh trạng thái
        platformDetails,
      );
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  // Phương thức khởi tạo thông báo và đăng ký nhận thông báo từ Firebase
  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: androidSettings);

    await _localNotificationsPlugin.initialize(initializationSettings);

    // Đăng ký nhận thông báo
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _handleNotification(message);
      }
    });
  }

  // Phương thức xử lý thông báo khi nhận từ Firebase
  void _handleNotification(RemoteMessage message) {
    if (message.data['lat'] != null && message.data['lon'] != null) {
      double lat = double.parse(message.data['lat']);
      double lon = double.parse(message.data['lon']);
      sendWeatherNotification(message.data['location'], lat, lon);
    }
  }

  // Phương thức gửi thông báo cơ bản
  Future<void> sendBasicNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'basic_notifications_channel',
      'Basic Notifications',
      channelDescription: 'Channel for basic notifications',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher', // Ensure default icon is set
    );
    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformDetails,
    );
  }
}
