import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';
import 'package:win_money_game/models/statistics_model.dart';

import '../../models/user_model.dart';

bool selectTasaly = false;
bool selectRebh = false;

bool select3x3 = false;
bool select4x4 = false;
bool select5x5 = false;

bool playOnline = false;
bool playOffline = false;

bool chose50 = false;
bool chose100 = false;
bool chose500 = false;
bool chose1k = false;
bool chose2500 = false;
bool chose5k = false;
bool chose10k = false;
bool chose25k = false;
bool chose50k = false;
bool chose100k = false;

bool selectXo = false;
bool selectChess = false;

RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String Function(Match) mathFunc = (Match match) => '${match[1]},';

final List<String> avatarImages = [
  ('assets/images/avatar_1.png'),
  ('assets/images/avatar_2.png'),
  ('assets/images/avatar_3.png'),
  ('assets/images/avatar_4.png'),
  ('assets/images/avatar_5.png'),
  ('assets/images/avatar_6.png'),
  ('assets/images/avatar_7.png'),
  ('assets/images/avatar_8.png'),
];

 List<String> images = [
   ('assets/images/50_coins.png'),
   ('assets/images/100_coins.png'),
   ('assets/images/500_coins.png'),
   ('assets/images/1k_coins.png'),
   ('assets/images/2.5k_coins.png'),
   ('assets/images/5k_coins.png'),
   ('assets/images/10k_coins.png'),
   ('assets/images/25k_coins.png'),
   ('assets/images/50k_coins.png'),
   ('assets/images/100k_coins.png'),
];

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateBack(context, widget) =>
    Navigator.pop(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

String? validate(String value) {
    if (value.isEmpty)
      return "Field cannot be empty";
    return null;
}

String getFirstWord(String inputString) {
  List<String> wordList = inputString.split(" ");
  if (wordList.isNotEmpty) {
    return wordList[0];
  } else {
    return ' ';
  }
}

Widget defaultButton({
  double height = 45.0,
  double? width,
  double? fontSize,
  Color? backgroundColorBox,
  Color? textColor,
  double radius = 25.0,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) => Container(
      height: height,
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            fontSize: fontSize ?? 25.0,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColorBox,
        borderRadius: BorderRadiusDirectional.circular(radius),
        // color: background,
        border: Border.all(
          color: Colors.amberAccent,
          width: 1.5,
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  bool isBool = false,
  bool isClickable = false,
  required FormFieldValidator<String> validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  InputBorder? border,
  StrutStyle? x,
}) => TextFormField(
      controller: controller,
      strutStyle: x,
      keyboardType: type,
      obscureText: isBool,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixPressed!();
          },
        ),
        border: border,
      ),
    );

Future<UserModel?> readUser() async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  final snapshot = await docUser.get();
  if (snapshot.exists) {
    return UserModel.fromJson(snapshot.data()!);
  }
  return null;
}

Stream<List<MissionsModel>> readMissions({
  required String missionsType,
}) =>
    FirebaseFirestore.instance.collection(missionsType).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => MissionsModel.fromJson(doc.data()))
            .toList());

Future<StatisticsModel?> readTarget() async {
  final docTarget = FirebaseFirestore.instance.collection('statistics').doc('target');
  final snapshot = await docTarget.get();
  if(snapshot.exists){
    return StatisticsModel.fromJson(snapshot.data()!);
  }
  return null;
}

Widget buildDailyMission(MissionsModel mission) {
  return FutureBuilder<UserModel?>(
    future: readUser(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong! ${snapshot.error}');
      } else if (snapshot.hasData) {
        final user = snapshot.data;
        return user == null
            ? const Center(child: Text('No User'))
            : Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        mission.name,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.amberAccent,
                  ),
                ],
              ),
              subtitle: Text(
                '${user.dailyCounts[mission.mId]}/${mission.count}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.amberAccent,
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

Widget buildWeeklyMission(MissionsModel mission) {
  return FutureBuilder<UserModel?>(
    future: readUser(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong! ${snapshot.error}');
      } else if (snapshot.hasData) {
        final user = snapshot.data;
        return user == null
            ? const Center(child: Text('No User'))
            : Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        mission.name,
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.amberAccent,
                  ),
                ],
              ),
              subtitle: Text(
                '${user.weeklyCounts[mission.mId]}/${mission.count}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Divider(
              color: Colors.amberAccent,
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}