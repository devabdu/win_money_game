import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/modules/xo-online/responsive/responsive.dart';
import 'package:win_money_game/shared/components/components.dart';

import 'components/join_room_screen.dart';

class CreateOrJoinXOScreen extends StatefulWidget {

  @override
  State<CreateOrJoinXOScreen> createState() => _CreateOrJoinXOScreenState();
}

class _CreateOrJoinXOScreenState extends State<CreateOrJoinXOScreen> {

  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.createRoomSuccessListener(context);
    _socketMethods.createRoomSuccessListenerFour(context);
    _socketMethods.createRoomSuccessListenerFive(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : Scaffold(
            backgroundColor: Colors.deepPurple,
            body: Responsive(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  defaultButton(
                    function: () {
                      if(select3x3){
                        _socketMethods.createRoom(
                          user.uId,
                        );
                      }
                      else if(select4x4)
                        _socketMethods.createRoomFour(
                          user.uId,
                        );
                      else if(select5x5)
                        _socketMethods.createRoomFive(
                          user.uId,
                        );
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
                      else if(select4x4)
                        navigateTo(context, JoinRoomScreen2());
                      else if(select5x5)
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
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
