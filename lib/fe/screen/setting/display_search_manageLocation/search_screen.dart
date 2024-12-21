import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../components_search/dashed_line_separator.dart';
import '../../../components_search/location_tile.dart';
import '../../../components_search/notification_history_search.dart';
import '../../../components_search/saved_locations_header.dart';
import '../../../components_search/search_text_field.dart';

class SearchScreenModal extends StatefulWidget {
  @override
  _SearchScreenModalState createState() => _SearchScreenModalState();
}

class _SearchScreenModalState extends State<SearchScreenModal> {
  final ValueNotifier<bool> showResultsNotifier = ValueNotifier(false);
  List<Map<String, String>> _searchHistory = []; // Lịch sử tìm kiếm

  // Hàm tải lịch sử tìm kiếm từ SharedPreferences
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyList = prefs.getStringList('searchHistory');
    if (historyList != null) {
      setState(() {
        _searchHistory = historyList
            .map((e) => Map<String, String>.from(
            jsonDecode(e) as Map<String, dynamic>)) // Chuyển đổi JSON thành Map
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SearchHistoryNotifier.historyUpdatedStream.listen((_) {
      _loadSearchHistory();  // Cập nhật lại danh sách
    });
    // Tải lịch sử tìm kiếm khi mở ứng dụng
    _loadSearchHistory();
  }

  @override
  void dispose() {
    // Đảm bảo đóng StreamController khi widget bị hủy
    SearchHistoryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SearchTextField(
                  showResultsNotifier: showResultsNotifier,
                  // Hàm callback để cập nhật lịch sử tìm kiếm sẽ được xử lý ở đây nếu cần
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: showResultsNotifier,
                  builder: (context, showResults, child) {
                    return Visibility(
                      visible: !showResults,
                      child: Column(
                        children: [
                          SizedBox(height: 2),
                          LocationTile(
                            name: 'Tên Địa Chỉ',
                            address: 'Địa chỉ chi tiết',
                            temperature: '25°C',
                            circleColor: Colors.blue,
                            icon: Icons.navigation,
                            iconAngle: 30,
                          ),
                          SavedLocationsHeader(),
                          // Hiển thị lịch sử tìm kiếm dưới "Địa điểm 3"
                          if (_searchHistory.isNotEmpty) ...[
                            Column(
                              children: _searchHistory.map((historyItem) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey, // Màu xám cho vòng tròn
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 1.0), // Dịch icon một chút
                                          child: Icon(Icons.location_on, color: Colors.white), // Biểu tượng location_on
                                        ),
                                      ),
                                      title: Text(
                                        historyItem['name']!,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        historyItem['region']?.isNotEmpty == true
                                            ? '${historyItem['region']} - ${historyItem['country']}'
                                            : historyItem['country']!,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      onTap: () {
                                        // Xử lý khi người dùng nhấn vào lịch sử tìm kiếm
                                        // Cập nhật lại text vào TextField và ẩn kết quả tìm kiếm
                                        // _controller.text = historyItem['name']!; // Cập nhật text vào TextField
                                        showResultsNotifier.value = false; // Ẩn kết quả tìm kiếm
                                      },
                                    ),
                                    DashedLineSeparator(), // Thêm dấu đứt đoạn dưới mỗi phần tử lịch sử tìm kiếm
                                    SizedBox(height: 0), // Thêm khoảng cách đều giữa các phần tử
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
