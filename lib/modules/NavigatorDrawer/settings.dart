import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              iconTheme: const IconThemeData(
                color: Colors.deepPurple,
              ),
              title: const Text("Settings",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}

