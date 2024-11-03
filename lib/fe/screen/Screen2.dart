import 'package:flutter/material.dart';
class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Color(0xFF1A0A1A), // Modal background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
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
                            TextField(
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
                            ),
                            SizedBox(height: 20),
                            // Current location with a rotated icon
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue, // Current location circle color
                                child: Transform.rotate(
                                  angle: 30 * 3.14159 / 180, // Rotate icon 30 degrees
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2.0), // Adjust padding to move the icon left
                                    child: Icon(Icons.navigation, color: Colors.white, size: 24), // Size the icon appropriately
                                  ),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Tên Địa Chỉ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 8), // Space between name and icon
                                      Icon(Icons.brightness_3, color: Colors.yellow), // Moon icon
                                      SizedBox(width: 4),
                                      Text(
                                        '25°C',
                                        style: TextStyle(color: Colors.white, fontSize: 16), // Temperature
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Địa chỉ chi tiết',
                                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            // Save Locations and Manage buttons
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Saved Locations',
                                    style: TextStyle(color: Colors.white, fontSize: 16), // Color for Save Locations
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ManageScreen()),
                                      );
                                    },
                                    child: Text(
                                      'Manage',
                                      style: TextStyle(color: Colors.blue), // Màu chữ của nút Manage
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5), // Space between location list and buttons
                            // Other locations (if needed)
                            _buildLocationItem('Địa điểm 2', 'Địa chỉ chi tiết 2', '22°C', Colors.grey),
                            _buildDashedLine(),
                            _buildLocationItem('Địa điểm 3', 'Địa chỉ chi tiết 3', '20°C', Colors.grey),
                            _buildDashedLine(),
                            SizedBox(height: 10), // Space below the last dashed line
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          child: Text('Mở Tìm Kiếm'),
        ),
      ),
    );
  }

  // Hàm này là chỉnh phần saved location
  Widget _buildLocationItem(String name, String address, String temperature, Color circleColor) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: circleColor,
        child: Icon(Icons.place, color: Colors.grey[300]),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(width: 8),
              Icon(Icons.brightness_3, color: Colors.yellow),
              SizedBox(width: 4),
              Text(
                temperature,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Text(
            address,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
        ],
      ),
    );
  }

  //Hàm này là chỉnh phần nét đứt
  Widget _buildDashedLine() {
    return Container(
      height: 1, // Height of the dashed line
      margin: const EdgeInsets.symmetric(vertical: 2), // Adjust the margin to make lines closer
      child: Row(
        children: List.generate(60, (index) {
          return Expanded(
            child: Container(
              height: 1,
              color: index % 2 == 0 ? Colors.grey : Colors.transparent, // Alternate colors for dashed effect
            ),
          );
        }),
      ),
    );
  }
}



//Hàm này là phần manage location
class ManageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Locations'),
        backgroundColor: Color(0xFF1A0A1A), // Same color as the modal
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      backgroundColor: Color(0xFF1A0A1A), // Background color for the screen
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First location item with a rotated and scaled icon
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue, // Blue background for the icon
              child: Transform.rotate(
                angle: 30 * 3.14159 / 180, // Rotate icon 30 degrees
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0), // Adjust padding to move the icon left
                  child: Icon(Icons.navigation, color: Colors.white, size: 24), // Size the icon appropriately
                ),
              ),
            ),
            title: Text('Cầu Giấy', style: TextStyle(color: Colors.white)),
            subtitle: Text('Cầu Giấy, Cầu Giấy, VN', style: TextStyle(color: Colors.white54)),
          ),
          SizedBox(height: 16),
          // SAVED LOCATIONS text
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Align text to the left
            child: Text(
              'SAVED LOCATIONS',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // Change color to white
            ),
          ),
          SizedBox(height: 8), // Space between texts
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Align text to the left
            child: Text(
              'Click, hold and move the lever to change the position of your locations.',
              style: TextStyle(color: Colors.white54, fontSize: 14), // Slightly smaller font size
            ),
          ),
          SizedBox(height: 10),
          // Additional location items
          _buildLocationItemManage(
            label: 'Hoi An Corner Coffee',
            location: 'Hoàn Kiếm, Hà Nội, VN',
          ),
          _buildDashedSeparator(), // Dashed line after the first item
          _buildLocationItemManage(
            label: 'Đà Nẵng',
            location: 'Đà Nẵng, VN',
          ),
          _buildDashedSeparator(), // Dashed line below this item
          SizedBox(height: 16),
          Center(
            child: Text(
              'Tap on the edit icon to add a label. For e.g., Home, Office.',
              style: TextStyle(color: Colors.white54, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationItemManage({required String label, required String location}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey, // Gray background for location icon
        child: Icon(Icons.location_on, color: Colors.white),
      ),
      title: Text(label, style: TextStyle(color: Colors.white)),
      subtitle: Text(location, style: TextStyle(color: Colors.white54)), // Removed padding
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black, // Black background for edit button
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                // Handle edit action here
              },
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.black, // Black background for delete button
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                // Handle delete action here
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDashedSeparator() {
    return Container(
      height: 1, // Height of the dashed line
      margin: const EdgeInsets.symmetric(vertical: 2), // Adjust the margin to make lines closer
      child: Row(
        children: List.generate(60, (index) {
          return Expanded(
            child: Container(
              height: 1,
              color: index % 2 == 0 ? Colors.grey : Colors.transparent, // Alternate colors for dashed effect
            ),
          );
        }),
      ),
    );
  }
}