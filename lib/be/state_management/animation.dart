import 'package:flutter/cupertino.dart';

class AnimatedProvider with ChangeNotifier {
  late AnimationController controller;
  late Animation<int> animation;
  bool
  isStopped = false;

  String text1 = '';
  int currentLength = 0;

  String get animatedText {
    if (currentLength < 0 || currentLength > text1.length) {
      return '';
    }
    return text1.substring(0, currentLength);
  }
  void initAnimation(TickerProvider vsync, String text) {
    text1 = text;
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: vsync,
    );

    animation = IntTween(begin: 1, end: text1.length).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInBack,
      ),
    )..addListener(() {
      currentLength = animation.value;
      notifyListeners();
    });

    startAnimationCycle();
  }
  Future<void> startAnimationCycle() async {
    while (!isStopped) {
      await controller.forward(); // Chạy animation từ đầu đến cuối
      await Future.delayed(Duration(seconds: 1)); // Tạm dừng 1 giây
      controller.reset(); // Đặt lại animation về trạng thái ban đầu
    }
  }

  void stopAnimation() {
    isStopped = true;
    controller.stop();
    notifyListeners();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
