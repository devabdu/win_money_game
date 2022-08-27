import 'package:flutter/material.dart';
import 'package:win_money_game/models/statistics_model.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/shared/components/components.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: readUser(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData){
          final user = snapshot.data;
          return user == null ? const Center(child:Text('No User')) : FutureBuilder<StatisticsModel?>(
            future: readTarget(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if(snapshot.hasData){
                final target = snapshot.data;
                print(snapshot.data);
                return target == null ? const Center(child:Text('No User')) : Scaffold(
                  backgroundColor: Colors.deepPurple,
                  appBar: AppBar(
                    backgroundColor: Colors.amberAccent,
                    iconTheme: const IconThemeData(
                      color: Colors.deepPurple,
                    ),
                    title: const Text("Statistics",
                      style: TextStyle(color: Colors.deepPurple),
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
                                'Win 50 game to Earn 250 Cash and 50k Coins!!',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              backgroundColor: Colors.amberAccent,
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    selectTasaly = true;
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
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Tasaly Statistics',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'XO',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.amberAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Wins',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${user.xoTwins} of ${target.targetWins}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Chess',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.amberAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Wins',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${user.chessTwins} of ${target.targetWins}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 125,
                          ),
                          const Text(
                            'Rebh Statistics',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'XO',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.amberAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Wins',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${user.xoRwins} of ${target.targetWins}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Chess',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.amberAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Wins',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${user.chessRwins} of ${target.targetWins}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
