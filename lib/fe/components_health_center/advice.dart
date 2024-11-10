import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

class Advice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, ),
      padding: EdgeInsets.all(20),
      height: 350,
      width: InforDevice.WIDTH,
      decoration: BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                'ADVICE FOR HEALTH',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              )),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/icon/home.png',
                      scale: 1.15,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'General',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              'There is a moderate amount of pollution, but there is no danger to health.')
                        ],
                      ))
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/icon/heart_pulse.png',
                      scale: 2.0,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sensitive groups',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              'It is recommended to limit outdoor acitvity for especially sensitive individuals.')
                        ],
                      ))
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/icon/run.png',
                      scale: 1.0,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activity',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          Text(
                              'You are still good for outdoor exercise but monitor for changes.')
                        ],
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
