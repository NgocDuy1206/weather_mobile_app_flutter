import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/fe/components_search/dashed_line_separator.dart';
import 'dart:convert'; // Để sử dụng jsonDecode

import '../../../../configs/utils.dart';
import '../../../components_manage_location/component_delete_location/delete_confirmation_dialog.dart';
import '../../../components_manage_location/component_edit_location/Location_Modal.dart';
import '../../../components_manage_location/dashed_separator.dart';
import '../../../components_manage_location/instruction_text.dart';
import '../../../components_manage_location/location_item_manage.dart';
import '../../../components_search/history_search.dart';
import '../../../components_search/notification_history_search.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List<Map<String, dynamic>> _searchHistory = []; // Lịch sử tìm kiếm với kiểu dynamic
  Map<String, double>? _currentLocation; // Lưu vị trí hiện tại
// Hàm tải lịch sử tìm kiếm từ SharedPreferences
  // Hàm tải lịch sử tìm kiếm từ SharedPreferences
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyList = prefs.getStringList('search_history');

    if (historyList != null) {
      setState(() {
        _searchHistory = historyList
            .map((e) {
          // Giải mã JSON thành Map<String, dynamic> để có thể xử lý các kiểu dữ liệu khác nhau
          var decoded = jsonDecode(e);
          if (decoded is Map<String, dynamic>) {
            return decoded; // Trả về Map nếu là kiểu Map<String, dynamic>
          } else {
            return <String, dynamic>{}; // Nếu không phải Map, trả về Map rỗng
          }
        })
            .toList();
      });
    }
  }

  // Hàm lấy vị trí hiện tại
  Future<void> _loadCurrentLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonLocation = prefs.getString('current_location');
    if (jsonLocation != null) {
      setState(() {
        _currentLocation = (jsonDecode(jsonLocation) as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value as double));
      });
    }
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Gọi lại _loadSearchHistory mỗi khi widget cần phải làm mới (kể cả khi quay lại trang)
    _loadSearchHistory();
  }

  @override
  void initState() {
    super.initState();
    SearchHistoryNotifier.historyUpdatedStream.listen((_) {
      _loadSearchHistory();  // Cập nhật lại danh sách
    });
    // Tải lịch sử tìm kiếm khi mở ứng dụng
    _loadSearchHistory();
    _loadCurrentLocation();
  }

  @override
  void dispose() {
    // Đảm bảo đóng StreamController khi widget bị hủy
    SearchHistoryNotifier.dispose();
    super.dispose();
  }

  // Hàm chuyển đổi lịch sử tìm kiếm thành danh sách các LocationItemManage
  List<Widget> _buildLocationItems() {
    return _searchHistory.map((item) {
      String locationDisplay = item['region'] != null && item['region']!.isNotEmpty
          ? '${item['region']}, ${item['country']}'
          : item['country'] ?? 'Unknown Location'; // Nếu không có region thì chỉ hiển thị country

      return Padding(
        padding: const EdgeInsets.only(left: 2.0), // Dịch sang phải
        child: Column(
          children: [
            LocationItemManage(
              label: item['name'] ?? 'Unknown Location', // Thay label thành name
              location: locationDisplay,
              icon: item['icon'],
              customerName: item['customerName'],
                // OK
                onEdit: () async {
                  final updatedLocationData = await showModalBottomSheet<LabelData>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return EditLocationModal(
                        location: locationDisplay,
                        label: item['name'] ?? 'Unknown Location',
                        customerName: item['customerName'],
                        icon: item['icon'],
                        // Cung cấp icon mặc định

                      );
                    },
                  );

                  // Kiểm tra nếu có giá trị trả về từ modal
                  if (updatedLocationData != null) {
                    // Lưu vào SharedPreferences
                    await SharedPreferencesHelper.updateCustomerSearchHistory(item['name'],updatedLocationData.label, updatedLocationData.icon);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ManageScreen()),  // Thay ManageScreen với màn hình hiện tại của bạn
                    );
                    SearchHistoryNotifier.notifyHistoryUpdated();
                  }
                },

                onDelete: (confirmed) async {
                  if (confirmed) {
                    bool success = await SharedPreferencesHelper.removeSearchHistoryItem(
                        item['name'] ?? '',
                        item['country'] ?? ''
                    );

                    // bool suc = await SharedPreferencesHelper.removeSearchHistoryByCustomerName(
                    //     item['customerName'] ?? '',
                    // );

                    if (success) {
                      setState(() {
                        _searchHistory.remove(item);
                      });
                      // Hiển thị thông báo xóa thành công
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(Utils.getText('Item removed successfully')),
                          duration: Duration(seconds: 2),  // Đặt thời gian hiển thị SnackBar là 2 giây
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ManageScreen()),  // Thay ManageScreen với màn hình hiện tại của bạn
                      );
                      SearchHistoryNotifier.notifyHistoryUpdated();

                    } else {
                      // Hiển thị thông báo lỗi nếu không tìm thấy mục cần xóa
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(Utils.getText('Item not found in history')))
                      );
                    }
                  }
                }

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
            contentPadding: EdgeInsets.only(left: 24.0), // Dịch toàn bộ cụm sang trái
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 22.5, // Tăng kích thước vòng tròn
              child: Transform.rotate(
                angle: 30 * 3.14159 / 180, // Xoay biểu tượng
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                    size: 27, // Tăng kích thước biểu tượng bên trong vòng tròn
                  ),
                ),
              ),
            ),
            title: Text(
              Utils.getText('Current location'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.2, // Tăng kích thước chữ title
              ),
            ),
            subtitle: Text(
              '${Utils.getText('Long')}: ${_currentLocation?['longitude']}, ${Utils.getText('Lat')}: ${_currentLocation?['latitude']}',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 14, // Tăng kích thước chữ subtitle
              ),
            ),
          ),

          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              Utils.getText('SAVED LOCATIONS'),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.5, // Tăng kích thước chữ
              ),
            ),

          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              Utils.getText('Click, hold and move the lever to change the position of your locations.'),
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.white54, fontSize: 14.5),
            ),
          ),
          SizedBox(height: 10),
          // Hiển thị danh sách các LocationItemManage từ lịch sử tìm kiếm
          ..._buildLocationItems(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Cách mép trái/phải 16px
            child: InstructionText(
              text: Utils.getText('Tap on the edit icon to add a label. For e.g., Home, Office...'),
            ),
          )
        ],
      ),
    );
  }
}
