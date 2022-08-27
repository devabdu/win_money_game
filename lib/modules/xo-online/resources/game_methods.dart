import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/providers/room_data_provider.dart';
import 'package:win_money_game/modules/xo-online/Utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:win_money_game/providers/users_provider.dart';

import '../../../shared/components/components.dart';

class GameMethods {
  void checkWinner(BuildContext context, Socket socketClent) {
    RoomDataProvider roomDataProvider =
    Provider.of<RoomDataProvider>(context, listen: false);

    String winner = '';

    // Checking rows
    if (roomDataProvider.displayElements[0] ==
        roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[3] ==
        roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[3] != '') {
      winner = roomDataProvider.displayElements[3];
    }
    if (roomDataProvider.displayElements[6] ==
        roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[6] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[6] != '') {
      winner = roomDataProvider.displayElements[6];
    }

    // Checking Column
    if (roomDataProvider.displayElements[0] ==
        roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[1] ==
        roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[1] != '') {
      winner = roomDataProvider.displayElements[1];
    }
    if (roomDataProvider.displayElements[2] ==
        roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    }

    // Checking Diagonal
    if (roomDataProvider.displayElements[0] ==
        roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[2] ==
        roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    } else if (roomDataProvider.filledBoxes == 9) {
      winner = '';
      showGameDialog(context, 'Draw');
    }

    gameEnd(result: winner, roomProvider: roomDataProvider);

    if (winner != '') {
      if (roomDataProvider.player1.playerType == winner) {
        showGameDialog(context, '${roomDataProvider.player1.nickname} won!');


        socketClent.emit('winner', {
          'winnerSocketId': roomDataProvider.player1.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      } else {
        showGameDialog(context, '${roomDataProvider.player2.nickname} won!');
        socketClent.emit('winner', {
          'winnerSocketId': roomDataProvider.player2.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      }
    }
  }

  void clearBoard(BuildContext context) {
    RoomDataProvider roomDataProvider =
    Provider.of<RoomDataProvider>(context, listen: false);

    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.setFilledBoxesTo0();
  }

  void gameEnd({
  required String result,
    required RoomDataProvider roomProvider,
}){
    FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          final provider = Provider.of<UsersProvider>(context, listen: false);

          //tasaly winner
          if(user!.name == result && selectTasaly){
            provider.updateUserXoTasalyWins(
              userTasalyWins: user.xoTwins,
            );
          }
          //rebh winner
          else if(user.name == result && selectRebh){
            provider.updateUserXoRebhWins(
              userRebhWins: user.xoRwins,
            );
          }

          //winner
          if(user.name == result){
            provider.updateUserDailyMissionProgress(
              missionName: 'Win 3 games',
              userCounts: user.dailyCounts,
            );
            provider.updateUserWeeklyMissionProgress(
              missionName: 'Win 9 games',
              userCounts: user.weeklyCounts,
            );
            provider.updateWinnerCoins(
              userCoins: user.coins,
              coinsWon: roomProvider.player1.coins,
            );
            provider.updateUserDailyCoinsMissionProgress(
              missionName: 'Collect 500 coins',
              userCounts: user.dailyCounts,
              coinsWon: roomProvider.player1.coins,
            );
            provider.updateUserWeeklyCoinsMissionProgress(
              missionName: 'Collect 10k coins',
              userCounts: user.weeklyCounts,
              coinsWon: roomProvider.player1.coins,
            );
          }
          //loser
          else if(user.name != result && result != ''){
            provider.updateLoserCoins(
              userCoins: user.coins,
              coinsLost: roomProvider.player1.coins,
            );
          }

          //loser, winner and draw
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
          showGameDialog(context, '$result won the game!');
          Navigator.pushNamed(context, '/xo');
          return user == null ? const Center(child:Text('No User')) : Center();
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}