import 'dart:async';
import 'dart:convert';  // Đảm bảo có thư viện này để mã hóa/giải mã JSON

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Đảm bảo bạn đã cài package này
import 'package:weather_mobile_app_flutter/fe/components_search/dashed_line_separator.dart';
import '../../be/api/api.dart';
import '../../be/state_management/Manager.dart';
import '../screen/display/main_screen.dart';
import 'history_search.dart';

class SearchTextField extends StatefulWidget {
  final ValueNotifier<bool> showResultsNotifier;

  SearchTextField({required this.showResultsNotifier});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _controller = TextEditingController();
  final GetApi api = GetApi();
  List<Map<String, dynamic>> _suggestions = []; // Ensure this is initialized as an empty list
  List<Map<String, dynamic>> _searchHistory = []; // Ensure this is initialized as an empty list
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadSearchHistory(); // Tải lịch sử tìm kiếm khi mở ứng dụng
  }

  // Ánh xạ các tỉnh thành
  Map<String, String> provinceMap = {
    'ha noi': 'Hà Nội',
    'ho chi minh': 'Hồ Chí Minh',
    'da nang': 'Đà Nẵng',
    'hai phong': 'Hải Phòng',
    'can tho': 'Cần Thơ',
    'ha giang': 'Hà Giang',
    'cao bang': 'Cao Bằng',
    'bac giang': 'Bắc Giang',
    'bac kan': 'Bắc Kạn',
    'bao cai': 'Bảo Cái',
    'bac ninh': 'Bắc Ninh',
    'ben tre': 'Bến Tre',
    'binh duong': 'Bình Dương',
    'binh phuoc': 'Bình Phước',
    'binh thuan': 'Bình Thuận',
    'binh dinh': 'Bình Định',
    'dong nai': 'Đồng Nai',
    'dong thap': 'Đồng Tháp',
    'gia lai': 'Gia Lai',
    'hoa binh': 'Hòa Bình',
    'lang son': 'Lạng Sơn',
    'lam dong': 'Lâm Đồng',
    'long an': 'Long An',
    'nghe an': 'Nghệ An',
    'nam dinh': 'Nam Định',
    'ninh binh': 'Ninh Bình',
    'phu tho': 'Phú Thọ',
    'phu yen': 'Phú Yên',
    'quang binh': 'Quảng Bình',
    'quang nam': 'Quảng Nam',
    'quang ngai': 'Quảng Ngãi',
    'quang ninh': 'Quảng Ninh',
    'soc son': 'Sóc Sơn',
    'thanh hoa': 'Thanh Hóa',
    'thai binh': 'Thái Bình',
    'tien giang': 'Tiền Giang',
    'tra vinh': 'Trà Vinh',
    'tuyen quang': 'Tuyên Quang',
    'thua thien hue': 'Thừa Thiên Huế',
    'vinh phuc': 'Vĩnh Phúc',
    'yen bai': 'Yên Bái',
    'vung tau': 'Vũng Tàu',
    'thai nguyen': 'Thái Nguyên',
    'an giang': 'An Giang',
    'son la': 'Sơn La',
    'kien giang': 'Kiên Giang',
    'ben tre': 'Bến Tre',
    'ha nam': 'Hà Nam',
  };

  String getProvinceName(String province) {
    // Chuyển đổi tên tỉnh không dấu thành tên có dấu nếu có ánh xạ
    return provinceMap[province.toLowerCase()] ?? province; // Trả lại tên tỉnh gốc nếu không tìm thấy ánh xạ
  }




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


  // Hàm lưu lịch sử tìm kiếm vào SharedPreferences
  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyList = _searchHistory
        .map((e) => jsonEncode(e)) // Chuyển đối tượng thành chuỗi JSON
        .toList();
    await prefs.setStringList('search_history', historyList);
  }

  // Helper function to remove diacritical marks from Vietnamese characters
  String removeDiacritics(String text) {
    const vietnameseDiacriticsMap = {
      'á': 'a', 'à': 'a', 'ả': 'a', 'ã': 'a', 'ạ': 'a',
      'ă': 'a', 'ắ': 'a', 'ằ': 'a', 'ẳ': 'a', 'ẵ': 'a', 'ặ': 'a',
      'â': 'a', 'ấ': 'a', 'ầ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ậ': 'a',
      'é': 'e', 'è': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ẹ': 'e',
      'ê': 'e', 'ế': 'e', 'ề': 'e', 'ể': 'e', 'ễ': 'e', 'ệ': 'e',
      'í': 'i', 'ì': 'i', 'ỉ': 'i', 'ĩ': 'i', 'ị': 'i',
      'ó': 'o', 'ò': 'o', 'ỏ': 'o', 'õ': 'o', 'ọ': 'o',
      'ô': 'o', 'ố': 'o', 'ồ': 'o', 'ổ': 'o', 'ỗ': 'o', 'ộ': 'o',
      'ơ': 'o', 'ớ': 'o', 'ờ': 'o', 'ở': 'o', 'ỡ': 'o', 'ợ': 'o',
      'ú': 'u', 'ù': 'u', 'ủ': 'u', 'ũ': 'u', 'ụ': 'u',
      'ư': 'u', 'ứ': 'u', 'ừ': 'u', 'ử': 'u', 'ữ': 'u', 'ự': 'u',
      'ý': 'y', 'ỳ': 'y', 'ỷ': 'y', 'ỹ': 'y', 'ỵ': 'y',
      'đ': 'd',
      'Á': 'A', 'À': 'A', 'Ả': 'A', 'Ã': 'A', 'Ạ': 'A',
      'Ă': 'A', 'Ắ': 'A', 'Ằ': 'A', 'Ẳ': 'A', 'Ẵ': 'A', 'Ặ': 'A',
      'Â': 'A', 'Ấ': 'A', 'Ầ': 'A', 'Ẩ': 'A', 'Ẫ': 'A', 'Ậ': 'A',
      'É': 'E', 'È': 'E', 'Ẻ': 'E', 'Ẽ': 'E', 'Ẹ': 'E',
      'Ê': 'E', 'Ế': 'E', 'Ề': 'E', 'Ể': 'E', 'Ễ': 'E', 'Ệ': 'E',
      'Í': 'I', 'Ì': 'I', 'Ỉ': 'I', 'Ĩ': 'I', 'Ị': 'I',
      'Ó': 'O', 'Ò': 'O', 'Ỏ': 'O', 'Õ': 'O', 'Ọ': 'O',
      'Ô': 'O', 'Ố': 'O', 'Ồ': 'O', 'Ổ': 'O', 'Ỗ': 'O', 'Ộ': 'O',
      'Ơ': 'O', 'Ớ': 'O', 'Ờ': 'O', 'Ở': 'O', 'Ỡ': 'O', 'Ợ': 'O',
      'Ú': 'U', 'Ù': 'U', 'Ủ': 'U', 'Ũ': 'U', 'Ụ': 'U',
      'Ư': 'U', 'Ứ': 'U', 'Ừ': 'U', 'Ử': 'U', 'Ữ': 'U', 'Ự': 'U',
      'Ý': 'Y', 'Ỳ': 'Y', 'Ỷ': 'Y', 'Ỹ': 'Y', 'Ỵ': 'Y',
      'Đ': 'D'
    };

    return text.split('').map((char) {
      return vietnameseDiacriticsMap[char] ?? char;
    }).join('');
  }

  // Fetch location suggestions based on input text
  Future<void> _fetchSuggestions(String query) async {
    try {
      List<Map<String, dynamic>> suggestions = await api.searchLocation(query);
      setState(() {
        _suggestions = suggestions;
      });
      widget.showResultsNotifier.value = _suggestions.isNotEmpty;
    } catch (e) {
      print('Error fetching suggestions: $e');
    }
  }

  // Thêm vị trí đã chọn vào lịch sử
  void _addToHistory(Map<String, dynamic> suggestion) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> historyList = prefs.getStringList('search_history') ?? [];

    // Convert the string list from SharedPreferences into a list of Maps<dynamic, dynamic>
    List<Map<String, dynamic>> currentHistory = historyList.map((e) {
      try {
        var decoded = jsonDecode(e);
        if (decoded is Map<String, dynamic>) {
          return decoded; // Return the decoded map directly
        }
      } catch (error) {
        print("Error decoding history item: $error");
      }
      return <String, dynamic>{}; // Return an empty map if decoding fails
    }).toList();

    // Check if the suggestion already exists in history
    if (!currentHistory.any((item) => item['name'] == suggestion['name'])) {
      currentHistory.insert(0, suggestion); // Add the suggestion to the front of the list

      // Limit the history list to the most recent 10 items
      if (currentHistory.length > 10) {
        currentHistory = currentHistory.sublist(0, 10); // Keep only the latest 10 items
      }

      // Save the updated history list back to SharedPreferences
      final encodedHistory = currentHistory.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList('search_history', encodedHistory);
    }

    // Update the UI with the new history list
    setState(() {
      _searchHistory = currentHistory;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextField for search input
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey,
            hintText: 'Tìm kiếm thành phố',
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (value) {
            if (_debounce?.isActive ?? false) {
              _debounce?.cancel();
            }

            if (value.isNotEmpty) {
              _debounce = Timer(const Duration(milliseconds: 1000), () {
                _fetchSuggestions(removeDiacritics(value));
              });
            } else {
              setState(() {
                _suggestions = [];
                widget.showResultsNotifier.value = false;
              });
            }
          },
        ),

        // Gợi ý tìm kiếm
        if (_suggestions.isNotEmpty) ...[
          ListView.builder(
            shrinkWrap: true,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = _suggestions[index];
              // Áp dụng ánh xạ cho tên tỉnh trong trường 'name'
              final nameWithAccent = getProvinceName(suggestion['name']!);

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey, // Màu nền của vòng tròn
                      child: Transform.rotate(
                        angle: 0 * 3.14159 / 180, // Quay icon theo góc
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0), // Dịch icon một chút
                          child: Icon(Icons.location_on, color: Colors.white), // Biểu tượng là location_on
                        ),
                      ),
                    ),
                    title: Text(
                      nameWithAccent,  // Hiển thị tên tỉnh đã việt hóa
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      suggestion['region']?.isNotEmpty == true
                          ? '${suggestion['region']} - ${suggestion['country']}'
                          : suggestion['country']!,
                      style: TextStyle(color: Colors.white70),
                    ),
                    onTap: () async {
                      // widget.showResultsNotifier.value = false;
                      // Navigator.pop(context); // Đóng modal (bottom sheet)
                      // Lấy thông tin từ suggestion, ví dụ: tên địa điểm, lat, lon
                      String locationName = suggestion['name']; // Tên vị trí
                      double latitude = suggestion['lat'];      // Kinh độ
                      double longitude = suggestion['lon'];     // Vĩ độ

                      // Lưu vào lịch sử tìm kiếm (nếu cần)
                      _addToHistory(suggestion);
                      // Cập nhật vị trí trong WeatherManager
                      var weatherManager = Provider.of<WeatherManager>(context, listen: false);
                      weatherManager.updateLocation(latitude, longitude, locationName);

                      // Điều hướng tới màn hình chính
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),  // Hoặc màn hình bạn muốn chuyển đến
                        ),
                      );
                    },
                  ),
                  DashedLineSeparator(),
                ],
              );
            },
          ),
        ],




        // Lịch sử tìm kiếm
        // if (_searchHistory.isNotEmpty) ...[
        //   Padding(
        //     padding: const EdgeInsets.only(top: 8.0),
        //     child: Text(
        //       'Lịch sử tìm kiếm',
        //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        //   Column(
        //     children: _searchHistory.map((historyItem) {
        //       return ListTile(
        //         title: Text(
        //           historyItem['name']!,
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         subtitle: Text(
        //           '${historyItem['region']} - ${historyItem['country']}',
        //           style: TextStyle(color: Colors.white70),
        //         ),
        //         onTap: () {
        //           _controller.text = historyItem['name']!;
        //           widget.showResultsNotifier.value = false; // Hide search results
        //         },
        //       );
        //     }).toList(),
        //   ),
        // ],
      ],
    );
  }
}
