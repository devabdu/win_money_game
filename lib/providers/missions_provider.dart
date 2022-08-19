import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';

class MissionsProvider extends ChangeNotifier {
  List<MissionsModel> dailyMissions = [];

  late List<String> dailyMissionIDs = [];
  late List<String> dailyMissionsNames = [];
  late List<int> dailyMissionsCounts = [];

  void getDailyMissions()
  async {

    MissionsModel missionsModel;

    await FirebaseFirestore.instance
        .collection('dailyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        dailyMissionIDs.add(doc["mId"]);
        dailyMissionsNames.add(doc["name"]);
        dailyMissionsCounts.add(doc["count"]);
      });
    });

    dailyMissionIDs.forEach((id) async {
      await FirebaseFirestore.instance
          .collection('dailyMissions')
          .doc(id)
          .get()
          .then((value) {
        missionsModel = MissionsModel.fromJson(value.data());
        dailyMissions.add(missionsModel);
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  List<MissionsModel> weeklyMissions = [];

  late List<String> weeklyMissionIDs = [];
  late List<String> weeklyMissionsNames = [];
  late List<int> weeklyMissionsCounts = [];

  void getWeeklyMissions()
  async {

    MissionsModel missionsModel;

    await FirebaseFirestore.instance
        .collection('weeklyMissions')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        weeklyMissionIDs.add(doc["mId"]);
        weeklyMissionsNames.add(doc["name"]);
        weeklyMissionsCounts.add(doc["count"]);
      });
    });

    weeklyMissionIDs.forEach((id) async {
      await FirebaseFirestore.instance
          .collection('weeklyMissions')
          .doc(id)
          .get()
          .then((value) {
        missionsModel = MissionsModel.fromJson(value.data());
        weeklyMissions.add(missionsModel);
      }).catchError((error) {
        print(error.toString());
      });
    });
  }
}