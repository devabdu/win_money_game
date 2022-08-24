import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/shared/components/components.dart';

import 'components/join_room_screen.dart';

class CreateOrJoinXOScreen extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultButton(
              function: () {
                if(select3x3)
                  navigateTo(context, CreateRoomScreen());
                if(select4x4)
                  navigateTo(context, CreateRoomScreen2());
                if(select5x5)
                  navigateTo(context, CreateRoomScreen3());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Create Room',
              width: 300,
              isUpperCase: false,
            ),
            const SizedBox(height: 20),
            defaultButton(
              function: () {
                if(select3x3)
                navigateTo(context, JoinRoomScreen());
                if(select4x4)
                  navigateTo(context, JoinRoomScreen2());
                if(select5x5)
                  navigateTo(context, JoinRoomScreen3());
              },
              backgroundColorBox: Colors.amberAccent,
              textColor: Colors.deepPurple,
              text: 'Join Room',
              width: 300,
              isUpperCase: false,
            ),
          ],
        ),
      ),
    );
  }
}
