import 'dart:convert';
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
    List<String> jsonHistory = prefs.getStringList('search_history') ?? [];
    List<Map<String, String>> history = jsonHistory
        .map((item) => Map<String, String>.from(jsonDecode(item)))
        .toList();
    return history;
  }
}
