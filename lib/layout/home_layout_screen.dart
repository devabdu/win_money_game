import 'package:flutter/material.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/modules/chess/components/home_screen.dart';
import 'package:win_money_game/modules/ludo/ludo_screen.dart';
import 'package:win_money_game/modules/xo/selecct_level_xo_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        // title: const Text("Win Money Game",
        //   style: TextStyle(color: Colors.deepPurple),
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Icon(Icons.monetization_on,
                  color: Colors.deepPurple,
                  size: 25,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '5,00000000000',
                  style:TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              ],
            ),
          ),
          IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_bag_rounded,),color: Colors.deepPurple,),
        ],
      ),
      body: Column(
        children: [
          // SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 10,left: 320),
          //       child:
          //     ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(context, const SelectLevelXoScreen());
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
          ),
        ],
      ),
    );
  }
}
