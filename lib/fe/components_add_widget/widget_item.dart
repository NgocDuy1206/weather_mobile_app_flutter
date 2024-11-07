import 'package:flutter/material.dart';
import 'confirmation_dialog.dart';

//Item tiện ích add_widget truyền vào từ màn hình add_widget
class WidgetItem extends StatelessWidget {
  final double height;
  final String title;
  final String imagePath;
  final double? width;
  final double? widthRatio;
  final double? heightRatio;

  WidgetItem({
    required this.height,
    required this.title,
    required this.imagePath,
    this.width,
    this.widthRatio,
    this.heightRatio,
  });

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          onConfirm: () {
            print('Tiện ích đã được thêm vào khung!');
          },
          onCancel: () {
            print('Người dùng đã hủy việc thêm tiện ích.');
          },
          imagePath: imagePath,
          actualHeight: height, // Truyền chiều cao thực tế của ảnh
          actualWidth: width ?? MediaQuery.of(context).size.width, // Truyền chiều rộng thực tế của ảnh
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showConfirmationDialog(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height * (heightRatio ?? 1.0),
            width: width ?? (MediaQuery.of(context).size.width * (widthRatio ?? 1.0)),
            decoration: BoxDecoration(
              color: Color(0xFF212A31),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
