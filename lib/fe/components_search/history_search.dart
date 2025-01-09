import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save search history as a list of maps (converted to JSON)
  static Future<void> saveSearchHistory(List<Map<String, dynamic>> history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonHistory = history.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('search_history', jsonHistory);
  }

  // Get search history as a list of maps
  static Future<List<Map<String, dynamic>>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonHistory = prefs.getStringList('search_history');
    if (jsonHistory == null) {
      return [];
    }
    // Giải mã danh sách JSON trở lại thành Map<String, dynamic>
    return jsonHistory.map((item) {
      return jsonDecode(item) as Map<String, dynamic>;
    }).toList();
  }

  // Get a specific search history item by 'name'
  static Future<Map<String, dynamic>?> getSearchHistoryByName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonHistory = prefs.getStringList('search_history');
    if (jsonHistory == null) {
      return null;
    }

    // Tìm kiếm trong danh sách lịch sử và trả về đối tượng có tên khớp với 'name'
    for (String item in jsonHistory) {
      Map<String, dynamic> decodedItem = jsonDecode(item);
      if (decodedItem['name'] == name) {
        return decodedItem; // Trả về đối tượng nếu tên khớp
      }
    }

    // Trả về null nếu không tìm thấy
    return null;
  }

  // Save current location
  static Future<void> saveCurrentLocation(double latitude, double longitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, double> location = {
      'latitude': latitude,
      'longitude': longitude,
    };
    await prefs.setString('current_location', jsonEncode(location));
  }

  // Get current location
  static Future<Map<String, double>?> getCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonLocation = prefs.getString('current_location');
    if (jsonLocation == null) {
      return null;
    }
    // Decode JSON back to Map<String, double>
    return (jsonDecode(jsonLocation) as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, value as double));
  }

  // Xóa phần tử tìm kiếm dựa trên tên và quốc gia
  static Future<bool> removeSearchHistoryItem(String name, String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy danh sách lịch sử tìm kiếm từ SharedPreferences
    List<String> jsonHistory = prefs.getStringList('search_history') ?? [];

    // Chuyển danh sách các item từ JSON thành danh sách Map<String, dynamic>
    List<Map<String, dynamic>> history = jsonHistory
        .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
        .toList();

    // Kiểm tra nếu tên là "Unknown Location"
    if (name == "Unknown Location") {
      // Xóa tất cả các phần tử có tên là "Unknown Location"
      history.removeWhere((item) => item['name'] == 'Unknown Location');
    } else {
      // Kiểm tra xem có phần tử cần xóa hay không (dựa trên tên và quốc gia)
      bool itemRemoved = history.any((item) =>
      item['name'] == name && item['country'] == country);

      // Xóa phần tử có tên và quốc gia khớp
      history.removeWhere((item) =>
      item['name'] == name && item['country'] == country);

      // Nếu còn dữ liệu sau khi xóa, lưu lại vào SharedPreferences
      if (history.isNotEmpty) {
        List<String> updatedJsonHistory = history
            .map((item) => jsonEncode(item)) // Convert to JSON string
            .toList();
        await prefs.setStringList('search_history', updatedJsonHistory);
      } else {
        // Nếu không còn dữ liệu sau khi xóa, xóa toàn bộ lịch sử
        await prefs.remove('search_history');
      }

      return itemRemoved; // Trả về true nếu có phần tử đã được xóa
    }

    // Nếu không phải "Unknown Location", lưu lại lịch sử đã thay đổi
    List<String> updatedJsonHistory = history
        .map((item) => jsonEncode(item)) // Convert to JSON string
        .toList();
    await prefs.setStringList('search_history', updatedJsonHistory);

    return true; // Đảm bảo trả về true khi đã xóa các phần tử rỗng
  }



  // Cập nhật giá trị của customerName và icon trong đối tượng có name là 'Name'
  static Future<void> updateCustomerSearchHistory(String name, String newCustomerName, String newIcon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Tìm đối tượng có name là 'name'
    Map<String, dynamic>? existingEntry = await getSearchHistoryByName(name);

    if (existingEntry != null) {
      // Nếu tìm thấy, cập nhật customerName và icon
      existingEntry['customerName'] = newCustomerName;
      existingEntry['icon'] = newIcon.toString(); // Chuyển IconData thành String

      // Lấy toàn bộ lịch sử hiện tại
      List<Map<String, dynamic>> history = await getSearchHistory();

      // Cập nhật lại đối tượng trong danh sách
      history.removeWhere((entry) => entry['name'] == name);
      history.add(existingEntry);

      // Lưu lại lịch sử đã cập nhật
      await saveSearchHistory(history);
    } else {
      // Nếu không tìm thấy, có thể thêm mới hoặc không làm gì
      print('Không tìm thấy đối tượng có name = $name');
    }
  }

  // Xóa phần tử tìm kiếm dựa trên trường customerName là "helo"
  static Future<bool> removeSearchHistoryByCustomerName(String customerName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy danh sách lịch sử tìm kiếm từ SharedPreferences
    List<String> jsonHistory = prefs.getStringList('search_history') ?? [];

    // Chuyển danh sách các item từ JSON thành danh sách Map<String, dynamic>
    List<Map<String, dynamic>> history = jsonHistory
        .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
        .toList();

    // Kiểm tra xem có phần tử có customerName là "helo"
    bool itemRemoved = history.any((item) =>
    item['customerName'] == customerName);

    // Xóa các phần tử có customerName là "helo"
    history.removeWhere((item) =>
    item['customerName'] == customerName);

    // Nếu còn dữ liệu sau khi xóa, lưu lại vào SharedPreferences
    if (history.isNotEmpty) {
      List<String> updatedJsonHistory = history
          .map((item) => jsonEncode(item)) // Convert to JSON string
          .toList();
      await prefs.setStringList('search_history', updatedJsonHistory);
    } else {
      // Nếu không còn dữ liệu sau khi xóa, xóa toàn bộ lịch sử
      await prefs.remove('search_history');
    }

    return itemRemoved; // Trả về true nếu có phần tử đã được xóa
  }







}
