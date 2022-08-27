import 'package:flutter/material.dart';
import 'package:win_money_game/modules/NavigatorDrawer/navigation_drawer_widget.dart';
import 'package:win_money_game/shared/components/components.dart';

import '../../models/missions_model.dart';

class DailyMissionsScreen extends StatefulWidget {
  const DailyMissionsScreen({Key? key}) : super(key: key);

  @override
  State<DailyMissionsScreen> createState() => _DailyMissionsScreenState();
}

class _DailyMissionsScreenState extends State<DailyMissionsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Text(
          'Daily Missions',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text(
                    'Hint',
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  content: const Text(
                    'Complete Daily Missions to Win 20 Cash and 5k Coins!!',
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
            stream: readMissions(missionsType: 'dailyMissions'),
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
                      //     'Daily Missions',
                      //     style: const TextStyle(
                      //       color: Colors.amberAccent,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 25,
                      //     ),
                      //   ),
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView(
                            children: missions.map(buildDailyMission).toList(),
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
  }
}

