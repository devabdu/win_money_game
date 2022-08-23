import 'package:flutter/material.dart';
import 'package:win_money_game/modules/XO/xo_utils.dart';
import 'package:win_money_game/modules/xo-online/provider/room_data_provider_5_5.dart';
import 'package:win_money_game/modules/xo-online/resources/socket_methods.dart';
import 'package:provider/provider.dart';

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class ThirdXOScreen extends StatefulWidget {

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<ThirdXOScreen> {
  static final countMatrix = 5;
  static final double size = 62;
  final SocketMethods _socketMethods = SocketMethods();
  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();
    _socketMethods.tappedListenerFive(context);
    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
    countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
  ));

  @override
  Widget build(BuildContext context) {
    RoomDataProviderFive roomDataProvider = Provider.of<RoomDataProviderFive>(
        context);
    return Scaffold(
      //backgroundColor: Color.fromRGBO(16, 13, 34, 1),
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        // centerTitle: true,
        // backgroundColor: Color.fromRGBO(16, 13, 34, 1),
          backgroundColor: Colors.amberAccent,
          iconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          title: const Text(
            'Tic Tac Toe',
            style: TextStyle(color: Colors.deepPurple),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout_outlined),
              color: Colors.deepPurple,
            ),
          ]
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SafeArea(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 170),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Second player',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mic_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),
          ...Xo_Utils.modelBuilder(matrix, (x, value) => buildRow(x,roomDataProvider)),
          SafeArea(
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    'https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'First Player',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mic_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
  Widget buildRow(int x,RoomDataProviderFive roomDataProvider) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Xo_Utils.modelBuilder(
        values,
            (y, value) => buildField(x, y,roomDataProvider),
      ),
    );
  }

  Color getShadowColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.amberAccent;
      case Player.X:
        return Colors.deepPurple;
      default:
        return Color.fromRGBO(16, 13, 34, 1);
    }
  }

  Widget buildField(int x, int y,RoomDataProviderFive roomDataProvider) {
    final value = matrix[x][y];
    final color = getShadowColor(value);
    late final int index;

    if(x == 0 && y ==0){
      index = 0;
    }else if(x == 0 && y == 1){
      index = 1;
    }else if(x == 0 && y == 2){
      index = 2;
    }else if(x == 0 && y == 3){
      index = 3;
    }else if(x == 0 && y == 4){
      index = 4;
    }else if(x == 1 && y == 0){
      index = 5;
    }else if(x == 1 && y == 1){
      index = 6;
    }else if(x == 1 && y == 2){
      index = 7;
    }else if(x == 1 && y == 3){
      index = 8;
    }else if(x == 1 && y == 4){
      index = 9;
    }else if(x == 2 && y == 0){
      index = 10;
    }else if(x == 2 && y == 1){
      index = 11;
    }else if(x == 2 && y == 2){
      index = 12;
    }else if(x == 2 && y == 3){
      index = 13;
    }else if(x == 2 && y == 4){
      index = 14;
    }else if(x == 3 && y == 0){
      index = 15;
    }else if(x == 3 && y == 1){
      index = 16;
    }else if(x == 3 && y == 2){
      index = 17;
    }else if(x == 3 && y == 3){
      index = 18;
    }else if(x == 3 && y == 4){
      index = 19;
    }else if(x == 4 && y == 0){
      index = 20;
    }else if(x == 4 && y == 1){
      index = 21;
    }else if(x == 4 && y == 2){
      index = 22;
    }else if(x == 4 && y == 3){
      index = 23;
    }else if(x == 4 && y == 4){
      index = 24;
    }

    return AbsorbPointer(
      absorbing: roomDataProvider.roomData['turn']['socketID'] !=
          _socketMethods.socketClient.id,
      child:Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white24,
          ),
        ),
        margin: EdgeInsets.all(4),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(size, size),
            primary: Color.fromRGBO(16, 13, 34, 1),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: Text(
              roomDataProvider.displayElements[index],
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
          onPressed: () =>selectField(value, x, y , roomDataProvider),
        ),
      ),
    );
  }

  void selectField(String value, int x, int y,RoomDataProviderFive roomDataProvider) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;
      late final int index;

      if(x == 0 && y ==0){
        index = 0;
      }else if(x == 0 && y == 1){
        index = 1;
      }else if(x == 0 && y == 2){
        index = 2;
      }else if(x == 0 && y == 3){
        index = 3;
      }else if(x == 0 && y == 4){
        index = 4;
      }else if(x == 1 && y == 0){
        index = 5;
      }else if(x == 1 && y == 1){
        index = 6;
      }else if(x == 1 && y == 2){
        index = 7;
      }else if(x == 1 && y == 3){
        index = 8;
      }else if(x == 1 && y == 4){
        index = 9;
      }else if(x == 2 && y == 0){
        index = 10;
      }else if(x == 2 && y == 1){
        index = 11;
      }else if(x == 2 && y == 2){
        index = 12;
      }else if(x == 2 && y == 3){
        index = 13;
      }else if(x == 2 && y == 4){
        index = 14;
      }else if(x == 3 && y == 0){
        index = 15;
      }else if(x == 3 && y == 1){
        index = 16;
      }else if(x == 3 && y == 2){
        index = 17;
      }else if(x == 3 && y == 3){
        index = 18;
      }else if(x == 3 && y == 4){
        index = 19;
      }else if(x == 4 && y == 0){
        index = 20;
      }else if(x == 4 && y == 1){
        index = 21;
      }else if(x == 4 && y == 2){
        index = 22;
      }else if(x == 4 && y == 3){
        index = 23;
      }else if(x == 4 && y == 4){
        index = 24;
      }

      tapped(index, roomDataProvider);
      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog('Player $newValue Won');
      } else if (isEnd()) {
        showEndDialog('Undecided Game');
      }
    }
  }

  void tapped(int index, RoomDataProviderFive roomDataProvider) {
    _socketMethods.tapGridFive(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );

  }
  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  /// Check out logic here: https://stackoverflow.com/a/1058804
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Color.fromRGBO(54, 51, 76, 1.0),
      title: Text(title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Text('Press to Restart the Game',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            setEmptyFields();
            Navigator.of(context).pop();
          },
          child: Text('Restart'),
        )
      ],
    ),
  );
}