import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/fe/components_search/location_current.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/display_search_manageLocation/manage_location_screen.dart';
import '../../../../be/state_management/Manager.dart';
import '../../../components/loading.dart';
import '../../../components_search/dashed_line_separator.dart';
import '../../../components_search/history_search.dart';
import '../../../components_search/location_tile.dart';
import '../../../components_search/notification_history_search.dart';
import '../../../components_search/saved_locations_header.dart';
import '../../../components_search/search_text_field.dart';
import '../../display/main_screen.dart';

class SearchScreenModal extends StatefulWidget {
  @override
  _SearchScreenModalState createState() => _SearchScreenModalState();
}

class _SearchScreenModalState extends State<SearchScreenModal> {
  final ValueNotifier<bool> showResultsNotifier = ValueNotifier(false);

  StreamSubscription<void>? _searchHistorySubscription;
  List<Map<String, dynamic>> _searchHistory = []; // Lịch sử tìm kiếm với kiểu dynamic
  String latitude = '';
  String longitude = '';

// Hàm tải lịch sử tìm kiếm từ SharedPreferences
  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyList = prefs.getStringList('search_history');

    if (historyList != null) {
      setState(() {
        _searchHistory = historyList
            .map((e) {
          // Chuyển đổi JSON thành Map<String, dynamic>
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
  }

  @override
  void dispose() {
    // Đảm bảo đóng StreamController khi widget bị hủy
    SearchHistoryNotifier.dispose();
    super.dispose();
  }

  static const Map<String, IconData> iconMap = {
    'Icons.home': Icons.home,
    'Icons.school': Icons.school,
    'Icons.local_hospital': Icons.local_hospital,
    'Icons.work': Icons.work,
    'Icons.fitness_center': Icons.fitness_center,
    'Icons.park': Icons.park,
    'Icons.directions_bus': Icons.directions_bus,
    'Icons.favorite': Icons.favorite,
    'Icons.location_on': Icons.location_on,
  };

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
                          ListTile(
                            onTap: () {
                              // Thêm logic để xử lý khi nhấn vào
                              // Ví dụ: hiển thị quyền truy cập vị trí
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: const Color(0xFF1E1E2C),
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Quyền truy cập vị trí',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      'Ứng dụng cần truy cập vị trí của bạn để cung cấp thông tin phù hợp. Bạn có muốn cho phép?',
                                      style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 16,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          // Gọi hàm getLocation để lấy vị trí

                                          Position? position = await LocationService.getLocation();

                                          if (position != null) {
                                            // Hiển thị màn hình Loading với CircularProgressIndicator
                                            // Gọi API để xử lý dữ liệu thời tiết
                                            String locationName = 'Hiện tại'; // Tên vị trí
                                            double latitude = position.latitude; // Kinh độ
                                            double longitude = position.longitude; // Vĩ độ

                                            // Lưu vị trí hiện tại
                                            await SharedPreferencesHelper.saveCurrentLocation(latitude, longitude);

                                            // Cập nhật vị trí trong WeatherManager
                                            var weatherManager = Provider.of<WeatherManager>(context, listen: false);
                                            weatherManager.updateLocation(latitude, longitude, locationName);

                                            // Đóng Loading dialog sau khi hoàn tất
                                            Navigator.pop(context);

                                            // Điều hướng đến màn hình chính
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MainScreen(), // Hoặc màn hình bạn muốn chuyển đến
                                              ),
                                            );

                                            // Hiển thị vị trí trong SnackBar
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Vị trí hiện tại: Kinh độ: $longitude, Vĩ độ: $latitude'),
                                                duration: Duration(seconds: 5),
                                              ),
                                            );
                                          }

                                          else {
                                            // Thông báo khi không có quyền truy cập vị trí
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Ứng dụng không có quyền truy cập vị trí của bạn.'),
                                                duration: Duration(seconds: 5),  // Hiển thị trong 5 giây
                                              ),
                                            );
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.blue,
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          'Đồng ý',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.grey[400],
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        ),
                                        child: Text(
                                          'Hủy',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },

                              );
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Transform.rotate(
                                angle: 30 * 3.14159 / 180, // Xoay góc 30 độ
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Icon(Icons.navigation, color: Colors.white),
                                ),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Vị trí hiện tại',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 8),

                                    SizedBox(width: 4),
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Nhấn để lấy vị trí',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Saved Locations', style: TextStyle(color: Colors.white, fontSize: 18)),
                                TextButton(
                                  onPressed: () async {
                                    // Điều hướng tới ManageScreen và quay lại khi người dùng bấm 'Back'
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ManageScreen()),
                                    );
                                    if (result == null) {
                                      // Nếu có dữ liệu trả về (nếu cần) gọi lại _loadSearchHistory
                                      _loadSearchHistory();
                                    }
                                  },
                                  child: Text('Manage', style: TextStyle(color: Colors.blue, fontSize: 16)),
                                ),
                              ],
                            ),
                          ),
                          // Hiển thị lịch sử tìm kiếm dưới "Địa điểm 3"
                          if (_searchHistory.isNotEmpty) ...[
                            Column(
                              children: _searchHistory.map((historyItem) {
                                IconData iconData = iconMap[historyItem['icon']] ?? Icons.help;
                                String displayLabel = historyItem['customerName']?.isEmpty ?? true ? historyItem['name'] : historyItem['customerName']!;
                                String displayLocation = historyItem['customerName']?.isEmpty ?? true
                                    ? (historyItem['region']?.isNotEmpty == true
                                    ? '${historyItem['region']} - ${historyItem['country']}'
                                    : historyItem['country']!)
                                    : historyItem['name']!;

                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey, // Màu xám cho vòng tròn
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 1.0), // Dịch icon một chút
                                          child: Icon(iconData, color: Colors.white), // Biểu tượng location_on
                                        ),
                                      ),
                                      title: Text(
                                        displayLabel,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        displayLocation,
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      onTap: () async {
                                        // Lấy thông tin từ suggestion, ví dụ: tên địa điểm, lat, lon
                                        String locationName = historyItem['name']; // Tên vị trí
                                        double latitude = historyItem['lat'];      // Kinh độ
                                        double longitude = historyItem['lon'];     // Vĩ độ


                                        // Cập nhật vị trí trong WeatherManager
                                        var weatherManager = Provider.of<WeatherManager>(context, listen: false);
                                        weatherManager.updateLocation(latitude, longitude, locationName);

                                        Navigator.pop(context); // Đóng modal (bottom sheet)

                                        // Điều hướng tới màn hình chính
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MainScreen(),  // Hoặc màn hình bạn muốn chuyển đến
                                          ),
                                        );
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
