import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:win_money_game/modules/Splash%20Screen/splash_screen.dart';
import 'package:win_money_game/modules/chess/chess_game.dart';
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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignInProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => RoomDataProvider()),
        ChangeNotifierProvider(create: (context) => RoomDataProviderFour()),
        ChangeNotifierProvider(create: (context) => RoomDataProviderFive()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/chess': (context) => chessGame(),
      },
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Win Money',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}


