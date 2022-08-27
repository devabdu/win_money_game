import 'package:flutter/material.dart';
// import 'package:win_money_game/modules/chess/game.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/modules/xo/xo_select_level_xo_screen.dart';
import 'package:win_money_game/shared/components/components.dart';
import 'package:win_money_game/modules/chess/Old/components/play_game_page.dart';
import 'package:win_money_game/main.dart';
class Play_On_Off extends StatelessWidget {
  const Play_On_Off({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultButton(
              function: () {
                if(selectXo){
                  playOffline = true;
                  playOnline = false;
                  navigateTo(context, SelectLevelXoScreen());
                }
                else if(selectChess){
                  playOffline = true;
                  playOnline = false;

                  navigateTo(context, PlayGamePage());
                }
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play Offline',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),

            defaultButton(
              function: () {
                if(selectXo){
                  playOffline = false;
                  playOnline = true;
                  navigateTo(context, SelectLevelXoScreen());
                }
                else if(selectChess){
                  playOffline = true;
                  playOnline = false;
                  navigateTo(context, PlayGamePage());
                }
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play Online',
              width: 300,
              isUpperCase: false,
            ),
          ],
        ),
      ),
    );
  }
}
