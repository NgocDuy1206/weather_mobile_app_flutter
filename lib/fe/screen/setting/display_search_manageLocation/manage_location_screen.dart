import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/fe/components_search/dashed_line_separator.dart';
import 'dart:convert'; // Để sử dụng jsonDecode

import '../../../components_manage_location/component_delete_location/delete_confirmation_dialog.dart';
import '../../../components_manage_location/dashed_separator.dart';
import '../../../components_manage_location/instruction_text.dart';
import '../../../components_manage_location/location_item_manage.dart';
import '../../../components_search/history_search.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
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
    _loadSearchHistory(); // Tải lịch sử tìm kiếm khi mở ứng dụng
  }

  // Hàm chuyển đổi lịch sử tìm kiếm thành danh sách các LocationItemManage
  List<Widget> _buildLocationItems() {
    return _searchHistory.map((item) {
      String locationDisplay = item['region'] != null && item['region']!.isNotEmpty
          ? '${item['region']}, ${item['country']}'
          : item['country'] ?? 'Unknown Location'; // Nếu không có region thì chỉ hiển thị country

      return Padding(
        padding: const EdgeInsets.only(right: 0.0), // Dịch sang phải
        child: Column(
          children: [
            LocationItemManage(
              label: item['name'] ?? 'Unknown Location', // Thay label thành name
              location: locationDisplay, // Thay location thành region và country
              onEdit: () {
                // Xử lý khi nhấn nút chỉnh sửa
              },
              onDelete: (confirmed) async {
                if (confirmed) {
                  // Gọi hàm xóa nếu người dùng chọn "Yes"
                  await SharedPreferencesHelper.removeSearchHistoryItem(
                      item['name'] ?? '', // Truyền name
                      item['country'] ?? ''  // Truyền country
                  );

                  // Cập nhật lại giao diện
                  setState(() {
                    _searchHistory.remove(item); // Xóa item khỏi danh sách
                  });
                }
              },
            ),
            SizedBox(height: 8),
            DashedLineSeparator(),  // Thêm dòng nét đứt sau mỗi item
          ],
        ),
      );
    }).toList();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Locations'),
        backgroundColor: Color(0xFF1A0A1A),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Color(0xFF1A0A1A),
      body: _searchHistory.isEmpty
          ? Center(child: CircularProgressIndicator()) // Chờ dữ liệu khi tải
          : ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Transform.rotate(
                angle: 30 * 3.14159 / 180,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: Icon(Icons.navigation, color: Colors.white, size: 24),
                ),
              ),
            ),
            title: Text('Cầu Giấy', style: TextStyle(color: Colors.white)),
            subtitle: Text('Cầu Giấy, Cầu Giấy, VN', style: TextStyle(color: Colors.white54)),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'SAVED LOCATIONS',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Click, hold and move the lever to change the position of your locations.',
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
          SizedBox(height: 10),
          // Hiển thị danh sách các LocationItemManage từ lịch sử tìm kiếm
          ..._buildLocationItems(),
          SizedBox(height: 16),
          InstructionText(
            text: 'Tap on the edit icon to add a label. For e.g., Home, Office.',
          ),
        ],
      ),
    );
  }
}
