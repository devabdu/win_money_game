// @dart=2.9
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/Splash%20Screen/splash_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/createroom_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_4_4.dart';
import 'package:win_money_game/modules/xo-online/components/join_room_screen_5_5.dart';
import 'package:win_money_game/modules/xo-online/first_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/second_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/third_xo_online_screen.dart';
import 'package:win_money_game/modules/xo-online/xo_create_or_join_xo_screen.dart';
import 'package:win_money_game/providers/room_data_provider.dart';
import 'package:win_money_game/providers/room_data_provider_4_4.dart';
import 'package:win_money_game/providers/room_data_provider_5_5.dart';
import 'package:win_money_game/providers/users_provider.dart';
import 'providers/sign_in_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  //ads
  Admob.initialize();

  runApp(MultiProvider(
    providers: [
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
  const MyApp({Key key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/xo' : (context) => CreateOrJoinXOScreen(),
        '/createRoom' : (context) => CreateRoomScreen(),
        '/createRoom2' : (context) => CreateRoomScreen2(),
        '/createRoom3' : (context) => CreateRoomScreen3(),
        '/joinroom' : (context) => JoinRoomScreen(),
        '/joinroom2' : (context) => JoinRoomScreen2(),
        '/joinroom3' : (context) => JoinRoomScreen3(),
        '/game' : (context) => FirstXOOnlineScreen(),
        '/game2' : (context) => SecondXOOnlineScreen(),
        '/game3' : (context) => ThirdXOOnlineScreen(),
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