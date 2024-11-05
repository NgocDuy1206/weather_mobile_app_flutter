import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  double size;

  Loading({this.size = 30});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(height: size, child: CircularProgressIndicator()),
              Text('Loading data',style: TextStyle(fontSize: size/2),),
            ],
          ),
        ),
      ),
    );
  }
}