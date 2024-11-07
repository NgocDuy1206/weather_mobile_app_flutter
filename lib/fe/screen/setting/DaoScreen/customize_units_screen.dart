import 'package:flutter/material.dart';

class CustomizeUnitsScreen extends StatefulWidget {
  @override
  _CustomizeUnitsScreenState createState() => _CustomizeUnitsScreenState();
}

class _CustomizeUnitsScreenState extends State<CustomizeUnitsScreen> {
  String selectedTemperatureUnit = "°C";
  String selectedWindUnit = "km/h";
  String selectedDistanceUnit = "km";
  String selectedPressureUnit = "kPa"; // Đổi mặc định thành kPa

  void _selectPressureUnit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Pressure Unit"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('Inches of mercury (")'),
                value: '"',
                groupValue: selectedPressureUnit,
                onChanged: (value) {
                  setState(() {
                    selectedPressureUnit = value.toString();
                  });
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              RadioListTile(
                title: Text('Millibars (mb)'),
                value: 'mb',
                groupValue: selectedPressureUnit,
                onChanged: (value) {
                  setState(() {
                    selectedPressureUnit = value.toString();
                  });
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              RadioListTile(
                title: Text('Millimeters of mercury (mm)'),
                value: 'mm',
                groupValue: selectedPressureUnit,
                onChanged: (value) {
                  setState(() {
                    selectedPressureUnit = value.toString();
                  });
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              RadioListTile(
                title: Text('Atmosphere (atm)'),
                value: 'atm',
                groupValue: selectedPressureUnit,
                onChanged: (value) {
                  setState(() {
                    selectedPressureUnit = value.toString();
                  });
                  Navigator.of(context).pop(); // Đóng dialog
                },
              ),
              RadioListTile(
                title: Text('Kilopascal (kPa)'),
                value: 'kPa',
                groupValue: selectedPressureUnit,
                onChanged: (value) {
                  setState(() {
                    selectedPressureUnit = value.toString();
                  });
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
              value: "°C",
              groupValue: selectedTemperatureUnit,
              onChanged: (value) {
                setState(() {
                  selectedTemperatureUnit = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("°F", style: TextStyle(color: Colors.white)),
              value: "°F",
              groupValue: selectedTemperatureUnit,
              onChanged: (value) {
                setState(() {
                  selectedTemperatureUnit = value.toString();
                });
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
              groupValue: selectedWindUnit,
              onChanged: (value) {
                setState(() {
                  selectedWindUnit = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("km/h", style: TextStyle(color: Colors.white)),
              value: "km/h",
              groupValue: selectedWindUnit,
              onChanged: (value) {
                setState(() {
                  selectedWindUnit = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("m/s", style: TextStyle(color: Colors.white)),
              value: "m/s",
              groupValue: selectedWindUnit,
              onChanged: (value) {
                setState(() {
                  selectedWindUnit = value.toString();
                });
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Distance", style: TextStyle(color: Colors.white)),
              subtitle: Text("Select your preferred distance unit", style: TextStyle(color: Colors.grey)),
            ),
            RadioListTile(
              title: Text("Miles (mi)", style: TextStyle(color: Colors.white)),
              value: "mi",
              groupValue: selectedDistanceUnit,
              onChanged: (value) {
                setState(() {
                  selectedDistanceUnit = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text("Kilometers (km)", style: TextStyle(color: Colors.white)),
              value: "km",
              groupValue: selectedDistanceUnit,
              onChanged: (value) {
                setState(() {
                  selectedDistanceUnit = value.toString();
                });
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text("Pressure Units", style: TextStyle(color: Colors.white)),
              subtitle: Text("Select your preferred pressure unit", style: TextStyle(color: Colors.grey)),
              onTap: () => _selectPressureUnit(context), // Gọi hàm chọn đơn vị áp suất
            ),
            Text("Current Selection: $selectedPressureUnit", style: TextStyle(color: Colors.white)), // Hiển thị đơn vị đã chọn
          ],
        ),
      ),
    );
  }
}
