import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/third_xo_online_screen.dart';
import 'package:win_money_game/providers/room_data_provider_5_5.dart';
// import 'package:win_money_game/modules/xo-online/provider/room_data_provider_4_4.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/modules/xo-online/views/scoreboard.dart';
// import 'package:win_money_game/modules/xo-online/first_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/views/waiting_lobby3.dart';
import 'package:provider/provider.dart';

class GameScreenFive extends StatefulWidget {
  static String routeName = '/game3';
  const GameScreenFive({Key? key}) : super(key: key);

  @override
  State<GameScreenFive> createState() => _GameScreenFiveState();
}

class _GameScreenFiveState extends State<GameScreenFive> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListenerFive(context);
    _socketMethods.updatePlayersStateListenerFive(context);
    // _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProviderFive roomDataProvider = Provider.of<RoomDataProviderFive>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // const Scoreboard(),
            ThirdXOOnlineScreen(),
            Text(
                '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
          ],
        ),
      ),
    );
  }
}