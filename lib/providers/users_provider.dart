import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/shared/components/components.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> users = [];
  List<String> usersIDs = [];
  List<String> dailyMissionIDs = [];
  List<String> weeklyMissionIDs = [];

  Map<String, dynamic> usersDailyCounts = {};
  Map<String, dynamic> usersWeeklyCounts = {};

  Map<String, dynamic> usersResetDailyCounts = {};
  Map<String, dynamic> usersResetWeeklyCounts = {};

  String dailyMissionId = '';
  int? dailyMissionCount;

  String weeklyMissionId = '';
  int? weeklyMissionCount;

  int targetWins = 0;

  Future<void> updateAvatar({
    required int avatarIndex,
    required context,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'avatar' : avatarIndex,
        }
    ).then((value) {
      showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
        backgroundColor: Colors.amberAccent,
        title: const Text('Avatar Updated',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Your avatar has been updated successfully',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: const Text('Ok'),
          ),
        ],
      ));
    })
        .catchError((error) {});
  }

  Future<void> getUsersData()
  async {
    UserModel userModel;

    await FirebaseFirestore.instance
        .collection('dailyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dailyMissionIDs.add(doc["mId"]);
      });
    });
    await FirebaseFirestore.instance
        .collection('weeklyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        weeklyMissionIDs.add(doc["mId"]);
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        usersIDs.add(doc["uId"]);
        dailyMissionIDs.forEach((dailyMissionID) {
          usersDailyCounts.addAll({dailyMissionID : doc["dailyCounts"][dailyMissionID]});
          usersResetDailyCounts.addAll({dailyMissionID : 0});
        });
        weeklyMissionIDs.forEach((weeklyMissionID) {
          usersWeeklyCounts.addAll({weeklyMissionID : doc["weeklyCounts"][weeklyMissionID]});
          usersResetWeeklyCounts.addAll({weeklyMissionID : 0});
        });
      });
    });

    usersIDs.forEach((id) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data());
        users.add(userModel);
      }).catchError((error) {
        print(error.toString());
      });
    });
    notifyListeners();
  }

  Future<void> addDailyMission({
    required String missionName,
    required int missionCount,
    required context,
  }) async {
    final docMission = FirebaseFirestore.instance.collection('dailyMissions').doc();

    final mission = MissionsModel(
      name: missionName,
      mId: docMission.id,
      count: missionCount,
    );
    final json = mission.toJson();

    await docMission.set(json);

    users.forEach((user) {
      user.dailyCounts.addAll({docMission.id : 0});
    });
    users.forEach((user) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .update(
          {
            'dailyCounts' : user.dailyCounts,
          });
    });
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      backgroundColor: Colors.amberAccent,
      title: const Text('Mission Added',
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text('A new daily mission has been added successfully',
        style: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }, child: const Text('Ok'),
        ),
      ],
    ));
  }

  Future<void> addWeeklyMission({
    required String missionName,
    required int missionCount,
    required context,
  }) async {
    final docMission = FirebaseFirestore.instance.collection('weeklyMissions').doc();

    final mission = MissionsModel(
      name: missionName,
      mId: docMission.id,
      count: missionCount,
    );
    final json = mission.toJson();

    await docMission.set(json);

    users.forEach((user) {
      user.weeklyCounts.addAll({docMission.id : 0});
    });
    users.forEach((user) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .update(
          {
            'weeklyCounts' : user.weeklyCounts,
          });
    });
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      backgroundColor: Colors.amberAccent,
      title: const Text('Mission Added',
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text('A new weekly mission has been added successfully',
        style: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }, child: const Text('Ok'),
        ),
      ],
    ));
  }

  Future<void> deleteDailyMission({
    required String missionName,
    required context,
  }) async {
    bool missionExists = false;
    String? missionId;

    await FirebaseFirestore.instance
        .collection('dailyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(missionName == doc["name"]){
          missionExists = true;
          missionId = doc["mId"];
        }
      });
    }).then((value) {
      if(missionExists){
        final docMission = FirebaseFirestore.instance.collection('dailyMissions').doc(missionId);
        docMission.delete();

        users.forEach((user) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uId)
              .update(
              {
                'dailyCounts.${missionId}' : FieldValue.delete(),
              });
        });
        showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: const Text('Mission Deleted',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Mission has been deleted successfully',
            style: TextStyle(
              color: Colors.deepPurple,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }, child: const Text('Ok'),
            ),
          ],
        ));
      } else {
        showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: const Text('Mission Not Found',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Mission entered not found in our records. Please try again',
            style: TextStyle(
              color: Colors.deepPurple,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Ok'),
            ),
          ],
        ));
      }
    }).catchError((error){});
  }

  Future<void> deleteWeeklyMission({
    required String missionName,
    required context,
  }) async {
    bool missionExists = false;
    String? missionId;

    await FirebaseFirestore.instance
        .collection('weeklyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(missionName == doc["name"]){
          missionExists = true;
          missionId = doc["mId"];
        }
      });
    }).then((value) {
      if(missionExists){
        final docMission = FirebaseFirestore.instance.collection('weeklyMissions').doc(missionId);
        docMission.delete();

        users.forEach((user) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uId)
              .update(
              {
                'weeklyCounts.${missionId}' : FieldValue.delete(),
              });
        });
        showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: const Text('Mission Deleted',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Mission has been deleted successfully',
            style: TextStyle(
              color: Colors.deepPurple,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            }, child: const Text('Ok'),
            ),
          ],
        ));
      } else {
        showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
          backgroundColor: Colors.amberAccent,
          title: const Text('Mission Not Found',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text('Mission entered not found in our records. Please try again',
            style: TextStyle(
              color: Colors.deepPurple,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text('Ok'),
            ),
          ],
        ));
      }
    }).catchError((error){});
  }

  Future<void> resetUsersDailyProgress(context) async {
    usersIDs.forEach((id) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyCounts' : usersResetDailyCounts,
          });
    });
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      backgroundColor: Colors.amberAccent,
      title: const Text('Daily missions progress reset',
        style: TextStyle(
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text('Daily missions progress for users reset successfully',
        style: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }, child: const Text('Ok'),
        ),
      ],
    ));
  }

  Future<void> resetUsersWeeklyProgress(context) async {
    usersIDs.forEach((id) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'weeklyCounts' : usersResetWeeklyCounts,
          });
    });
    showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
        backgroundColor: Colors.amberAccent,
        title: const Text('Weekly missions progress reset',
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Weekly missions progress for users reset successfully',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: const Text('Ok'),
          ),
        ],
      ));
  }

  Future<void> updateUserDailyMissionProgress({
  required Map<String, dynamic> userCounts,
    required String missionName,
}) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('dailyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(doc["name"] == missionName){
          dailyMissionId = doc["mId"];
          dailyMissionCount = doc["count"];
        }
      });
    }).then((value) async {
      if(userCounts[dailyMissionId] < dailyMissionCount) {
        userCounts[dailyMissionId]++;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'dailyCounts' : userCounts,
            });

        if(userCounts[dailyMissionId] == dailyMissionCount)
          await dailyMissionReward();
      }
    });
  }

  Future<void> updateUserWeeklyMissionProgress({
    required Map<String, dynamic> userCounts,
    required String missionName,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('weeklyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(doc["name"] == missionName){
          weeklyMissionId = doc["mId"];
          weeklyMissionCount = doc["count"];
        }
      });
    }).then((value) async {
      if(userCounts[weeklyMissionId] < weeklyMissionCount) {
        userCounts[weeklyMissionId]++;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'weeklyCounts' : userCounts,
            });

        if(userCounts[weeklyMissionId] == weeklyMissionCount)
          await weeklyMissionReward();
      }
    });
  }

  Future<void> updateUserLevelAndExp({
    required double userExp,
    required int userLevel,
}) async{
    final id = FirebaseAuth.instance.currentUser!.uid;

    userExp = userExp + 0.25;
    if(userExp == 1) {
      userLevel++;
      userExp = 0;
    }

     await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'exp' : userExp,
          'level' : userLevel,
        });
  }

  Future<void> updateWinnerCoins({
    required int userCoins,
    required int coinsWon,
  }) async{
    final id = FirebaseAuth.instance.currentUser!.uid;

    userCoins = userCoins + coinsWon;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'coins' : userCoins,
        });
  }

  Future<void> updateLoserCoins({
    required int userCoins,
    required int coinsLost,
  }) async{
    final id = FirebaseAuth.instance.currentUser!.uid;

    userCoins = userCoins - coinsLost;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'coins' : userCoins,
        });
  }

  Future<void> updateUserDailyCoinsMissionProgress({
    required Map<String, dynamic> userCounts,
    required int coinsWon,
    required String missionName,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('dailyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(doc["name"] == missionName){
          dailyMissionId = doc["mId"];
          dailyMissionCount = doc["count"];
        }
      });
    }).then((value) async {
      if(userCounts[dailyMissionId] < dailyMissionCount) {
        userCounts[dailyMissionId] = userCounts[dailyMissionId] + coinsWon;

        if(userCounts[dailyMissionId] > dailyMissionCount) {
          userCounts[dailyMissionId] = dailyMissionCount;
          await dailyMissionReward();
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'dailyCounts' : userCounts,
            });
      }
    });
  }

  Future<void> updateUserWeeklyCoinsMissionProgress({
    required Map<String, dynamic> userCounts,
    required int coinsWon,
    required String missionName,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('weeklyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if(doc["name"] == missionName){
          weeklyMissionId = doc["mId"];
          weeklyMissionCount = doc["count"];
        }
      });
    }).then((value) async {
      if(userCounts[weeklyMissionId] < weeklyMissionCount) {
        userCounts[weeklyMissionId] = userCounts[weeklyMissionId] + coinsWon;

        if(userCounts[weeklyMissionId] > weeklyMissionCount) {
          userCounts[weeklyMissionId] = weeklyMissionCount;
          await weeklyMissionReward();
        }

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'weeklyCounts' : userCounts,
            });
      }
    });
  }

  Future<void> updateUserXoTasalyWins({
    required int userTasalyWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userTasalyWins < targetWins) {
        userTasalyWins++;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'xoTwins' : userTasalyWins,
            });

        if(userTasalyWins == targetWins)
          tasalyStatisticsReward();
      }
    });
  }

  Future<void> updateUserXoRebhWins({
    required int userRebhWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userRebhWins < targetWins) {
        userRebhWins++;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'xoRwins' : userRebhWins,
            });

        if(userRebhWins == targetWins)
          rebhStatisticsReward();
      }
    });
  }

  Future<void> updateUserChessTasalyWins({
    required int userTasalyWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userTasalyWins < targetWins) {
        userTasalyWins++;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'chessTwins' : userTasalyWins,
            });

        if(userTasalyWins == targetWins)
          tasalyStatisticsReward();
      }
    });
  }

  Future<void> updateUserChessRebhWins({
    required int userRebhWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userRebhWins < targetWins) {
        userRebhWins++;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'chessRwins' : userRebhWins,
            });

        if(userRebhWins == targetWins)
          rebhStatisticsReward();
      }
    });
  }

  Future<void> dailyMissionReward() async{
    final id = FirebaseAuth.instance.currentUser!.uid;
    int userCash = 0;
    int userCoins = 0;
    int userDailyAmount = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      userCash = docData['cash'];
      userCoins = docData['coins'];
      userDailyAmount = docData['dailyAmount'];
    });

    userCash = userCash + userDailyAmount;
    userCoins = userCoins + 5000;

    // update user's dailyAmount
    if(userCash >= 1000 && userDailyAmount == 10){
      userDailyAmount = 5;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyAmount' : userDailyAmount,
          });
    } else if(userCash >= 1200 && userDailyAmount == 5){
      userDailyAmount = 4;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyAmount' : userDailyAmount,
          });
    } else if(userCash >= 1500 && userDailyAmount == 4){
      userDailyAmount = 3;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyAmount' : userDailyAmount,
          });
    } else if(userCash >= 1700 && userDailyAmount == 3){
      userDailyAmount = 2;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyAmount' : userDailyAmount,
          });
    } else if(userCash >= 1900 && userDailyAmount == 2){
      userDailyAmount = 1;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyAmount' : userDailyAmount,
          });
    } else if(userCash >= 2000 && userDailyAmount == 1){
      userDailyAmount = 0;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'dailyAmount' : userDailyAmount,
          });
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'cash' : userCash,
          'coins' : userCoins,
        });
  }

  Future<void> weeklyMissionReward() async{
    final id = FirebaseAuth.instance.currentUser!.uid;
    int userCash = 0;
    int userCoins = 0;
    int userWeeklyAmount = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      userCash = docData['cash'];
      userCoins = docData['coins'];
      userWeeklyAmount = docData['weeklyAmount'];
    });

    userCash = userCash + userWeeklyAmount;
    userCoins = userCoins + 10000;

    // update user's weeklyAmount
    if(userCash >= 1000 && userWeeklyAmount == 50){
      userWeeklyAmount = 25;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'weeklyAmount' : userWeeklyAmount,
          });
    } else if(userCash >= 1500 && userWeeklyAmount == 25){
      userWeeklyAmount = 10;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'weeklyAmount' : userWeeklyAmount,
          });
    } else if(userCash >= 1800 && userWeeklyAmount == 10){
      userWeeklyAmount = 5;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'weeklyAmount' : userWeeklyAmount,
          });
    } else if(userCash >= 2000 && userWeeklyAmount == 5){
      userWeeklyAmount = 0;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update(
          {
            'weeklyAmount' : userWeeklyAmount,
          });
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'cash' : userCash,
          'coins' : userCoins,
        });
  }

  Future<void> watchAdReward() async{
    final id = FirebaseAuth.instance.currentUser!.uid;
    int userCoins = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      userCoins = docData['coins'];
    });

    userCoins = userCoins + 1000;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'coins' : userCoins,
        });
  }

  Future<void> tasalyStatisticsReward() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    int userCoins = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      userCoins = docData['coins'];
    });

    userCoins = userCoins + 25000;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'coins' : userCoins,
        });
  }

  Future<void> rebhStatisticsReward() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    int userCash = 0;
    int userCoins = 0;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();
      userCash = docData['cash'];
      userCoins = docData['coins'];
    });

    userCash = userCash + 250;
    userCoins = userCoins + 50000;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'cash' : userCash,
          'coins' : userCoins,
        });
  }

  Future<void> getMusicState() async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dynamic docData = documentSnapshot.data();

      player = AudioPlayer();
      cache = AudioCache(fixedPlayer: player);
      if(docData['musicOn']){
        playTillTab('music.ogg.mp3');
      }
    });
  }

  Future<void> turnOffMusic() async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'musicOn': false,
        });
  }

  Future<void> turnOnMusic() async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'musicOn': true,
        });
  }

  Future<void> turnOnMusicAfterBackground() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool userMusicState = false;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        dynamic docData = documentSnapshot.data();
        userMusicState = docData['musicOn'];

        if(userMusicState)
          playTillTab('music.ogg.mp3');
      });
  }



  Future<void> gameXOWinEnded({
    required String result,
    required int coinsPlayedOn,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    String userName = '';
    int userXoTwins = 0;
    int userXoRwins = 0;
    int userLevel = 0;
    double userExp = 0;
    int userCurrentCoins = 0;
    Map<String, dynamic> userDailyCounts = {};
    Map<String, dynamic> userWeeklyCounts = {};

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      dynamic docData = documentSnapshot.data();
      userName = docData['name'];
      userXoTwins = docData['xoTwins'];
      userXoRwins = docData['xoRwins'];
      userLevel = docData['level'];
      userExp = docData['exp'];
      userCurrentCoins = docData['coins'];
      userDailyCounts = docData['dailyCounts'];
      userWeeklyCounts = docData['weeklyCounts'];

      //tasaly winner
      if(userName == result && selectTasaly){
        await updateUserXoTasalyWins(
          userTasalyWins: userXoTwins,
        );
      }
      //rebh winner
      else if(userName == result && selectRebh){
        await updateUserXoRebhWins(
          userRebhWins: userXoRwins,
        );
      }

      //winner
      if(userName == result){
        await updateUserDailyMissionProgress(
          missionName: 'Win 3 games',
          userCounts: userDailyCounts,
        );
        await updateUserWeeklyMissionProgress(
          missionName: 'Win 9 games',
          userCounts: userWeeklyCounts,
        );
        await updateWinnerCoins(
          userCoins: userCurrentCoins,
          coinsWon: coinsPlayedOn,
        );
        await updateUserDailyCoinsMissionProgress(
          missionName: 'Collect 500 coins',
          userCounts: userDailyCounts,
          coinsWon: coinsPlayedOn,
        );
        await updateUserWeeklyCoinsMissionProgress(
          missionName: 'Collect 10k coins',
          userCounts: userWeeklyCounts,
          coinsWon: coinsPlayedOn,
        );
      }
      //loser
      else{
        await updateLoserCoins(
          userCoins: userCurrentCoins,
          coinsLost: coinsPlayedOn,
        );
      }

      //loser, winner
      await updateUserLevelAndExp(
        userExp: userExp,
        userLevel: userLevel,
      );
      await updateUserDailyMissionProgress(
        missionName: 'Play 5 games',
        userCounts: userDailyCounts,
      );
      await updateUserWeeklyMissionProgress(
        missionName: 'Play 10 games',
        userCounts: userWeeklyCounts,
      );
    });
  }

  Future<void> gameXODrawEnded() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    int userLevel = 0;
    double userExp = 0;
    Map<String, dynamic> userDailyCounts = {};
    Map<String, dynamic> userWeeklyCounts = {};

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      dynamic docData = documentSnapshot.data();
      userLevel = docData['level'];
      userExp = docData['exp'];
      userDailyCounts = docData['dailyCounts'];
      userWeeklyCounts = docData['weeklyCounts'];

      await updateUserLevelAndExp(
        userExp: userExp,
        userLevel: userLevel,
      );
      await updateUserDailyMissionProgress(
        missionName: 'Play 5 games',
        userCounts: userDailyCounts,
      );
      await updateUserWeeklyMissionProgress(
        missionName: 'Play 10 games',
        userCounts: userWeeklyCounts,
      );
    });
  }
}