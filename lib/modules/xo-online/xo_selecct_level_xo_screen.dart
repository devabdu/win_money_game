import 'package:flutter/material.dart';
import 'package:win_money_game/Modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/Modules/XO/first_xo_screen.dart';
import 'package:win_money_game/Modules/XO/second_xo_screen.dart';
import 'package:win_money_game/Modules/XO/xo_select_bet_screen.dart';
import 'package:win_money_game/Modules/XO/third_xo_screen.dart';
import 'package:win_money_game/Modules/xo-online/responsive/component.dart';
import 'package:win_money_game/Modules/xo-online/components/createroom_screen.dart';
import 'package:win_money_game/Modules/xo-online/components/join_room_screen.dart';

class SelectLevelXoScreen extends StatelessWidget {
  const SelectLevelXoScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultButton(
              function: () {
                select3x3 = true;
                select4x4 = false;
                select5x5 = false;
                print(select3x3);
                navigateTo(context, XoSelectBetScreen());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play Game 3x3',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),
            defaultButton(
              function: () {
                select3x3 = false;
                select4x4 = true;
                select5x5 = false;
                navigateTo(context, CreateRoomScreen());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play online Game',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),
            defaultButton(
              function: () {
                select3x3 = false;
                select4x4 = false;
                select5x5 = true;

                navigateTo(context, JoinRoomScreen());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'join room',
              width: 300,
              isUpperCase: false,
            ),
          ],
        ),
      ),
    );
  }
}
