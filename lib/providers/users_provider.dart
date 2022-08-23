import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';
import 'package:win_money_game/models/user_model.dart';

class UsersProvider extends ChangeNotifier {
  late List<UserModel> users = [];
  late List<String> usersIDs = [];
  late List<String> dailyMissionIDs = [];
  late List<String> weeklyMissionIDs = [];

  late Map<String, dynamic> usersDailyCounts = {};
  late Map<String, dynamic> usersWeeklyCounts = {};

  late Map<String, dynamic> usersResetDailyCounts = {};
  late Map<String, dynamic> usersResetWeeklyCounts = {};

  Future<void> updateAvatar({
    required int avatarIndex,
    required context,
  }) async {
    final id = FirebaseAuth.instance.currentUser!.uid;

    final docUser = FirebaseFirestore.instance.collection('users').doc(id);

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
                Navigator.pop(context);
              }, child: const Text('Ok'),
              ),
            ],
          ));
        });
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
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: const Text('Ok'),
          ),
        ],
      ));

  }
}