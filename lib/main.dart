import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/Splash%20Screen/splash_screen.dart';
import 'package:win_money_game/modules/login/login_screen.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/dice_model.dart';
import 'package:win_money_game/modules/ludo/game_engine/model/game_state.dart';
import 'package:win_money_game/modules/ludo/ludo_widgets/dice.dart';
import 'package:win_money_game/modules/ludo/ludo_widgets/gameplay.dart';
<<<<<<< HEAD
import 'package:win_money_game/modules/Splash%20Screen/splash_screen.dart';
import 'package:win_money_game/shared/audio_manager.dart';

=======
import 'package:win_money_game/modules/select_path_screen.dart';
import 'providers/sign_in_provider.dart';
>>>>>>> 91da385411812d4bf14d9c9b74076d0bc64d972a

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
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/second' : (context) => LoginScreen(),
        '/third' : (context) => const SelectPathScreen(),
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
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey keyBar = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      appBar: AppBar(
        key: keyBar,
        title: const Text('Ludo'),
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