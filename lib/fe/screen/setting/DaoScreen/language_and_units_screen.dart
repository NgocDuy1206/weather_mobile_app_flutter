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
    var set = Provider.of<SettingManager>(context);
    String theme = set.theme;
    Color textColor = theme == "dark" ? Colors.white : Colors.black;
    Color subtitleColor = theme == "dark" ? Colors.grey : Colors.black54;
    Color backgroundColor = theme == "dark" ? Colors.black87 : Colors.white;
    Color dividerColor = theme == "dark" ? Colors.white38 : Colors.black26;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            Utils.getText('language_unit'), style: TextStyle(color: textColor)),
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
              title: Text(Utils.getText('language'),
                  style: TextStyle(color: textColor)),
              subtitle: Text(
                SettingManager.language == 'english'
                    ? languages[0]
                    : languages[1],
                style: TextStyle(color: subtitleColor),
              ),
              onTap: () {
                _showLanguageSelection(set);
              },
            ),
            Divider(color: dividerColor),
            SizedBox(height: 10),
            Text(Utils.getText('Units'), style: TextStyle(color: textColor)),
            RadioListTile(
              title: Text('Imperial (°F)', style: TextStyle(color: textColor)),
              subtitle: Text('Fahrenheit, Miles, In (")',
                  style: TextStyle(color: subtitleColor)),
              value: 'F',
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('F');
              },
            ),
            Divider(color: dividerColor),
            RadioListTile(
              title: Text('Metric (°C)', style: TextStyle(color: textColor)),
              subtitle: Text('Celsius, Kilometres, kPa',
                  style: TextStyle(color: subtitleColor)),
              value: 'C',
              groupValue: set.tempUnit,
              onChanged: (value) {
                set.updateTempUnit('C');
              },
            ),
            Divider(color: dividerColor),
            ListTile(
              title: Text(Utils.getText('Customize'),
                  style: TextStyle(color: textColor)),
              subtitle: Text(
                  Utils.getText('Off'), style: TextStyle(color: subtitleColor)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomizeUnitsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSelection(SettingManager provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Lấy theme hiện tại
        String theme = provider.theme;
        Color textColor = theme == "dark" ? Colors.white : Colors.black;

        return AlertDialog(
          title: Text("Select Language", style: TextStyle(color: textColor)),
          // Thay đổi màu chữ của tiêu đề
          content: SingleChildScrollView(
            child: Column(
              children: languages.map((language) {
                return ListTile(
                  title: Text(language, style: TextStyle(color: textColor)),
                  // Thay đổi màu chữ của từng ngôn ngữ
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
                      if (SettingManager.language != 'vietnam') {
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