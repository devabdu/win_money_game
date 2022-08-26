import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';
import 'package:win_money_game/models/user_model.dart';

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
  int userAmount = 0;
  int userCoins = 0;

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
      showDialog(context: context, builder: (context) => AlertDialog(
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
    showDialog(context: context, builder: (context) => AlertDialog(
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
    showDialog(context: context, builder: (context) => AlertDialog(
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
        showDialog(context: context, builder: (context) => AlertDialog(
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
        showDialog(context: context, builder: (context) => AlertDialog(
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
        showDialog(context: context, builder: (context) => AlertDialog(
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
        showDialog(context: context, builder: (context) => AlertDialog(
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
    showDialog(context: context, builder: (context) => AlertDialog(
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
    showDialog(context: context, builder: (context) => AlertDialog(
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
    bool doUpdate = false;

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
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'dailyCounts' : userCounts,
        });

        if(userCounts[dailyMissionId] == dailyMissionCount){
          dailyMissionReward();
        }
      }
    });
  }

  Future<void> updateUserWeeklyMissionProgress({
    required Map<String, dynamic> userCounts,
    required String missionName,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool doUpdate = false;

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
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'weeklyCounts' : userCounts,
            });

        if(userCounts[weeklyMissionId] == weeklyMissionCount){
          weeklyMissionReward();
        }
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
    bool doUpdate = false;

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

        if(userCounts[dailyMissionId] > dailyMissionCount)
          userCounts[dailyMissionId] = dailyMissionCount;
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'dailyCounts' : userCounts,
            });

        if(userCounts[dailyMissionId] == dailyMissionCount){
          dailyMissionReward();
        }
      }
    });
  }

  Future<void> updateUserWeeklyCoinsMissionProgress({
    required Map<String, dynamic> userCounts,
    required int coinsWon,
    required String missionName,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool doUpdate = false;

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

        if(userCounts[weeklyMissionId] > weeklyMissionCount)
          userCounts[weeklyMissionId] = weeklyMissionCount;
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'weeklyCounts' : userCounts,
            });

        if(userCounts[weeklyMissionId] == weeklyMissionCount){
          weeklyMissionReward();
        }
      }
    });
  }

  Future<void> updateUserXoTasalyWins({
    required int userTasalyWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool doUpdate = false;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userTasalyWins < targetWins) {
        userTasalyWins++;
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'xoTwins' : userTasalyWins,
            });
      }
    });
  }

  Future<void> updateUserXoRebhWins({
    required int userRebhWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool doUpdate = false;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userRebhWins < targetWins) {
        userRebhWins++;
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'xoRwins' : userRebhWins,
            });
      }
    });
  }

  Future<void> updateUserChessTasalyWins({
    required int userTasalyWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool doUpdate = false;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userTasalyWins < targetWins) {
        userTasalyWins++;
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'chessTwins' : userTasalyWins,
            });
      }
    });
  }

  Future<void> updateUserChessRebhWins({
    required int userRebhWins,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    bool doUpdate = false;

    await FirebaseFirestore.instance
        .collection('statistics')
        .doc('target')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      dynamic docData = documentSnapshot.data();
      targetWins = docData['targetWins'];
    }).then((value) async {
      if(userRebhWins < targetWins) {
        userRebhWins++;
        doUpdate = true;
      }
      if(doUpdate){
        await FirebaseFirestore.instance
            .collection('users')
            .doc(id)
            .update(
            {
              'chessRwins' : userRebhWins,
            });
      }
    });
  }

  void dailyMissionReward() async{
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      dynamic docData = documentSnapshot.data();
      userAmount = docData['amount'];
      userCoins = docData['coins'];
    });

    userAmount = userAmount + 20;
    userCoins = userCoins + 5000;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'amount' : userAmount,
          'coins' : userCoins,
        });
  }

  void weeklyMissionReward() async{
    final id = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      print(documentSnapshot.data());
      dynamic docData = documentSnapshot.data();
      userAmount = docData['amount'];
      userCoins = docData['coins'];
    });

    userAmount = userAmount + 40;
    userCoins = userCoins + 10000;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(
        {
          'amount' : userAmount,
          'coins' : userCoins,
        });
  }
}