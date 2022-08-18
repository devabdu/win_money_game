import 'package:flutter/material.dart';
import 'package:win_money_game/modules/admin/dailyMissions.dart';
import 'package:win_money_game/modules/admin/weeklyMissions.dart';
import 'package:win_money_game/shared/audio_manager.dart';

import '../../shared/components/components.dart';

class AdminScreen extends StatelessWidget {

  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text("Admin",
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultButton(
              function: (){
                navigateTo(context, DailyMissions());
              },
              text: "Set Daily Missions",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            defaultButton(
              function: (){
                navigateTo(context, WeeklyMissions());
              },
              text: "Set Weekly Missions",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

