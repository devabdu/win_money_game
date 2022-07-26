import 'package:flutter/material.dart';
import 'package:win_money_game/modules/chess/responsive/responsive.dart';
import 'package:win_money_game/modules/xo/first_xo_screen.dart';
import 'package:win_money_game/modules/xo/second_xo_screen.dart';
import 'package:win_money_game/modules/xo/third_xo_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class SelectLevelXoScreen extends StatelessWidget {
  const SelectLevelXoScreen({Key? key}) : super(key: key);

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
                navigateTo(context, FirstXOScreen());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play Game 3x3',
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
                navigateTo(context, SecondXOScreen());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play Game 4x4',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),
            defaultButton(
              function: () {
                navigateTo(context, ThirdXOScreen());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'play Game 5x5',
              width: 300,
              isUpperCase: false,
            ),
          ],
        ),
      ),
    );
  }
}
