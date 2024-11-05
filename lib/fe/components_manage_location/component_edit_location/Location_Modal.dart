import 'package:flutter/material.dart';
import 'Quick_LabelOptions.dart';
import 'Save_Edit.dart';
import 'labelInput.dart'; // Import SaveButton

class EditLocationModal extends StatelessWidget {
  final String location; // Thông tin vị trí
  final String label; // Thông tin nhãn

  EditLocationModal({required this.location, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9, // Đặt chiều cao modal là 90%
      decoration: BoxDecoration(
        color: Color(0xFF141D26), // Màu nền của modal
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // Bo góc phía trên
      ),
      padding: EdgeInsets.only(
        top: 16, // Khoảng cách trên
        left: 20, // Khoảng cách bên trái
        right: 20, // Khoảng cách bên phải
        bottom: MediaQuery.of(context).viewInsets.bottom + 16, // Khoảng cách dưới
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Chiều cao tối thiểu của cột
        crossAxisAlignment: CrossAxisAlignment.start, // Căn lề bên trái cho các phần tử trong cột
        children: [
          // Thanh kéo nằm giữa trên đầu modal
          Center(
            child: Container(
              width: 40, // Chiều rộng của thanh kéo
              height: 5, // Chiều cao của thanh kéo
              decoration: BoxDecoration(
                color: Colors.grey, // Màu của thanh kéo
                borderRadius: BorderRadius.circular(10), // Bo góc cho thanh kéo
              ),
            ),
          ),
          SizedBox(height: 16), // Khoảng cách giữa thanh kéo và các phần tử khác

          // Hình chữ nhật bao quanh thông tin vị trí
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[800], // Màu nền của khung thông tin
              borderRadius: BorderRadius.circular(8), // Bo góc cho khung
            ),
            child: Row(
              children: [
                // Icon vị trí
                CircleAvatar(
                  backgroundColor: Colors.grey, // Màu nền của avatar
                  child: Icon(Icons.location_on, color: Colors.white), // Icon vị trí
                ),
                SizedBox(width: 16), // Khoảng cách giữa icon và thông tin
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Căn lề bên trái cho các dòng thông tin
                    children: [
                      // Dòng 1: Label
                      Text(
                        label, // Nhãn
                        style: TextStyle(color: Colors.white, fontSize: 16), // Style cho nhãn
                        overflow: TextOverflow.ellipsis, // Ngắt dòng nếu quá dài
                      ),
                      // Dòng 2: Vị trí chi tiết
                      Text(
                        location, // Vị trí chi tiết
                        style: TextStyle(color: Colors.white54, fontSize: 14), // Style cho vị trí
                        overflow: TextOverflow.ellipsis, // Ngắt dòng nếu quá dài
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16), // Khoảng cách giữa khung thông tin và ô nhập

          // Ô nhập nhãn
          LabelInput(),
          SizedBox(height: 16), // Khoảng cách giữa ô nhập và các phần tử khác

          // Quick label options
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Căn chỉnh các mục nhanh về bên trái
            children: [
              QuickLabelOption(label: 'Home', icon: Icons.home),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(label: 'School', icon: Icons.school),
            ],
          ),
          SizedBox(height: 8), // Khoảng cách giữa các hàng quick label options
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Căn chỉnh các mục nhanh về bên trái
            children: [
              QuickLabelOption(label: 'Work', icon: Icons.work),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(label: 'Gym', icon: Icons.fitness_center),
            ],
          ),

          SizedBox(height: 16), // Khoảng cách giữa quick label options và nút Save

          Spacer(), // Đẩy nút Save xuống dưới cùng

          // Nút Save
          SaveButton(
            onPressed: () {
              Navigator.pop(context); // Thực hiện hành động khi nhấn Save
            },
          ),
        ],
      ),
    );
  }
}
