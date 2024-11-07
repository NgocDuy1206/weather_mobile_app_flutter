import 'package:flutter/material.dart';

import 'customize_units_screen.dart';


class LanguageAndUnitsScreen extends StatefulWidget {
  static const routeName = '/language-and-units';

  @override
  _LanguageAndUnitsScreenState createState() => _LanguageAndUnitsScreenState();
}

class _LanguageAndUnitsScreenState extends State<LanguageAndUnitsScreen> {
  String selectedLanguage = "English (US)";
  String selectedUnits = "Metric (°C)";

  // Danh sách các ngôn ngữ
  final List<Map<String, String>> languages = [
    {"name": "Arabic (AR)", "code": "ar"},
    {"name": "Armenian (HY)", "code": "hy"},
    {"name": "Azerbaijani (AZ)", "code": "az"},
    {"name": "Bengali (BN)", "code": "bn"},
    {"name": "Bulgarian (BG)", "code": "bg"},
    {"name": "Catalan (CA)", "code": "ca"},
    {"name": "Chinese (CN)", "code": "zh"},
    {"name": "Croatian (HR)", "code": "hr"},
    {"name": "Czech (CS)", "code": "cs"},
    {"name": "Danish (DA)", "code": "da"},
    {"name": "Dutch (NL)", "code": "nl"},
    {"name": "English (US)", "code": "en"},
    {"name": "Estonian (ET)", "code": "et"},
    {"name": "Farsi (FA)", "code": "fa"},
    {"name": "Filipino (TL)", "code": "tl"},
    {"name": "Finnish (FI)", "code": "fi"},
    {"name": "French (FR)", "code": "fr"},
    {"name": "Galician (GL)", "code": "gl"},
    {"name": "Georgian (KA)", "code": "ka"},
    {"name": "German (DE)", "code": "de"},
    {"name": "Greek (EL)", "code": "el"},
    {"name": "Hebrew (HE)", "code": "he"},
    {"name": "Hindi (HI)", "code": "hi"},
    {"name": "Hungarian (HU)", "code": "hu"},
    {"name": "Icelandic (IS)", "code": "is"},
    {"name": "Indonesian (ID)", "code": "id"},
    {"name": "Irish (GA)", "code": "ga"},
    {"name": "Italian (IT)", "code": "it"},
    {"name": "Japanese (JP)", "code": "ja"},
    {"name": "Kazakh (KK)", "code": "kk"},
    {"name": "Khmer (KM)", "code": "km"},
    {"name": "Korean (KR)", "code": "ko"},
    {"name": "Latvian (LV)", "code": "lv"},
    {"name": "Lithuanian (LT)", "code": "lt"},
    {"name": "Malay (MS)", "code": "ms"},
    {"name": "Malagasy (MG)", "code": "mg"},
    {"name": "Maltese (MT)", "code": "mt"},
    {"name": "Norwegian (NO)", "code": "no"},
    {"name": "Polish (PL)", "code": "pl"},
    {"name": "Portuguese (PT)", "code": "pt"},
    {"name": "Punjabi (PA)", "code": "pa"},
    {"name": "Romanian (RO)", "code": "ro"},
    {"name": "Russian (RU)", "code": "ru"},
    {"name": "Scottish Gaelic (GD)", "code": "gd"},
    {"name": "Serbian (SR)", "code": "sr"},
    {"name": "Sinhala (SI)", "code": "si"},
    {"name": "Slovak (SK)", "code": "sk"},
    {"name": "Somali (SO)", "code": "so"},
    {"name": "Spanish (ES)", "code": "es"},
    {"name": "Swahili (SW)", "code": "sw"},
    {"name": "Swedish (SV)", "code": "sv"},
    {"name": "Thai (TH)", "code": "th"},
    {"name": "Tigrinya (TI)", "code": "ti"},
    {"name": "Turkish (TR)", "code": "tr"},
    {"name": "Ukrainian (UK)", "code": "uk"},
    {"name": "Urdu (UR)", "code": "ur"},
    {"name": "Vietnamese (VI)", "code": "vi"},
    {"name": "Welsh (CY)", "code": "cy"},
    {"name": "Xhosa (XH)", "code": "xh"},
    {"name": "Zulu (ZU)", "code": "zu"},
  // Thêm nhiều ngôn ngữ khác nếu cần
  ];

  @override
  Widget build(BuildContext context) {
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
              title: Text('Language', style: TextStyle(color: Colors.white)),
              subtitle: Text(selectedLanguage, style: TextStyle(color: Colors.grey)),
              onTap: () {
                _showLanguageSelection();
              },
            ),
            Divider(color: Colors.grey),
            SizedBox(height: 10),
            Text('Units', style: TextStyle(color: Colors.grey)),
            RadioListTile(
              title: Text('Imperial (°F)', style: TextStyle(color: Colors.white)),
              subtitle: Text('Fahrenheit, Miles, In (")', style: TextStyle(color: Colors.grey)),
              value: 'Imperial (°F)',
              groupValue: selectedUnits,
              onChanged: (value) {
                setState(() {
                  selectedUnits = value.toString();
                });
              },
            ),
            Divider(color: Colors.grey),
            RadioListTile(
              title: Text('Metric (°C)', style: TextStyle(color: Colors.white)),
              subtitle: Text('Celsius, Kilometres, kPa', style: TextStyle(color: Colors.grey)),
              value: 'Metric (°C)',
              groupValue: selectedUnits,
              onChanged: (value) {
                setState(() {
                  selectedUnits = value.toString();
                });
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

  void _showLanguageSelection() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: SingleChildScrollView(
            child: Column(
              children: languages.map((language) {
                return ListTile(
                  title: Text(language["name"]!),
                  onTap: () {
                    setState(() {
                      selectedLanguage = language["name"]!;
                    });
                    Navigator.of(context).pop();
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
