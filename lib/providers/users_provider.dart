import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> users = [];

  late List<String> usersIDs = [];
  late List<dynamic> usersDailyCounts = [];
  late List<dynamic> usersWeeklyCounts = [];

  void getUsersData()
  async {
    UserModel userModel;

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        usersIDs.add(doc["uId"]);
        usersDailyCounts.add(doc["dailyCounts"]);
        usersWeeklyCounts.add(doc["weeklyCounts"]);
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