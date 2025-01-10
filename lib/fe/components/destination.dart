import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../be/state_management/Manager.dart';
import '../../configs/constants.dart';
import '../../configs/utils.dart';
import '../components_search/history_search.dart';

class Destination extends StatelessWidget {
  final String? destination;
  final String? iconData; // Thêm biến để nhận iconData
  final String? customerName;

  Destination({super.key, this.destination, this.customerName, this.iconData});

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
    var weatherManager = Provider.of<WeatherManager>(context);

    // Kiểm tra vị trí được chọn
    bool isSelected = weatherManager.currentSelected == destination;
    // Lấy iconData từ truyền vào hoặc dùng mặc định
    IconData icon = iconData != null ? iconMap[iconData] ?? Icons.location_on : Icons.location_on;
    String? displayLabel = customerName?.isEmpty ?? true ? destination : customerName;

    return Container(
      child: InkWell(
        onTap: () async {
          if (destination == "Hiện tại") {
            // Lấy vị trí hiện tại từ SharedPreferences
            var currentResult = await SharedPreferencesHelper.getCurrentLocation();
            if (currentResult != null) {
              double latitude = currentResult['latitude']!;
              double longitude = currentResult['longitude']!;
              weatherManager.updateLocation(latitude, longitude, "Hiện tại");
            }
          } else {
            // Xử lý khi destination là vị trí từ lịch sử tìm kiếm
            var searchResult = await SharedPreferencesHelper.getSearchHistoryByName(destination!);
            if (searchResult != null) {
              double latitude = searchResult['lat'];
              double longitude = searchResult['lon'];
              weatherManager.updateLocation(latitude, longitude, destination!);
            }
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : MyColors.GRAY, // Màu xanh cho vị trí được chọn
            borderRadius: BorderRadius.all(Radius.circular(19)),
          ),
          child: Row(

            children: [
              Transform.translate(
                offset: Offset(0, -3), // Dịch lên một chút (giảm giá trị y để di chuyển lên trên)
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 25, // Giảm kích thước của icon
                ),
              ),
              SizedBox(width: 5),
              Text(
                displayLabel!,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

        ),
      ),
    );
  }
}



class ListDestination extends StatelessWidget {
  final List<Map<String, dynamic>> searchHistory;

  ListDestination({super.key, required this.searchHistory});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>?>(
      future: SharedPreferencesHelper.getCurrentLocation(),
      builder: (context, snapshot) {
        List<Widget> destinations = [];

        // Thêm vị trí hiện tại nếu có
        if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
          destinations.add(
            Destination(
              destination: Utils.getText("Currently"),
              customerName: '',
              iconData: 'Icons.location_on', // Gán icon mặc định cho "Hiện tại"
            ),
          );
        }

        // Thêm các vị trí từ lịch sử tìm kiếm
        destinations.addAll(
          searchHistory.map((item) {
            return Destination(
              destination: item['name'],
              customerName: item['customerName'],
              iconData: item['icon'], // Truyền icon từ lịch sử tìm kiếm
            );
          }).toList(),
        );

        return Container(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: destinations,
          ),
        );
      },
    );
  }
}


