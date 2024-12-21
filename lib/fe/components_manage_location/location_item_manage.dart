import 'package:flutter/material.dart';
import 'component_delete_location/delete_confirmation_dialog.dart';

class LocationItemManage extends StatelessWidget {
  final String label;
  final String location;
  final VoidCallback onEdit;
  final Function(bool) onDelete; // Cập nhật cho nhận tham số bool

  LocationItemManage({
    required this.label,
    required this.location,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Icon(Icons.location_on, color: Colors.white),
      ),
      title: Text(label, style: TextStyle(color: Colors.white)),
      subtitle: Text(location, style: TextStyle(color: Colors.white54)),
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
