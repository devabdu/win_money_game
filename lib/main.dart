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
import 'package:win_money_game/modules/admin/addDailyMission.dart';
import 'package:win_money_game/modules/select_path_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/provider/room_data_provider.dart';
import 'package:win_money_game/modules/xo-online/provider/room_data_provider_4_4.dart';
import 'package:win_money_game/modules/xo-online/provider/room_data_provider_5_5.dart';
import 'package:win_money_game/modules/xo-online/xo_selecct_level_xo_screen.dart';
import 'package:win_money_game/providers/users_provider.dart';
import 'modules/xo-online/first_xo_screen.dart';
import 'modules/xo-online/second_xo_screen.dart';
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
      ChangeNotifierProvider(create: (context)=>UsersProvider()),
      ChangeNotifierProvider(create: (context)=>RoomDataProvider()),
      ChangeNotifierProvider(create: (context)=>RoomDataProviderFour()),
      ChangeNotifierProvider(create: (context)=>RoomDataProviderFive()),
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
      initialRoute: '/xo',
      routes: {
        // '/' : (context) => const SplashScreen(),
        // // '/' : (context) => AddDailyMission(),
        // '/second' : (context) => LoginScreen(),
        // '/third' : (context) => const SelectPathScreen(),
        '/xo' : (context) => SelectLevelXoScreen(),
        '/createRoom' : (context) => CreateRoomScreen(),
        '/createRoom2' : (context) => CreateRoomScreen2(),
        '/createRoom3' : (context) => CreateRoomScreen3(),
        '/joinroom' : (context) => JoinRoomScreen(),
        '/joinroom2' : (context) => JoinRoomScreen2(),
        '/joinroom3' : (context) => JoinRoomScreen3(),
        '/game' : (context) => FirstXOScreen(),
        '/game2' : (context) => SecondXOScreen(),
        '/game3' : (context) => JoinRoomScreen3(),
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