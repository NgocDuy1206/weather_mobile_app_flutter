import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String imagePath;
  final double actualHeight;
  final double actualWidth;

  ConfirmationDialog({
    required this.onConfirm,
    required this.onCancel,
    required this.imagePath,
    required this.actualHeight,
    required this.actualWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF424242),
      title: Center(
        child: Text(
          'Thêm vào màn hình chính',
          style: TextStyle(color: Colors.white),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              'Chạm và giữ tiện ích để di chuyển tiện ích đó xung quanh màn hình chính.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 5), // Giảm khoảng cách giữa text và hình ảnh
          Container(
            height: actualHeight * 0.2,
            width: actualWidth * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5), // Giảm khoảng cách giữa hình ảnh và text
          Text(
            'Weather',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            '4x1',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5), // Giảm khoảng cách giữa text và action
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Thêm khoảng cách bên trái và bên phải
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại khi nhấn Hủy
                  onCancel();
                },
                child: Text(
                  'Hủy',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              Container(
                width: 1,
                height: 20,
                color: Colors.white,
              ),
              TextButton(
                onPressed: onConfirm,
                child: Text(
                  'Thêm',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
