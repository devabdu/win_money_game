import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/modules/xo-online/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => Navigator.of(context).pushReplacementNamed('/xo'),
              text: 'Play Game',
            ),
            const SizedBox(height: 20),
            // CustomButton(
            //   onTap: () => Navigator.of(context).pushReplacementNamed('/openings'),
            //   text: 'Learn Chess Openings',
            // ),
          ],
        ),
      ),
    );
  }
}