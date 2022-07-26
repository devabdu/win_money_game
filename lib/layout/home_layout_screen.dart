import 'package:flutter/material.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/modules/chess/components/home_screen.dart';
import 'package:win_money_game/modules/ludo/ludo_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

import '../modules/xo/first_xo_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple, //change your color here
        ),
        title: const Text("Win Money",
          style: TextStyle(color: Colors.deepPurple),
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_bag_rounded),color: Colors.deepPurple,),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, FirstXOScreen());
            },
            child: Image.asset("assets/images/xo.png",
              width: double.infinity,
              height: 180,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              navigateTo(context, MainMenuScreen());
            },
            child: Image.asset("assets/images/chess.png",
              width: double.infinity,
              height: 180,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              navigateTo(context, LudoScreen());
            },
            child: Image.asset("assets/images/LUDO Game.png",
              width: double.infinity,
              height: 180,
            ),
          ),
        ],
      ),
    );
  }
}
