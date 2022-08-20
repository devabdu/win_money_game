import 'package:flutter/material.dart';
import 'package:win_money_game/modules/admin/addDailyMission.dart';
import 'package:win_money_game/modules/admin/addWeeklyMission.dart';
import 'package:win_money_game/modules/admin/deleteDailyMission.dart';
import 'package:win_money_game/shared/audio_manager.dart';

import '../../shared/components/components.dart';
import 'deleteWeeklyMission.dart';

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
                navigateTo(context, AddDailyMission());
              },
              text: "Add a daily mission",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            defaultButton(
              function: (){
                navigateTo(context, AddWeeklyMission());
              },
              text: "Add a weekly mission",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            defaultButton(
              function: (){
                navigateTo(context, DeleteDailyMission());
              },
              text: "Delete a daily mission",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            defaultButton(
              function: (){
                navigateTo(context, DeleteWeeklyMission());
              },
              text: "Delete a weekly mission",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            defaultButton(
              function: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: const Text(
                    'Reset Users Daily Progress',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Are you sure, you want to reset all users daily progress?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  backgroundColor: Colors.amberAccent,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        resetUsersDailyProgress(context);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                );
              },
              text: "Reset users daily progress",
              isUpperCase: false,
              textColor: Colors.white,
              fontSize: 20.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            defaultButton(
              function: (){
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: const Text(
                    'Reset Users Weekly Progress',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold),
                  ),
                  content: const Text(
                    'Are you sure, you want to reset all users weekly progress?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                    ),
                  ),
                  backgroundColor: Colors.amberAccent,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        resetUsersWeeklyProgress(context);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
                );
              },
              text: "Reset users weekly progress",
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

