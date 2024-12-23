import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationService {
  // Hàm yêu cầu quyền truy cập vị trí và lấy vị trí hiện tại
  static Future<Position?> getLocation() async {
    // Kiểm tra quyền truy cập vị trí
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Nếu quyền bị từ chối, trả về null
      return null;
    } else {
      // Lấy vị trí hiện tại của người dùng
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;  // Trả về vị trí
    }
  }
}
