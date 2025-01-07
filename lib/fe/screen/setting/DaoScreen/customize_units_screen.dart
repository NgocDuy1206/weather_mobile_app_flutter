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
    String theme = set.theme;
    Color textColor = theme == "dark" ? Colors.white : Colors.black;
    Color subtitleColor = theme == "dark" ? Colors.grey : Colors.black54;
    Color backgroundColor = theme == "dark" ? Colors.black87 : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text('Customize Units', style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Container(
        color: backgroundColor,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Temperature", style: TextStyle(color: textColor)),
              subtitle: Text("°C or °F", style: TextStyle(color: subtitleColor)),
            ),
            RadioListTile(
              title: Text("°C", style: TextStyle(color: textColor)),
              value: "C",
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('C');
              },
            ),
            RadioListTile(
              title: Text("°F", style: TextStyle(color: textColor)),
              value: "F",
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('F');
              },
            ),
            Divider(color: subtitleColor),
            ListTile(
              title: Text("Wind Units", style: TextStyle(color: textColor)),
              subtitle: Text("Select your preferred wind speed unit", style: TextStyle(color: subtitleColor)),
            ),
            RadioListTile(
              title: Text("mph", style: TextStyle(color: textColor)),
              value: "mph",
              groupValue: set.spdUnit,
              onChanged: (value) {
                set.updateSpdUnit('mph');
              },
            ),
            RadioListTile(
              title: Text("km/h", style: TextStyle(color: textColor)),
              value: "km/h",
              groupValue: set.spdUnit,
              onChanged: (value) {
                set.updateSpdUnit('km/h');
              },
            ),
            RadioListTile(
              title: Text("m/s", style: TextStyle(color: textColor)),
              value: "m/s",
              groupValue: set.spdUnit,
              onChanged: (value) {
                set.updateSpdUnit('m/s');
              },
            ),
            Divider(color: subtitleColor),
            ListTile(
              title: Text("Distance", style: TextStyle(color: textColor)),
              subtitle: Text("Select your preferred distance unit", style: TextStyle(color: subtitleColor)),
            ),
            RadioListTile(
              title: Text("Miles (mi)", style: TextStyle(color: textColor)),
              value: "m",
              groupValue: set.distanceUnit,
              onChanged: (value) {
                set.updateDistanceUnit('m');
              },
            ),
            RadioListTile(
              title: Text("Kilometers (km)", style: TextStyle(color: textColor)),
              value: "km",
              groupValue: set.distanceUnit,
              onChanged: (value) {
                set.updateDistanceUnit('km');
              },
            ),
            Divider(color: subtitleColor),
            ListTile(
              title: Text("Pressure Units", style: TextStyle(color: textColor)),
              subtitle: Text("Select your preferred pressure unit", style: TextStyle(color: subtitleColor)),
              onTap: () => _selectPressureUnit(context), // Gọi hàm chọn đơn vị áp suất
            ),
            Text("Current Selection: ${set.pressUnit}", style: TextStyle(color: textColor)), // Hiển thị đơn vị đã chọn
          ],
        ),
      ),
    );
  }
}
