import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

import '../../be/state_management/Manager.dart';
import '../../be/state_management/animation.dart';
import '../screen/display/main_screen.dart';

class Loading extends StatefulWidget {

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool clickStart = false;
  @override
  Widget build(BuildContext context) {
    InforDevice.WIDTH = MediaQuery.of(context).size.width;
    InforDevice.HEIGHT = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Stack(children: [
        Image.asset(
          'assets/image/start_screen.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
            top: 300,
            left: 100,
            width: 300,
            height: 70,
            child: AnimationStart(),
        ),
        Positioned(
          left: InforDevice.WIDTH / 2 - 50,
          top: InforDevice.HEIGHT - 150 ,
          child: ElevatedButton(
              onPressed: () async {
                  setState(() {
                    clickStart = true;
                  });
                  if (Provider.of<WeatherManager>(context, listen: false).loading == false)
                  {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainScreen())
                    );
                  }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.BLUE,
              ),
              child: clickStart == false? Text(
                'START',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.WHITE,
                )
              ) : Padding(
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  color: MyColors.RED,
                
                ),
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

class _AnimationStartState extends State<AnimationStart> with TickerProviderStateMixin{

  late AnimatedProvider animation;
  @override
  void initState() {
    super.initState();
    // Khởi tạo animation controller thông qua provider
    animation = Provider.of<AnimatedProvider>(context, listen: false);
    animation.initAnimation(this,'1 WEATHER  APP');

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
    animation.dispose();
    super.dispose();
    // Đảm bảo giải phóng tài nguyên
  }
}
