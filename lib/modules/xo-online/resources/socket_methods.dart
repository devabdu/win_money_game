// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
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
import 'package:win_money_game/providers/users_provider.dart';
import 'package:win_money_game/shared/components/components.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMITS
  void createRoom(String nickname , String uId , int avatar , int coins ) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
        'uId' : uId,
        'avatar' : avatar ,
        'coins' : coins
      });
    }
  }

  void createRoomFour(String nickname , String uId , int avatar , int coins) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom4', {
        'nickname': nickname,
        'uId' : uId,
        'avatar' : avatar ,
        'coins' : coins
      });
    }
  }

  void createRoomFive(String nickname , String uId , int avatar , int coins) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom5', {
        'nickname': nickname,
        'uId' : uId,
        'avatar' : avatar ,
        'coins' : coins
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
      final provider = Provider.of<RoomDataProvider>(context, listen: false);
      provider.updateRoomData(room);

      Map<String,dynamic> map = {};
      map['nickname'] = room['players'][0]['nickname'];
      map['socketID'] = room['players'][0]['socketID'];
      map['points'] = room['players'][0]['points'];
      map['playerType'] = room['players'][0]['playerType'];

      provider.updatePlayer1(map);
      Navigator.pushNamed(context, '/game');
      print(room);
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
      final provider = Provider.of<RoomDataProvider>(context, listen: false);
      provider.updateRoomData(room);

      Navigator.pushNamed(context, GameScreen.routeName);
      print(room);
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
      FutureBuilder<UserModel?>(
        future: readUser(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if(snapshot.hasData){
            final user = snapshot.data;
            String nickname = playerData['nickname'];
            final provider = Provider.of<UsersProvider>(context, listen: false);

            //tasaly winner
            if(getFirstWord(user!.name).capitalize() == nickname.capitalize() && selectTasaly){
              provider.updateUserXoTasalyWins(
                userTasalyWins: user.xoTwins,
              );
            }
            //rebh winner
            else if(getFirstWord(user.name).capitalize() == nickname.capitalize() && selectRebh){
              provider.updateUserXoRebhWins(
                userRebhWins: user.xoRwins,
              );
            }

            //winner
            if(getFirstWord(user.name).capitalize() == nickname.capitalize()){
              provider.updateUserDailyMissionProgress(
                missionName: 'Win 3 games',
                userCounts: user.dailyCounts,
              );
              provider.updateUserWeeklyMissionProgress(
                missionName: 'Win 9 games',
                userCounts: user.weeklyCounts,
              );
              // provider.updateWinnerCoins(
              //   userCoins: user.coins,
              //   coinsWon: playerData['coins'],
              // );
              // provider.updateUserDailyCoinsMissionProgress(
              //   missionName: 'Collect 500 coins',
              //   userCounts: user.dailyCounts,
              //   coinsWon: playerData['coins'],
              // );
              // provider.updateUserWeeklyCoinsMissionProgress(
              //   missionName: 'Collect 10k coins',
              //   userCounts: user.weeklyCounts,
              //   coinsWon: playerData['coins'],
              // );
            }
            //loser
            else if(getFirstWord(user.name).capitalize() != nickname.capitalize()){
              // provider.updateLoserCoins(
              //   userCoins: user.coins,
              //   coinsLost: playerData['coins'],
              // );
            }

            //loser and winner
            provider.updateUserLevelAndExp(
                userExp: user.exp,
                userLevel: user.level,
            );
            provider.updateUserDailyMissionProgress(
              missionName: 'Play 5 games',
              userCounts: user.dailyCounts,
            );
            provider.updateUserWeeklyMissionProgress(
              missionName: 'Play 10 games',
              userCounts: user.weeklyCounts,
            );
            showGameDialog(context, '${playerData['nickname']} won the game!');
            Navigator.pushNamed(context, '/xo');
            return user == null ? const Center(child:Text('No User')) : Center();
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      );
    });
  }

  // void endGameListener(BuildContext context) {
  //   _socketClient.on('endGame', (playerData) {
  //     showGameDialog(context, '${playerData['nickname']} won the game!');
  //     Navigator.popUntil(context, (route) => false);
  //   });
  // }
}