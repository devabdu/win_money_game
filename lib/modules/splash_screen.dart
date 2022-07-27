import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:win_money_game/modules/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Lottie.network('https://assets6.lottiefiles.com/packages/lf20_27klftwl.json'),
      backgroundColor: Colors.deepPurple,
      //animationDuration: Duration(seconds: 1),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 400,
      duration: 6000,
      pageTransitionType: PageTransitionType.topToBottom,
      //disableNavigation: true,
      nextScreen: const LoginScreen(),
    );
  }
}
