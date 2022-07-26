import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/dice_model.dart';
class Dice extends StatelessWidget {

  void updateDices(DiceModel dice) {
    for (int i = 0; i < 6; i++) {
      var  duration = 100 + i * 100;
      var future  = Future.delayed(Duration(milliseconds: duration),(){
        dice.generateDiceOne();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _diceOneImages = [
      "assets/images/1.png",
      "assets/images/2.png",
      "assets/images/3.png",
      "assets/images/4.png",
      "assets/images/5.png",
      "assets/images/6.png",
    ];
    final dice = Provider.of<DiceModel>(context);
    final c = dice.diceOneCount;
    var img = Image.asset(
      _diceOneImages[c - 1],
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );
    return Card(
      elevation: 10,
      child: Container(
        height: 40,
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () => updateDices(dice),
                    child: img,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}