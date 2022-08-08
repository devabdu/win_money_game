import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/modules/Splash%20Screen/splash_screen.dart';
import 'package:win_money_game/modules/login/login_screen.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/dice_model.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/game_state.dart';
import 'package:win_money_game/modules/ludo/ludo_widgets/dice.dart';
import 'package:win_money_game/modules/ludo/ludo_widgets/gameplay.dart';
import 'providers/sign_in_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //ads
  Admob.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=>GameState()),
      ChangeNotifierProvider(create: (context)=>DiceModel()),
      ChangeNotifierProvider(create: (context)=>SignInProvider()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => SplashScreen(),
        '/second' : (context) => LoginScreen(),
        '/third' : (context) => HomeLayoutScreen(),
      },
      supportedLocales: const [
        Locale('en', 'US')
      ],

      debugShowCheckedModeBanner: false,
      title: 'Win Money',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey keyBar = GlobalKey();
  void _onPressed() {
  }
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