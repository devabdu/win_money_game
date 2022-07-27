import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:win_money_game/layout/home_layout_screen.dart';
import 'package:win_money_game/modules/select_path_screen.dart';
import 'package:win_money_game/shared/component/component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.only(top:100),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(60.0),
              child: Lottie.asset('assets/win-money.json',),
            ),
            const SizedBox(height: 50,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(
                  250, 60
                ),
               textStyle: TextStyle(fontSize: 18),
               side: const BorderSide(
                 color: Colors.white,
               )
              ),
              label: const Text('Login using Facebook'),
              icon: const Icon(Icons.facebook),
              onPressed: (){
                navigateTo(context, SelectPathScreen());
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                      250, 60
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  side: const BorderSide(
                    color: Colors.white,
                  )
              ),
              label: const Text('Login using Gmail'),
              icon: const Icon(Icons.email),
              onPressed: (){
                navigateTo(context, HomeLayoutScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
