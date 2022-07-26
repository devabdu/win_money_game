import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:win_money_game/modules/chess/data/opening_data.dart';

class OpeningDetailPage extends StatefulWidget {
  final position;

  const OpeningDetailPage({this.position});

  @override
  _OpeningDetailPageState createState() => _OpeningDetailPageState();
}

class _OpeningDetailPageState extends State<OpeningDetailPage> {
  ChessBoardController controller = ChessBoardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
          backgroundColor: Colors.amberAccent,
          iconTheme: const IconThemeData(
            color: Colors.deepPurple,
          ),
          title: Text(
            openings[widget.position].name,
            style: const TextStyle(
              color: Colors.deepPurple,
            ),
          ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              openings[widget.position].moveNotation,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              openings[widget.position].information,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
