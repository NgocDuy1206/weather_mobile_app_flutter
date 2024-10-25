import 'package:flutter/cupertino.dart';

class Percentage extends StatelessWidget {
  double? percent = 0.0;
  double? size = 5;
  Percentage({required this.percent, required this.size});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          percent.toString(),
          style: TextStyle(
            fontSize: (size!),
          ),
        ),
        ImageIcon(AssetImage('assets/icon/percent.png'), size: (size! * 1.5),)
      ],
    );
  }
}