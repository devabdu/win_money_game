import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> users = [];

  late List<String> usersIDs = [];
  late List<String> dailyMissionIDs = [];
  late List<String> weeklyMissionIDs = [];
  late Map<String, dynamic> usersDailyCounts = {};
  late Map<String, dynamic> usersWeeklyCounts = {};

  void getUsersData()
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
        });
        weeklyMissionIDs.forEach((weeklyMissionID) {
          usersWeeklyCounts.addAll({weeklyMissionID : doc["weeklyCounts"][weeklyMissionID]});
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
}