import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';

import '../../../../configs/utils.dart';
import '../../display/main_screen.dart';
import 'customize_units_screen.dart';


class LanguageAndUnitsScreen extends StatefulWidget {
  static const routeName = '/language-and-units';

  @override
  _LanguageAndUnitsScreenState createState() => _LanguageAndUnitsScreenState();
}

class _LanguageAndUnitsScreenState extends State<LanguageAndUnitsScreen> {

  String selectedUnits = "Metric (°C)";

  // Danh sách các ngôn ngữ
  final List<String> languages = [
    'English (EN)',
    'Việt Nam (VN)',
  ];
  @override
  Widget build(BuildContext context) {
    var set =  Provider.of<SettingManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Language and Units', style: TextStyle(color: Colors.white)),
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
              title: Text(Utils.getText('language'), style: TextStyle(color: Colors.white)),
              subtitle: Text(
                  SettingManager.language == 'english'? languages[0]: languages[1],
                  style: TextStyle(color: Colors.grey)),
              onTap: () {
                _showLanguageSelection(set);
              },
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            Text('Units', style: TextStyle(color: Colors.grey)),
            RadioListTile(
              title: Text('Imperial (°F)', style: TextStyle(color: Colors.white)),
              subtitle: Text('Fahrenheit, Miles, In (")', style: TextStyle(color: Colors.grey)),
              value: 'F',
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('F');
              },
            ),
            Divider(color: Colors.grey),
            RadioListTile(
              title: Text('Metric (°C)', style: TextStyle(color: Colors.white)),
              subtitle: Text('Celsius, Kilometres, kPa', style: TextStyle(color: Colors.grey)),
              value: 'C',
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('C');
              },
            ),
            Divider(color: Colors.grey),
            ListTile(
              title: Text('Customize', style: TextStyle(color: Colors.white)),
              subtitle: Text('Off', style: TextStyle(color: Colors.grey)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomizeUnitsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelection(
      SettingManager provider
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: SingleChildScrollView(
            child: Column(
              children: languages.map((language) {
                return ListTile(
                  title: Text(language),
                  onTap: () {
                    if (language == 'English (EN)') {
                      if (SettingManager.language != 'english') {
                        provider.updateLanguage('english');

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                              (route) => false,
                        );
                      }

                    } else if (language == 'Việt Nam (VN)') {
                      if (SettingManager.language != 'vietnam'){
                        provider.updateLanguage('vietnam');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                              (route) => false,
                        );
                      }

                    }

                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
