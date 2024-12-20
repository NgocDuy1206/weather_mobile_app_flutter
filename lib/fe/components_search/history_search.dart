import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Save search history as a list of maps (converted to JSON)
  static Future<void> saveSearchHistory(List<Map<String, String>> history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonHistory = history.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('search_history', jsonHistory);
  }

  // Get search history as a list of maps
  static Future<List<Map<String, String>>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> jsonHistory = prefs.getStringList('searchHistory') ?? [];
    List<Map<String, String>> history = jsonHistory
        .map((item) => Map<String, String>.from(jsonDecode(item)))
        .toList();
    return history;
  }

  // Xóa phần tử tìm kiếm dựa trên tên và quốc gia
  static Future<bool> removeSearchHistoryItem(String name, String country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Lấy danh sách lịch sử tìm kiếm từ SharedPreferences
    List<String> jsonHistory = prefs.getStringList('searchHistory') ?? [];

    // Chuyển danh sách các item từ JSON thành danh sách Map
    List<Map<String, String>> history = jsonHistory
        .map((item) => Map<String, String>.from(jsonDecode(item)))
        .toList();

    // Kiểm tra xem có phần tử cần xóa hay không
    bool itemRemoved = history.any((item) => item['name'] == name && item['country'] == country);

    // Xóa phần tử có tên và quốc gia khớp
    history.removeWhere((item) => item['name'] == name && item['country'] == country);

    // Nếu còn dữ liệu sau khi xóa, lưu lại vào SharedPreferences
    if (history.isNotEmpty) {
      List<String> updatedJsonHistory = history.map((item) => jsonEncode(item)).toList();
      await prefs.setStringList('searchHistory', updatedJsonHistory);
    } else {
      // Nếu không còn dữ liệu sau khi xóa, xóa toàn bộ lịch sử
      await prefs.remove('searchHistory');
    }

    return itemRemoved; // Trả về true nếu có phần tử đã được xóa
  }

}
