import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/game_state.dart';

import 'ludo_widgets/dice.dart';
import 'ludo_widgets/gameplay.dart';

class LudoScreen extends StatefulWidget {
  const LudoScreen({Key? key}) : super(key: key);

  @override
  State<LudoScreen> createState() => _LudoScreenState();
}

class _LudoScreenState extends State<LudoScreen> {
  GlobalKey keyBar = GlobalKey();
  void _onPressed() {}
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      appBar: AppBar(
        key: keyBar,
        title: Text('Ludo'),
      ),
      body: GamePlay(keyBar,gameState),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: Dice(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}