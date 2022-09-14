import 'package:flutter/material.dart';
import 'package:win_money_game/modules/chess/Old/responsive/responsive.dart';
import '../../../../shared/components/components.dart';
import 'openings_page.dart';
import 'play_game_page.dart';

class MainMenuScreen extends StatelessWidget {
  // static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomButton(
            //   // onTap: () => Navigator.of(context).pushReplacementNamed('/play_game_page'),
            //   onTap: (){
            //     navigateTo(context, PlayGamePage());
            //   },
            //   text: 'Play Game',
            // ),

            defaultButton(
                function: () {
                  navigateTo(context, PlayGamePage());
                },
                backgroundColorBox: Colors.amberAccent,
                textColor: Colors.deepPurple,
                text: 'Play Game',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),
            // CustomButton(
            //   // onTap: () => Navigator.of(context).pushReplacementNamed('/openings'),
            //   onTap: () {
            //     navigateTo(context, OpeningsPage());
            //   },
            //   text: 'Learn Chess Openings',
            // ),
            defaultButton(
              function: () {
                navigateTo(context, OpeningsPage());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Learn Chess Openings',
              width: 300,
              isUpperCase: false,
            )
          ],
        ),
      ),
    );
  }
}
