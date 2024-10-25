import 'package:flutter/cupertino.dart';

class Degrees extends StatelessWidget {
  int? degree = 0;
  double? size = 10;
  Degrees({required this.degree, required this.size});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(degree.toString(),
          style: TextStyle(
            fontSize: size,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5,left: 3),
          child: ImageIcon(AssetImage('assets/icon/degrees.png'),
          size: (size! / 5),),
        ),
      ],
    );
  }
}