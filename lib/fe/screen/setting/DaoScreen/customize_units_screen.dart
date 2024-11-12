import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../be/state_management/setting_manager.dart';

class CustomizeUnitsScreen extends StatefulWidget {
  @override
  _CustomizeUnitsScreenState createState() => _CustomizeUnitsScreenState();
}

class _CustomizeUnitsScreenState extends State<CustomizeUnitsScreen> {
  // Đổi mặc định thành kPa

  void _selectPressureUnit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var set = Provider.of<SettingManager>(context);
        return AlertDialog(
          title: Text("Select Pressure Unit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('Atmosphere (atm)'),
                value: 'atm',
                groupValue: set.pressUnit,
                onChanged: (value) {
                  set.updatePressUnit('atm');
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              RadioListTile(
                title: Text('Kilopascal (kPa)'),
                value: 'kPa',
                groupValue: set.pressUnit,
                onChanged: (value) {
                  set.updatePressUnit('kPa');
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var set = Provider.of<SettingManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize Units', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Temperature", style: TextStyle(color: Colors.white)),
              subtitle: Text("°C or °F", style: TextStyle(color: Colors.grey)),
            ),
            RadioListTile(
              title: Text("°C", style: TextStyle(color: Colors.white)),
              value: "C",
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('C');
              },
            ),
            RadioListTile(
              title: Text("°F", style: TextStyle(color: Colors.white)),
              value: "F",
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('F');
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Wind Units", style: TextStyle(color: Colors.white)),
              subtitle: Text("Select your preferred wind speed unit", style: TextStyle(color: Colors.grey)),
            ),
            RadioListTile(
              title: Text("mph", style: TextStyle(color: Colors.white)),
              value: "mph",
              groupValue: set.spdUnit,
              onChanged: (value) {
                set.updateSpdUnit('mph');

              },
            ),
            RadioListTile(
              title: Text("km/h", style: TextStyle(color: Colors.white)),
              value: "km/h",
              groupValue: set.spdUnit,
              onChanged: (value) {
                set.updateSpdUnit('km/h');
              },
            ),
            RadioListTile(
              title: Text("m/s", style: TextStyle(color: Colors.white)),
              value: "m/s",
              groupValue: set.spdUnit,
              onChanged: (value) {
                set.updateSpdUnit('m/s');
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Distance", style: TextStyle(color: Colors.white)),
              subtitle: Text("Select your preferred distance unit", style: TextStyle(color: Colors.grey)),
            ),
            RadioListTile(
              title: Text("Miles (mi)", style: TextStyle(color: Colors.white)),
              value: "m",
              groupValue: set.distanceUnit,
              onChanged: (value) {
                set.updateDistanceUnit('m');
              },
            ),
            RadioListTile(
              title: Text("Kilometers (km)", style: TextStyle(color: Colors.white)),
              value: "km",
              groupValue: set.distanceUnit,
              onChanged: (value) {
                set.updateDistanceUnit('km');
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Pressure Units", style: TextStyle(color: Colors.white)),
              subtitle: Text("Select your preferred pressure unit", style: TextStyle(color: Colors.grey)),
              onTap: () => _selectPressureUnit(context), // Gọi hàm chọn đơn vị áp suất
            ),
            Text("Current Selection: ${set.pressUnit}", style: TextStyle(color: Colors.white)), // Hiển thị đơn vị đã chọn
          ],
        ),
      ),
    );
  }
}
