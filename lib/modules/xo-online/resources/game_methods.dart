import 'package:flutter/material.dart';
import 'package:win_money_game/providers/room_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:win_money_game/providers/users_provider.dart';
import 'package:win_money_game/shared/components/components.dart';

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
            GameMethods().clearBoard(context);
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
        socketClent.emit('winner', {
          'winnerSocketId': roomDataProvider.player1.socketID,
          'roomId': roomDataProvider.roomData['_id'],
        });
      } else {
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
}