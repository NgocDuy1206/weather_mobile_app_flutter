import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../be/state_management/Manager.dart';
import '../../configs/constants.dart';
import '../components_search/history_search.dart';

class Destination extends StatelessWidget {
  final String? destination;

  Destination({super.key, this.destination});

  @override
  Widget build(BuildContext context) {
    var weatherManager = Provider.of<WeatherManager>(context);

    // Kiểm tra vị trí được chọn
    bool isSelected = weatherManager.currentSelected == destination;

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
              Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: 5),
              Text(
                destination!,
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
              destination: "Hiện tại",
            ),
          );
        }

        // Thêm các vị trí từ lịch sử tìm kiếm
        destinations.addAll(
          searchHistory.map((item) {
            return Destination(destination: item['name']);
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

