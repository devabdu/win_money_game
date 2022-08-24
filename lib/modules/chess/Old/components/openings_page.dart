import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:win_money_game/modules/chess/Old/data/opening_data.dart';

import 'opeining_detail_page.dart';



class OpeningsPage extends StatefulWidget {
  @override
  _OpeningsPageState createState() => _OpeningsPageState();
}

class _OpeningsPageState extends State<OpeningsPage> {
  ChessBoardController controller = ChessBoardController();
  List<ChessBoardController> controllers = [];

  @override
  void initState() {
    super.initState();
    controller = ChessBoardController();
    for(int i = 0; i<openings.length; i++) {
      controllers.add(ChessBoardController());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: const Text("Chess Openings",
          style: TextStyle(color: Colors.deepPurple),
        ),
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
      ),
      body: ListView.builder(
        itemCount: openings.length,
        itemBuilder: (context,position) {
          return OpeningCard(
            leftWidget: ChessBoard(
              controller: controller,

              //
              // onMove: (move){},
              // onDraw: (){},
              // onCheckMate: (win){},
              //  controller: controllers[position],
              // initMoves: openings[position].moves,
              enableUserMoves: false,
              boardColor: BoardColor.orange,
            ),
            rightWidget: Text(
                openings[position].name,
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            heroTag: "Opening$position",
            onTap: (){
              Navigator.push(
                context,
                MyCustomRoute(
                  builder: (context) => OpeningDetailPage(
                    position: position,
                  ),
                ),
              );
            },
          );
        },),
    );
  }
}

class OpeningCard extends StatelessWidget {
  final leftWidget;
  final rightWidget;
  final onTap;
  final heroTag;


  // ignore: use_key_in_widget_constructors
   OpeningCard({this.leftWidget, this.rightWidget, this.onTap, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.amberAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 4.0,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Material(
                      child: Hero(
                        child: leftWidget,
                        tag: heroTag,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: rightWidget,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {

  MyCustomRoute({ builder, settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,

      Animation<double> secondaryAnimation,
      Widget child) {
    if (settings.name=='/') {
      return child;
    }
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(1.0, 0.0),
        ).animate(secondaryAnimation),
        child: child,
      ),
    );
  }
}
