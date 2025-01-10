import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';

import '../../../../be/data/weather_by_day.dart';
import '../../../../configs/constants.dart';
import '../../../../configs/utils.dart';

class SunMoon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByDay day = provider.weatherLocation!.dayList[0];

    return Scaffold(
      appBar: AppBar(
        title: Text('Sun & Moon'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: MyColors.background_table,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            AnimatedWidget(kind: 'sun',),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Sunrise'),
                Text('Sunset'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(Utils.getHour12H(day.sunrise)),
                Text(Utils.getHour12H(day.sunset)),
              ],
            ),
            AnimatedWidget(kind: 'moon',),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Moonrise'),
                Text('Moonset'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(Utils.getHour12H(day.moonrise)),
                Text(Utils.getHour12H(day.moonset)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 380,
                child: ListCard()
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedWidget extends StatefulWidget {
  String kind;
  AnimatedWidget({super.key, this.kind = 'sun'});

  @override
  _AnimatedWidgetState createState() => _AnimatedWidgetState(kind: kind);
}

class _AnimatedWidgetState extends State<AnimatedWidget>
    with SingleTickerProviderStateMixin {
  _AnimatedWidgetState({this.kind = 'sun'});
  String kind;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Thời gian cho animation
    );
    _animation = Tween<double>(begin: 0, end: 0.5).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // Bắt đầu animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 150), // Kích thước canvas
      painter: (kind == 'sun')?AnimatedSunPainter(_animation.value): MoonPainter(_animation.value),
    );
  }
}

class AnimatedSunPainter extends CustomPainter {
  final double progress; // Giá trị animation từ 0 -> 1

  AnimatedSunPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    // Vẽ đường cong (quỹ đạo mặt trời)
    final path = Path()
      ..moveTo(0, size.height) // Điểm bắt đầu
      ..quadraticBezierTo(
        size.width / 2, -40, // Đỉnh đường cong
        size.width, size.height, // Điểm kết thúc
      );
    canvas.drawPath(path, Paint()..color = Colors.yellow.withOpacity(0.3));

    // Tính toán vị trí mặt trời theo progress
    final double x = size.width * progress;
    final double y = size.height - (size.height * progress * (1 - progress) * 4);

    // Vẽ mặt trời (hình tròn)
    canvas.drawCircle(Offset(x, y), 20, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Luôn vẽ lại khi animation thay đổi
  }
}

class MoonPainter extends CustomPainter {
  final double progress;

  MoonPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final double x = size.width / 2;
    final double y = size.height / 2;
    final double moonRadius = 50;

    // Tạo lớp đệm (layer) để áp dụng BlendMode
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());

    // Vẽ hình tròn lớn màu vàng (Mặt trăng chính)
    final moonPaint = Paint()
      ..color = Color(0x7EB0A8A8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x, y), moonRadius, moonPaint);

    // Vẽ hình tròn nhỏ màu đen (phần che để tạo lưỡi liềm)
    final shadowPaint = Paint()
      ..color = Color(0xFF2D2A2A)
      ..blendMode = BlendMode.srcIn; // Xóa phần giao nhau
    final double shadowOffset = progress * 40; // Độ lệch của bóng tối
    canvas.drawCircle(Offset(x - shadowOffset, y), moonRadius, shadowPaint);

    // Khôi phục canvas
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
class ListCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return ExpandCard(index: index,);
        }
    );
  }
}

class ExpandCard extends StatelessWidget {
  dynamic index;
  ExpandCard({this.index = 0});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByDay day = provider.weatherLocation!.dayList[index];
    DateTime time = day.time;
    String dayOfWeek = Utils.getWeekDay(time) + 'day, ';
    String month = Utils.getMonth2(time.month) + ' ' + time.day.toString();
    return Center(
      child: Card(
        child: ExpansionTile(
          title: Row(
            children: [
              Icon(Icons.cloud, color: Colors.blue), // Icon bên trong tiêu đề
              SizedBox(width: 8), // Khoảng cách giữa icon và text
              Text(
                dayOfWeek + month,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: [
             Container(
               padding: EdgeInsets.only(left: 20, right: 20),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Sunrise: ' + Utils.getHour12H(day.sunrise),
                       ),
                       Text(
                         'Sunset: ' + Utils.getHour12H(day.sunset),
                       )
                     ],
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Moonrise: ' + Utils.getHour12H(day.moonrise),
                       ),
                       Text(
                         'Moonset: ' + Utils.getHour12H(day.moonset),
                       )
                     ],
                   ),
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }
}