
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';

class ArcProgressIndicator extends StatelessWidget {
  final double progress; // Giá trị progress từ 0.0 đến 1.0
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final Color backgroundColor;

  ArcProgressIndicator({
    required this.progress,
    this.strokeWidth = 8.0,
    this.startAngle = -3.14 / 2, // bắt đầu từ đỉnh
    this.sweepAngle = 3.14, // 180 độ (nửa vòng tròn)
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: ArcPainter(
        progress: progress,
        strokeWidth: strokeWidth,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        color: color,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final double startAngle;
  final double sweepAngle;
  final Color color;
  final Color backgroundColor;

  ArcPainter({
    required this.progress,
    required this.strokeWidth,
    required this.startAngle,
    required this.sweepAngle,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Paint foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Xác định hình chữ nhật bao quanh hình cung
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Vẽ hình cung màu xám nền (phần không sweep)
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Vẽ hình cung có màu chính cho progress
    canvas.drawArc(
      rect,
      startAngle,
      sweepAngle * progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawAqiIndex extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    dynamic airquality = provider.weatherLocation!.airQualityList[0].airQuality;
    return Container(
      height: 100,
      width: 100,
      child: Stack(alignment: Alignment.center, children: [
        ArcProgressIndicator(
          progress: airquality/500,
          // 70% progress
          strokeWidth: 15,
          startAngle: -3.14 - 3.14 / 4,
          // Góc bắt đầu
          sweepAngle: 3.14 + 3.14 / 2,
          // Góc của hình cung
          color: Utils.getColorAQI(airquality),
          backgroundColor: Colors.black.withOpacity(0.1),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AQI',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.black.withOpacity(0.5))),
            Text(
                airquality.toString(),
                style:
                TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 35)
            ),
          ],
        )
      ]),
    );
  }
}