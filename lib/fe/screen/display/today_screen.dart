import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/setting_screen.dart';

import '../../../configs/constants.dart';
import '../../components/air_quality_table.dart';
import '../../components/allery_outlook_table.dart';
import '../../components/current_detail_table.dart';
import '../../components/daily_forecast_table.dart';
import '../../components/destination.dart';
import '../../components/hourly_forecast_table.dart';
import '../../components/sun_moon_table.dart';
import '../../components/weather_now.dart';

import '../../components_search/notification_history_search.dart';
import '../setting/display_search_manageLocation/search_screen.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final ValueNotifier<bool> showResultsNotifier = ValueNotifier(false);
  List<Map<String, dynamic>> _searchHistory = []; // Lịch sử tìm kiếm với kiểu dynamic

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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        Utils.getBackGround(),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              Constants.NAME_APP,
              style: TextStyle(
                color: MyColors.WHITE,
              ),
            ),
            floating: true,
            pinned: false,
            backgroundColor: Colors.transparent,
            snap: true,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  SizedBox(height: 90),
                  ListDestination(searchHistory: _searchHistory),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  // Mở modal và đợi kết quả trả về
                  final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Color(0xFF1A0A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (BuildContext context) {
                      return SearchScreenModal();  // Modal tìm kiếm
                    },
                  );

                  // Kiểm tra nếu có kết quả trả về từ modal
                  if (result == null) {
                    // Nếu có kết quả, tải lại lịch sử tìm kiếm
                    _loadSearchHistory();
                  }
                },
                icon: Image.asset('assets/icon/search.png'),
              ),

              IconButton(
                onPressed: () async {
                  // Mở màn hình SettingScreen và đợi kết quả trả về
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );

                  // Kiểm tra nếu có kết quả trả về từ SettingScreen
                  if (result == null) {
                    // Nếu có kết quả, tải lại lịch sử tìm kiếm hoặc thực hiện hành động khác
                    _loadSearchHistory();
                  }
                },
                icon: Image.asset('assets/icon/menu.png'),
              )

            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [

                WeatherNow(),

                Container(
                  width: InforDevice.WIDTH,
                  padding: EdgeInsets.only(top: 25, bottom: 10),
                  decoration: const BoxDecoration(
                    color: MyColors.background_theme,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Text(Utils.getText('hourly_forecast'), style: TextStyle(fontSize: 20),),
                      HourlyForecastTable(),
                      Text(Utils.getText('current_details'), style: TextStyle(fontSize: 20),),
                      CurrentDetailTable(),
                      Text(Utils.getText('daily_forecast'), style: TextStyle(fontSize: 20),),
                      DailyForecastTable(),
                      Text(Utils.getText('air_quality'), style: TextStyle(fontSize: 20),),
                      AirQualityTable(),
                      Text(Utils.getText('allergy_outlook'), style: TextStyle(fontSize: 20),),
                      AllergyOutlookTable(),
                      Text(Utils.getText('sun_moon'), style: TextStyle(fontSize: 20),),
                      SunMoonTable(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
