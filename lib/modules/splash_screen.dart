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
    //   Column(
    //   children: [
    //     Image.asset(
    //       'assets/images/logo_transparent.png',
    //       width: 400,
    //       height: 400,
    //     ),
    //     // Icon(
    //     //   Icons.widgets_outlined,
    //     //   size: 100,
    //     //   color: Colors.white,
    //     // ),
    //     // SizedBox(
    //     //   height: 10,
    //     // ),
    //     // Text(
    //     //   'Jackpot',
    //     //   style: TextStyle(
    //     //     color: Colors.white,
    //     //     fontSize: 35,
    //     //     fontWeight: FontWeight.w600,
    //     //     fontStyle: FontStyle.italic
    //     //   ),
    //     // ),
    //     // Text(
    //     //   'Win Real Cash',
    //     //   style: TextStyle(
    //     //     color: Colors.yellow,
    //     //     fontSize: 25,
    //     //     fontWeight: FontWeight.w300,
    //     //   ),
    //     // ),
    //   ],
    // ),
      backgroundColor: Colors.deepPurple,
      //animationDuration: Duration(seconds: 1),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 400,
      duration: 4000,
      pageTransitionType: PageTransitionType.topToBottom,
      //disableNavigation: true,
      nextScreen: const LoginScreen(),
    );
  }
}
