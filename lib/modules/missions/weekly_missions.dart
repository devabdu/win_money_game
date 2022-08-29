import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/shared/components/components.dart';

import '../../models/missions_model.dart';

class WeeklyMissionsScreen extends StatefulWidget {
  const WeeklyMissionsScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyMissionsScreen> createState() => _WeeklyMissionsScreenState();
}

class _WeeklyMissionsScreenState extends State<WeeklyMissionsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data;
          return user == null
              ? const Center(child: Text('No User'))
              : Scaffold(
            backgroundColor: Colors.deepPurple,
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              iconTheme: const IconThemeData(
                color: Colors.deepPurple,
              ),
              title: const Text(
                'Weekly Missions',
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog<String>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text(
                              'Hint',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            content: Text(
                              'Complete Weekly Missions to Win ${user
                                  .weeklyAmount} Cash and 10k Coins!!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.deepPurple,
                              ),
                            ),
                            backgroundColor: Colors.amberAccent,
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                    );
                  },
                  icon: const Icon(Icons.info_outline),
                ),
              ],
              //centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<List<MissionsModel>>(
                      stream: readMissions(missionsType: 'weeklyMissions'),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final missions = snapshot.data!;
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                // Center(
                                //   child: Text(
                                //     'Weekly Missions',
                                //     style: const TextStyle(
                                //       color: Colors.amberAccent,
                                //       fontWeight: FontWeight.bold,
                                //       fontSize: 25,
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 20,
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListView(
                                      children: missions.map(buildWeeklyMission).toList(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

