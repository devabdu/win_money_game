// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:win_money_game/providers/room_data_provider_4_4.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_client.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/providers/room_data_provider.dart';
import 'package:win_money_game/modules/xo-online/Utils/utils.dart';
import 'package:win_money_game/modules/xo-online/components/GameScreen.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:win_money_game/modules/xo-online/resources/game_methods.dart';
import 'package:win_money_game/modules/xo-online/resources/game_methods_4_4.dart';
import 'package:win_money_game/modules/xo-online/resources/game_methods_5_5.dart';
import 'package:win_money_game/providers/room_data_provider_5_5.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  void createRoomFour(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom4', {
        'nickname': nickname,
      });
    }
  }

  void createRoomFive(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom5', {
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

  void joinRoom4(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom4', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void joinRoom5(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom5', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  void tapGridFour(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap4', {
        'index': index,
        'roomId': roomId,
      });
    }
  }
  void tapGridFive(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap5', {
        'index': index,
        'roomId': roomId,
      });
    }
  }
  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game');

    });
  }
  void createRoomSuccessListenerFour(BuildContext context) {
    _socketClient.on('createRoomSuccess4', (room) {
      Provider.of<RoomDataProviderFour>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game2');
    });
  }

  void createRoomSuccessListenerFive(BuildContext context) {
    _socketClient.on('createRoomSuccess5', (room) {
      Provider.of<RoomDataProviderFive>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game3');
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
  void joinRoomSuccessListenerFour(BuildContext context) {
    _socketClient.on('joinRoomSuccess4', (room) {
      Provider.of<RoomDataProviderFour>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game2');
    });
  }

  void joinRoomSuccessListenerFive(BuildContext context) {
    _socketClient.on('joinRoomSuccess5', (room) {
      Provider.of<RoomDataProviderFive>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, '/game3');
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
  void updatePlayersStateListenerFour(BuildContext context) {
    _socketClient.on('updatePlayers4', (playerData) {
      Provider.of<RoomDataProviderFour>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProviderFour>(context, listen: false).updatePlayer2(
        playerData[1],
      );
    });
  }

  void updatePlayersStateListenerFive(BuildContext context) {
    _socketClient.on('updatePlayers5', (playerData) {
      Provider.of<RoomDataProviderFive>(context, listen: false).updatePlayer1(
        playerData[0],
      );
      Provider.of<RoomDataProviderFive>(context, listen: false).updatePlayer2(
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

  void updateRoomListenerFour(BuildContext context) {
    _socketClient.on('updateRoom4', (data) {
      Provider.of<RoomDataProviderFour>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void updateRoomListenerFive(BuildContext context) {
    _socketClient.on('updateRoom5', (data) {
      Provider.of<RoomDataProviderFive>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
      Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void tappedListenerFour(BuildContext context) {
    _socketClient.on('tapped4', (data) {
      RoomDataProviderFour roomDataProvider =
      Provider.of<RoomDataProviderFour>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );

      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      GameMethodsFour().checkWinner(context, _socketClient);
    });
  }

  void tappedListenerFive(BuildContext context) {
    _socketClient.on('tapped5', (data) {
      RoomDataProviderFive roomDataProvider =
      Provider.of<RoomDataProviderFive>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      GameMethodsFive().checkWinner(context, _socketClient);
    });
  }

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

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['nickname']} won the game!');
      Navigator.pushNamed(context, '/xo');
    });
  }
}