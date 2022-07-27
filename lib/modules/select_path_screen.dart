import 'package:flutter/material.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class SelectPathScreen extends StatelessWidget {
  const SelectPathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, const HomeLayoutScreen());
                  },
                  child: Image.asset(
                    "assets/images/Tasaly.png",
                    width: 250,
                    height: 400,
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    navigateTo(context, const HomeLayoutScreen());
                  },
                  child: Image.asset(
                    "assets/images/Tasaly.png",
                    width: 250,
                    height: 400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
