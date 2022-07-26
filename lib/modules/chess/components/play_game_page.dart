import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:win_money_game/shared/component/component.dart';


class PlayGamePage extends StatefulWidget {
  const PlayGamePage({Key? key}) : super(key: key);
  // static String routeName = '/play_game_page';
  @override
  _PlayGamePageState createState() => _PlayGamePageState();
}

class _PlayGamePageState extends State<PlayGamePage> {
  ChessBoardController controller = ChessBoardController();
  List<String> gameMoves = [];
  var flipBoardOnMove = true;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    controller = ChessBoardController();
    controller.addListener(() {
      if(_isCheckMate()){
        _showDialog("red");
      }
      if(_isDraw()){
        _showDialog(null);
      }});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text(
          "Chess Game",
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            _buildChessBoard(),
            _buildNotationAndOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildChessBoard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 130.0),
      child: ChessBoard(
        controller: controller,
        boardColor: BoardColor.orange,
        boardOrientation: PlayerColor.white,

      ),
    );
  }

  Widget _buildNotationAndOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: defaultButton(
                  function:  () {
                    _resetGame();
                  },
                  text: "Reset game",
                  isUpperCase: false,
                  textColor: Colors.deepPurple,
                  backgroundColorBox: Colors.amberAccent,
                  width: 170
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: defaultButton(
                  function:  () {
                    _undoMove();
                  },
                  text: "Undo Move",
                  isUpperCase: false,
                  textColor: Colors.deepPurple,
                  backgroundColorBox: Colors.amberAccent,
                  width: 170
              ),
            ),

            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal:10),
            //     child: FlatButton(
            //       height: 50,
            //       color: Colors.amberAccent,
            //       textColor: Colors.deepPurple,
            //       onPressed: () {
            //         _resetGame();
            //       },
            //       child: Text("Reset game"),
            //     ),
            //   ),
            // ),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: FlatButton(
            //       height: 50,
            //       color: Colors.amberAccent,
            //       textColor: Colors.deepPurple,
            //       onPressed: () {
            //         _undoMove();
            //       },
            //       child: Text("Undo Move"),
            //     ),
            //   ),
            // ),
          ],
        ),
        Column(
          children: _buildMovesList(),
        )
      ],
    );
  }
  void _showDialog(String? winColor) {
    winColor != null
        ? showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Checkmate!"),
          content: new Text("$winColor wins!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child: new Text("Play Again"),
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
            ),
             FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    )
        : showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Draw!"),
          content: new Text("The game is a draw!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
             FlatButton(
              child: new Text("Play Again"),
              onPressed: () {
                _resetGame();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _resetGame() {
    controller.resetBoard();
    gameMoves.clear();
    setState(() {});
  }

  bool _isCheckMate(){
    return controller.isCheckMate();
  }

  bool _isDraw(){
    return controller.isDraw();
  }
  void _undoMove() {
    controller.game.undo_move();
    if(gameMoves.isNotEmpty) {
      gameMoves.removeLast();
    }
    setState(() {
    });
  }

  List<Widget> _buildMovesList() {
    List<Widget> children = [];

    for(int i = 0; i < gameMoves.length; i++) {
      if(i%2 == 0) {
        children.add(Text("${(i/2+ 1).toInt()}. ${gameMoves[i]} ${gameMoves.length > (i+1) ? gameMoves[i+1] : ""}"));
      }else {

      }
    }

    return children;

  }
}



