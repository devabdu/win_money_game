import 'package:flutter/material.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/modules/chess/components/home_screen.dart';
import 'package:win_money_game/modules/ludo/ludo_screen.dart';
import 'package:win_money_game/modules/xo/xo_selecct_level_xo_screen.dart';
import 'package:win_money_game/shared/audio_manager.dart';
import 'package:win_money_game/shared/component/component.dart';
import 'package:win_money_game/Provider/test_ads.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
<<<<<<< HEAD
<<<<<<< HEAD

=======
=======
>>>>>>> 86f575b78a779e92fc94fb3726ccf0dfa6de9cc5
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {

  @override
  void initState() {
     AudioManager.init();
  }
  @override
<<<<<<< HEAD
>>>>>>> 86f575b78a779e92fc94fb3726ccf0dfa6de9cc5
=======
>>>>>>> 86f575b78a779e92fc94fb3726ccf0dfa6de9cc5
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 90,
          horizontal: 100
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                navigateTo(context, const SelectLevelXoScreen());
              },
              child: Image.asset("assets/images/xo.png",
                fit: BoxFit.fill,
                width: 200,
                height: 180,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                navigateTo(context, MainMenuScreen());
              },
              child: Image.asset("assets/images/chess.png",
                fit: BoxFit.fill,
                width: 200,
                height: 180,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                navigateTo(context, LudoScreen());
              },
              child: Image.asset("assets/images/LUDO Game.png",
                fit: BoxFit.fill,
                width: 200,
                height: 180,
              ),
            ),
            InkWell(
              onTap: () {
                navigateTo(context, MyMaterialApp());
              },
              child: Image.asset("assets/images/LUDO Game.png",
                fit: BoxFit.fill,
                width: 200,
                height: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
