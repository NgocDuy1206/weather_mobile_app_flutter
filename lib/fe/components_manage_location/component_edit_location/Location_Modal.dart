import 'package:flutter/material.dart';
import 'Quick_LabelOptions.dart';
import 'Save_Edit.dart';
import 'labelInput.dart'; // Import SaveButton

// Custom class để truyền cả label và icon

// OK
class LabelData {
  final String label;
  final String icon;

  LabelData({required this.label, required this.icon});
}

class EditLocationModal extends StatefulWidget {
  final String location; // Thông tin vị trí
  final String label; // Thông tin nhãn
  String? customerName;
  String? icon;

  // Thêm hàm callback để truyền dữ liệu về cha
  final Function(LabelData updatedData)? onSave;

  EditLocationModal({
    required this.location,
    required this.label,
    required this.customerName,
    required this.icon,
    this.onSave,
  });



  @override
  _EditLocationModalState createState() => _EditLocationModalState();
}

class _EditLocationModalState extends State<EditLocationModal> {
  String updatedLabel = '';
  String selectedIcon = ''; // Biến lưu biểu tượng được chọn
  String? selectedLabel; // Biến lưu label đã chọn
  late TextEditingController _customerNameController;

  @override
  void initState() {
    super.initState();
    updatedLabel = widget.label; // Khởi tạo giá trị nhãn từ thông tin ban đầu
    selectedLabel = widget.label; // Cũng gán giá trị label ban đầu
    selectedIcon = widget.icon ?? '';


    _customerNameController = TextEditingController(text: widget.customerName);
  }

  @override
  void dispose() {
    _customerNameController.dispose(); // Giải phóng bộ nhớ
    super.dispose();
  }

  // Map ánh xạ từ chuỗi sang IconData
  static const Map<String, IconData> iconMap = {
    'Icons.home': Icons.home,
    'Icons.school': Icons.school,
    'Icons.local_hospital': Icons.local_hospital,
    'Icons.work': Icons.work,
    'Icons.fitness_center': Icons.fitness_center,
    'Icons.park': Icons.park,
    'Icons.directions_bus': Icons.directions_bus,
    'Icons.favorite': Icons.favorite,
    'Icons.location_on': Icons.location_on,
  };

  @override
  Widget build(BuildContext context) {
    IconData iconData = iconMap[widget.icon] ?? Icons.help;

    String displayLabel = widget.customerName?.isEmpty ?? true ? widget.label : widget.customerName!;
    String displayLocation = widget.customerName?.isEmpty ?? true ? widget.location : widget.label;

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
                  child: Icon(iconData, color: Colors.white), // Icon vị trí
                ),
                SizedBox(width: 16), // Khoảng cách giữa icon và thông tin
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Căn lề bên trái cho các dòng thông tin
                    children: [
                      // Dòng 1: Label
                      Text(
                        displayLabel, // Nhãn
                        style: TextStyle(color: Colors.white, fontSize: 16), // Style cho nhãn
                        overflow: TextOverflow.ellipsis, // Ngắt dòng nếu quá dài
                      ),
                      // Dòng 2: Vị trí chi tiết
                      Text(
                        displayLocation, // Vị trí chi tiết
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

          // Label Input
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // "Add a label" text above the input field
              Text(
                'Add a label',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 6), // Khoảng cách nhỏ giữa Text và TextField
              // Input field with the desired decoration
              TextField(
                controller: _customerNameController, // Quản lý giá trị
                decoration: InputDecoration(
                  hintText: 'e.g Home',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    widget.customerName = value; // Cập nhật trực tiếp giá trị
                  });
                },
              ),
              SizedBox(height: 3), // Giảm khoảng cách dưới TextField
            ],
          ),

          SizedBox(height: 16), // Khoảng cách giữa ô nhập và các phần tử khác

          // Quick label options
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Căn chỉnh các mục nhanh về bên trái
            children: [
              QuickLabelOption(
                label: 'Home',
                icon: 'Icons.home',
                isSelected: selectedIcon == 'Icons.home', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(
                label: 'School',
                icon: 'Icons.school',
                isSelected: selectedIcon == 'Icons.school', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(
                label: 'Hospital',  // Tên nhãn cho bệnh viện
                icon: 'Icons.local_hospital',  // Biểu tượng bệnh viện
                isSelected: selectedIcon == 'Icons.local_hospital', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8), // Khoảng cách giữa các hàng quick label options
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Căn chỉnh các mục nhanh về bên trái
            children: [
              QuickLabelOption(
                label: 'Work',
                icon: 'Icons.work',
                isSelected: selectedIcon == 'Icons.work', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(
                label: 'Gym',
                icon: 'Icons.fitness_center',
                isSelected: selectedIcon == 'Icons.fitness_center', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(
                label: 'Park',  // Tên nhãn cho công viên
                icon: 'Icons.park',  // Biểu tượng công viên
                isSelected: selectedIcon == 'Icons.park', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Căn chỉnh các mục nhanh về bên trái
            children: [

              QuickLabelOption(
                label: 'Bus',  // Tên nhãn cho xe buýt
                icon: 'Icons.directions_bus',  // Biểu tượng xe buýt
                isSelected: selectedIcon == 'Icons.directions_bus', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(
                label: 'Favorite',  // Tên nhãn cho điểm yêu thích
                icon: 'Icons.favorite',  // Biểu tượng trái tim
                isSelected: selectedIcon == 'Icons.favorite', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),
              SizedBox(width: 8), // Khoảng cách giữa các mục
              QuickLabelOption(
                label: 'Other',  // Tên nhãn cho vị trí khác
                icon: 'Icons.location_on',  // Biểu tượng vị trí
                isSelected: selectedIcon == 'Icons.location_on', // Kiểm tra nếu label này đã được chọn
                onTap: (label, icon) {  // Truyền callback hợp lệ vào đây
                  setState(() {
                    selectedLabel = label;
                    selectedIcon = icon;
                  });
                },
              ),


            ],
          ),


          SizedBox(height: 16), // Khoảng cách giữa quick label options và nút Save

          Spacer(), // Đẩy nút Save xuống dưới cùng

          // Nút Save
          SaveButton(
            onPressed: () {
              // Lấy giá trị label từ input
              updatedLabel = _customerNameController.text;

              // Nếu có callback onSave, truyền dữ liệu qua callback
              if (widget.onSave != null) {
                widget.onSave!(
                  LabelData(
                    label: updatedLabel, // Truyền giá trị từ input
                    icon: selectedIcon, // Truyền giá trị icon đã chọn
                  ),
                );
              } else {
                // Nếu không có callback, trả dữ liệu về qua Navigator.pop
                Navigator.pop(
                  context,
                  LabelData(
                    label: updatedLabel, // Truyền giá trị từ input
                    icon: selectedIcon, // Truyền giá trị icon đã chọn
                  ),
                );
              }
            },
          ),


        ],
      ),
    );
  }
}
