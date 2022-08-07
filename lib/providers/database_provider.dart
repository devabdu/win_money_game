import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/user_model.dart';
import 'package:win_money_game/shared/components/constants.dart';

class DatabaseManagerProvider extends ChangeNotifier {

  UserModel? _userModel;

  UserModel get userModel => _userModel!;

  void getUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      _userModel = UserModel.fromJson(value.data());
    }).catchError((error) {
      print(error.toString());
    });
    notifyListeners();
  }
}