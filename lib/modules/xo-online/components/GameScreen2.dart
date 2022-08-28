import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/Views/waiting_lobby2.dart';
import 'package:win_money_game/modules/xo-online/second_xo_online_screen.dart';
import 'package:win_money_game/providers/room_data_provider_4_4.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class GameScreenFour extends StatefulWidget {
  static String routeName = '/game2';
  const GameScreenFour({Key? key}) : super(key: key);

  @override
  State<GameScreenFour> createState() => _GameScreenFourState();
}

class _GameScreenFourState extends State<GameScreenFour> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListenerFour(context);
    _socketMethods.updatePlayersStateListenerFour(context);
    // _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProviderFour roomDataProvider = Provider.of<RoomDataProviderFour>(context);

    return ConditionalBuilder(
      condition: roomDataProvider.roomData['isJoin'],
      builder: (context) {
        return SecondXOOnlineScreen();
      },
      fallback: (context){
        return Scaffold(body: WaitingLobbyFour());
      },
    );
  }
}