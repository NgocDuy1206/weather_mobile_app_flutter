import 'package:flutter/material.dart';
import '../../../components_search/dashed_line_separator.dart';
import '../../../components_search/location_tile.dart';
import '../../../components_search/saved_locations_header.dart';
import '../../../components_search/search_text_field.dart';



class SearchScreenModal extends StatelessWidget {
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
                SearchTextField(),
                SizedBox(height: 10),
                LocationTile(
                  name: 'Tên Địa Chỉ',
                  address: 'Địa chỉ chi tiết',
                  temperature: '25°C',
                  circleColor: Colors.blue,
                  icon: Icons.navigation,
                  iconAngle: 30,
                ),
                SavedLocationsHeader(),
                SizedBox(height: 1),
                LocationTile(
                  name: 'Địa điểm 2',
                  address: 'Địa chỉ chi tiết 2',
                  temperature: '22°C',
                  circleColor: Colors.grey,
                  icon: Icons.place,
                ),
                DashedLineSeparator(),
                LocationTile(
                  name: 'Địa điểm 3',
                  address: 'Địa chỉ chi tiết 3',
                  temperature: '20°C',
                  circleColor: Colors.grey,
                  icon: Icons.place,
                ),
                DashedLineSeparator(),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
