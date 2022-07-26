import 'package:flutter/material.dart';
import 'package:win_money_game/modules/xo/xo_utils.dart';

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

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
    countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
  ));

  @override
  Widget build(BuildContext context) => Scaffold(
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
        ...Xo_Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
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

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Xo_Utils.modelBuilder(
        values,
            (y, value) => buildField(x, y),
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

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getShadowColor(value);

    return Container(
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
            value,
            style: TextStyle(
              fontSize: 24,
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
        onPressed: () => selectField(value, x, y),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

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