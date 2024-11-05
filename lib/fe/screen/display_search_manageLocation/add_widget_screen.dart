import 'package:flutter/material.dart';
import '../../components_add_widget/widget_item.dart';

// Màn hình cho chức năng add widget
class AddWidgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141D26), // Thay đổi màu nền
      appBar: AppBar(
        backgroundColor: Color(0xFF141D26), // Giữ màu nền app bar
        titleSpacing: 0,
        title: Text(
          'Chọn tiện ích',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2),
            Divider(
              color: Colors.white,
              thickness: 0.3,
            ),
            SizedBox(height: 16),

            // Sử dụng WidgetItem với các tiêu đề tương ứng và padding
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 100,
                title: 'Đồng hồ nhỏ 4x1',

                imagePath: 'assets/image/dong_ho_nho_4x1.jpg', // Đường dẫn đến hình ảnh
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 150,
                title: 'Dự báo và Đồng hồ 5x2',
                imagePath: 'assets/image/du_bao_va_dh_5x2.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
              ),
            ),
            SizedBox(height: 20),

            // Thêm các khung và tiêu đề mới
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 100,
                title: 'Đồng hồ 5x1',
                imagePath: 'assets/image/dong_ho_5x1.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 210,
                title: 'Đã kiểm tra 5x2',
                imagePath: 'assets/image/da_kiem_tra_5x2.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 200, // Chiều cao lớn hơn cho khung lớn
                title: 'Đồng hồ 5x2 (Lớn)',
                imagePath: 'assets/image/dong_ho_5x2_lon.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
              ),
            ),
            SizedBox(height: 20),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0),
            //   child: WidgetItem(
            //     height: 100,
            //     title: '4x1 Compact',
            //
            //     imagePath: 'assets/image/new_com5.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
            //   ),
            // ),
            // SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 100,
                title: '2x1',
                width: 200,
                imagePath: 'assets/image/2x1.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: WidgetItem(
                height: 140,
                title: '1x1',
                width: 140,
                imagePath: 'assets/image/1x1.jpg', // Cập nhật đường dẫn hình ảnh cho hình ảnh này
              ),
            ),
          ],
        ),
      ),
    );
  }
}
