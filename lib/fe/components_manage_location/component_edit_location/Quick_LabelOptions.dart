import 'package:flutter/material.dart';

class QuickLabelOption extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected; // Xác định xem cái này có được chọn hay không
  final Function(String label, String icon) onTap; // Callback khi nhấn vào label

  QuickLabelOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

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
    // Lấy IconData từ chuỗi icon, hoặc trả về Icons.help nếu không tìm thấy
    IconData iconData = iconMap[icon] ?? Icons.help;

    return GestureDetector(
      onTap: () => onTap(label, icon), // Gọi callback khi người dùng chọn
      child: Chip(
        label: Row(
          children: [
            Icon(
              iconData, // Sử dụng IconData đã chuyển đổi
              color: isSelected ? Colors.blue : Colors.white, // Màu sẽ xanh nếu được chọn
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF141D26),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
