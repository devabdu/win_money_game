import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/shared/components/components.dart';

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
                'Daily Missions',
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
                              'Complete Daily Missions to Win ${user
                                  .dailyAmount} Cash and 5k Coins!!',
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

