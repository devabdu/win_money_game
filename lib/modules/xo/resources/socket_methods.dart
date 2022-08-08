import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:my_app/resources/socket_client.dart';
import 'package:provider/provider.dart';
import 'package:my_app/provider/room_data_provider.dart';
import 'package:my_app/components/play_game_page.dart';
import 'package:my_app/Utils/utils.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
class SocketMethods{
  Map<String, dynamic> _roomData = {};
  final _socketClient = SocketClient.instance.socket!;
  Map<String, dynamic> get roomData => _roomData;
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<Piece?> displayElements) {
    if (displayElements == []) {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      _roomData = room;
      Navigator.pushNamed(context, PlayGamePage.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, PlayGamePage.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  // void tappedListener(BuildContext context) {
  //   _socketClient.on('tapped', (data) {
  //     RoomDataProvider roomDataProvider =
  //     Provider.of<RoomDataProvider>(context, listen: false);
  //     roomDataProvider.updateDisplayElements(
  //       data['index'],
  //       data['choice'],
  //     );
  //     roomDataProvider.updateRoomData(data['room']);
  //     // check winnner
  //     GameMethods().checkWinner(context, _socketClient);
  //   });
  // }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
      Provider.of<RoomDataProvider>(context, listen: false);
      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePlayer1(playerData);
      } else {
        roomDataProvider.updatePlayer2(playerData);
      }
    });
  }

  // void endGameListener(BuildContext context) {
  //   _socketClient.on('endGame', (playerData) {
  //     showGameDialog(context, '${playerData['nickname']} won the game!');
  //     Navigator.popUntil(context, (route) => false);
  //   });
  // }
}