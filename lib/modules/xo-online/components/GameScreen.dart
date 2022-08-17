import 'package:flutter/material.dart';
import 'package:win_money_game/Modules/xo-online/provider/room_data_provider.dart';
import 'package:win_money_game/Modules/xo-online/resources/socket_methods.dart';
import 'package:win_money_game/Modules/xo-online/views/scoreboard.dart';
import 'package:win_money_game/Modules/xo-online/first_xo_screen.dart';
import 'package:win_money_game/Modules/xo-online/views/waiting_lobby.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Scoreboard(),
            FirstXOScreen(),
            Text(
                '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
          ],
        ),
      ),
    );
  }
}