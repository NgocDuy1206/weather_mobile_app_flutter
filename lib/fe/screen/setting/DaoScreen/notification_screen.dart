import 'package:flutter/material.dart';


class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isNotificationEnabled = true;
  bool showInfoMessage = false; // Trạng thái hiển thị thông báo
  TimeOfDay selectedTime = TimeOfDay(hour: 5, minute: 30);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily summary notification', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {   //thực hiện khi icon info được bấm
              setState(() {
                showInfoMessage = true; // Hiển thị thông báo khi nhấn vào icon info
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông báo hiển thị khi nhấn vào icon info
            Visibility(
              visible: showInfoMessage,
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Get a daily brief of your day at a time of your choosing',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 20.0),
                      onPressed: () {
                        setState(() {
                          showInfoMessage = false; // Ẩn thông báo khi nhấn vào icon close
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Use Current Location (Nam Từ Liêm)',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Switch(
                  value: isNotificationEnabled,
                  onChanged: (value) {
                    setState(() {
                      isNotificationEnabled = value;
                    });
                  },
                  activeColor: Colors.blue,
                ),
              ],
            ),
            SizedBox(height: 20.0),

            Row(
              children: [
                Icon(Icons.access_time, color: Colors.white),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Text(
                    '${selectedTime.format(context)}',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1.0),
          ],
        ),
      ),
    );
  }
}
