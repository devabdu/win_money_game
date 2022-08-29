import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo-online/Utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:win_money_game/providers/room_data_provider_5_5.dart';
import 'package:win_money_game/providers/users_provider.dart';
import 'package:win_money_game/shared/components/components.dart';

class GameMethodsFive {
  void checkWinner(BuildContext context, Socket socketClent) {
    RoomDataProviderFive roomDataProvider =
    Provider.of<RoomDataProviderFive>(context, listen: false);

    String winner = '';

    // Checking rows
    if (roomDataProvider.displayElements[0] ==
        roomDataProvider.displayElements[1] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[2] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[3] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[4] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[5] ==
        roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[5] ==
            roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[5] ==
            roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[5] ==
            roomDataProvider.displayElements[9] &&
        roomDataProvider.displayElements[5] != '') {
      winner = roomDataProvider.displayElements[5];
    }
    if (roomDataProvider.displayElements[10] ==
        roomDataProvider.displayElements[11] &&
        roomDataProvider.displayElements[10] ==
            roomDataProvider.displayElements[12] &&
        roomDataProvider.displayElements[10] ==
            roomDataProvider.displayElements[13] &&
        roomDataProvider.displayElements[10] ==
            roomDataProvider.displayElements[14] &&
        roomDataProvider.displayElements[10] != '') {
      winner = roomDataProvider.displayElements[10];
    }
    if (roomDataProvider.displayElements[15] ==
        roomDataProvider.displayElements[16] &&
        roomDataProvider.displayElements[15] ==
            roomDataProvider.displayElements[17] &&
        roomDataProvider.displayElements[15] ==
            roomDataProvider.displayElements[18] &&
        roomDataProvider.displayElements[15] ==
            roomDataProvider.displayElements[19] &&
        roomDataProvider.displayElements[15] != '') {
      winner = roomDataProvider.displayElements[15];
    }
    if (roomDataProvider.displayElements[20] ==
        roomDataProvider.displayElements[21] &&
        roomDataProvider.displayElements[20] ==
            roomDataProvider.displayElements[22] &&
        roomDataProvider.displayElements[20] ==
            roomDataProvider.displayElements[23] &&
        roomDataProvider.displayElements[20] ==
            roomDataProvider.displayElements[24] &&
        roomDataProvider.displayElements[20] != '') {
      winner = roomDataProvider.displayElements[20];
    }

    // Checking Column
    if (roomDataProvider.displayElements[0] ==
        roomDataProvider.displayElements[5] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[10] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[15] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[20] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[1] ==
        roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[11] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[17] &&
        roomDataProvider.displayElements[1] ==
            roomDataProvider.displayElements[21] &&
        roomDataProvider.displayElements[1] != '') {
      winner = roomDataProvider.displayElements[1];
    }
    if (roomDataProvider.displayElements[2] ==
        roomDataProvider.displayElements[7] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[12] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[17] &&
        roomDataProvider.displayElements[2] ==
            roomDataProvider.displayElements[22] &&
        roomDataProvider.displayElements[2] != '') {
      winner = roomDataProvider.displayElements[2];
    }
    if (roomDataProvider.displayElements[3] ==
        roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[13] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[18] &&
        roomDataProvider.displayElements[3] ==
            roomDataProvider.displayElements[23] &&
        roomDataProvider.displayElements[3] != '') {
      winner = roomDataProvider.displayElements[3];
    }
    if (roomDataProvider.displayElements[4] ==
        roomDataProvider.displayElements[9] &&
        roomDataProvider.displayElements[4] ==
            roomDataProvider.displayElements[14] &&
        roomDataProvider.displayElements[4] ==
            roomDataProvider.displayElements[19] &&
        roomDataProvider.displayElements[4] ==
            roomDataProvider.displayElements[24] &&
        roomDataProvider.displayElements[4] != '') {
      winner = roomDataProvider.displayElements[4];
    }

    // Checking Diagonal
    if (roomDataProvider.displayElements[0] ==
        roomDataProvider.displayElements[6] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[12] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[18] &&
        roomDataProvider.displayElements[0] ==
            roomDataProvider.displayElements[24] &&
        roomDataProvider.displayElements[0] != '') {
      winner = roomDataProvider.displayElements[0];
    }
    if (roomDataProvider.displayElements[4] ==
        roomDataProvider.displayElements[8] &&
        roomDataProvider.displayElements[4] ==
            roomDataProvider.displayElements[12] &&
        roomDataProvider.displayElements[4] ==
            roomDataProvider.displayElements[16] &&
        roomDataProvider.displayElements[4] ==
            roomDataProvider.displayElements[20] &&
        roomDataProvider.displayElements[4] != '') {
      winner = roomDataProvider.displayElements[4];
    } else if (roomDataProvider.filledBoxes == 25) {
      winner = '';
      showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
        backgroundColor: Colors.amberAccent,
        title: Text('Draw',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            clearBoard(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            if(isAJoiner) {
              Navigator.pop(context);
              isAJoiner = false;
            }
          }, child: const Text('Leave'),
          ),
        ],
      ));
      final provider = Provider.of<UsersProvider>(context, listen: false);
      provider.gameXODrawEnded();
    }

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
    RoomDataProviderFive roomDataProvider =
    Provider.of<RoomDataProviderFive>(context, listen: false);

    for (int i = 0; i < roomDataProvider.displayElements.length; i++) {
      roomDataProvider.updateDisplayElements(i, '');
    }
    roomDataProvider.setFilledBoxesTo0();
  }
}