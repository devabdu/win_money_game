import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/dice_model.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/game_state.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/token.dart';

class Tokenp extends StatelessWidget {
  final Token token;
  final List<double> dimentions;
  Function (Token) {}
  Tokenp(this.token, this.dimentions);
  Color? _getcolor() {
    switch (token.type) {
      case TokenType.green:
        return Colors.green;
      case TokenType.yellow:
        return Colors.yellow[900];
      case TokenType.blue:
        return Colors.blue[600];
      case TokenType.red:
        return Colors.red;
      case null:
        break;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    final dice = Provider.of<DiceModel>(context);
    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      left: dimentions[0],
      top: dimentions[1],
      width: dimentions[2],
      height: dimentions[3],
      child: GestureDetector(
        onTap: (){
          gameState.moveToken(token, dice.diceOne);
        },
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getcolor(),
                boxShadow: [
                  BoxShadow(
                    color: _getcolor()!,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                  )
                ]),
          ),
        ),
      ),
    );
  }
}