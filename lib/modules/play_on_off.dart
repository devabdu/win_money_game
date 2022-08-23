import 'package:flutter/material.dart';
import 'package:win_money_game/modules/ludo/ludo_screen.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/modules/xo-online/xo_selecct_level_xo_screen.dart';
import 'package:win_money_game/modules/xo/xo_selecct_level_xo_screen.dart';
import 'package:win_money_game/modules/xo/xo_select_bet_screen.dart';
import 'package:win_money_game/shared/components/components.dart';

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
                  navigateTo(context, const SelectLevelXoScreen());
                }
                if(selectChess){
                  // navigateTo(context, const MainMenuScreen());
                }
                if(selectLudo){
                  navigateTo(context, const LudoScreen());
                }
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Play Offline',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),

            //////////////hena y anwar //////////
            defaultButton(
              function: () {
                if(selectXo){
                  ///// ht8yr mkanha el path l XO online(SelectLevelXoScreen())
                  // navigateTo(context, const SelectLevelXoScreen());
                  navigateTo(context, SelectLevelXoScreen());
                }
                if(selectChess){
                  ///// ht8yr mkanha el path l chess online(MainMenuScreen())
                  // navigateTo(context, const MainMenuScreen());
                }
                if(selectLudo){
                  ///// ht8yr mkanha el path l ludo online(LudoScreen())
                  navigateTo(context, const LudoScreen());
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
