import 'package:flutter/material.dart';
import 'component_delete_location/delete_confirmation_dialog.dart';

class LocationItemManage extends StatelessWidget {
  final String label;
  final String location;
  String? icon;
  String? customerName;
  final VoidCallback onEdit;
  final Function(bool) onDelete; // Cập nhật cho nhận tham số bool

  LocationItemManage({
    required this.label,
    required this.location,
    required this.icon,
    required this.customerName,
    required this.onEdit,
    required this.onDelete,
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
    // Kiểm tra nếu customerName là rỗng hay không
    String displayLabel = customerName?.isEmpty ?? true ? label : customerName!;
    String displayLocation = customerName?.isEmpty ?? true ? location : label;

    IconData iconData = iconMap[icon] ?? Icons.help;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(iconData, color: Colors.white),
      ),
      title: Text(displayLabel, style: TextStyle(color: Colors.white)),
      subtitle: Text(displayLocation, style: TextStyle(color: Colors.white54)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: onEdit, // Gọi onEdit khi nhấn vào edit
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteConfirmationDialog(
                      label: label,
                      onConfirm: (bool confirmed) {
                        onDelete(confirmed); // Gọi onDelete với giá trị true hoặc false
                      },
                      onCancel: () {
                        Navigator.of(context).pop(); // Đóng hộp thoại nếu người dùng chọn "Cancel"
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
