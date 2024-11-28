import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

import '../../be/state_management/animation.dart';

class Loading extends StatelessWidget {
  double size;

  Loading({this.size = 50});

  @override
  Widget build(BuildContext context) {
    InforDevice.WIDTH = MediaQuery.of(context).size.width;
    InforDevice.HEIGHT = MediaQuery.of(context).size.height;
    dynamic x = InforDevice.WIDTH;
    dynamic y = InforDevice.HEIGHT;
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/image/start_screen.jpg',
          fit: BoxFit.cover,  
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
            width: 480,
            height: 600,
            child: SizedBox(
                width: 600,

                child: AnimationStart()
            ),
        ),
        Positioned(
          width: InforDevice.WIDTH,
          height: InforDevice.HEIGHT * 2 - 200 ,
          child: Container(
            height: size,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: size, child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                )),
                SizedBox(width: 15,),
                Text(
                  'Loading data',
                  style: TextStyle(fontSize: size / 2),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class AnimationStart extends StatefulWidget{

  @override
  State<AnimationStart> createState() => _AnimationStartState();
}

class _AnimationStartState extends State<AnimationStart> with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    // Khởi tạo animation controller thông qua provider
    Provider.of<AnimatedProvider>(context, listen: false).initAnimation(this,'1 WEATHER  APP');
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Consumer<AnimatedProvider>(
          builder: (context, animationProvider, child) {
            return Text(
              animationProvider.animatedText,
              style: GoogleFonts.lobster(
                fontSize: 40,
                color: Colors.white,
              ),
            );
          },)
        );
  }

  @override
  void dispose() {
    super.dispose();
    // Đảm bảo giải phóng tài nguyên
    Provider.of<AnimatedProvider>(context, listen: false).dispose();
  }
}
