import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:win_money_game/models/missions_model.dart';

import '../../models/user_model.dart';


bool select3x3 = false;
bool select4x4 = false;
bool select5x5 = false;

final List<String> avatarImages = [
  'assets/images/avatar_1.png',
  'assets/images/avatar_2.png',
  'assets/images/avatar_3.png',
  'assets/images/avatar_4.png',
  'assets/images/avatar_5.png',
  'assets/images/avatar_6.png',
  'assets/images/avatar_7.png',
  'assets/images/avatar_8.png',
];

bool avatar_1 = false;
bool avatar_2 = false;
bool avatar_3 = false;
bool avatar_4 = false;
bool avatar_5 = false;
bool avatar_6 = false;
bool avatar_7 = false;
bool avatar_8 = false;


final List <String> images = [

  'assets/images/50_coins.png',
  'assets/images/100_coins.png',
  'assets/images/500_coins.png',
  'assets/images/1k_coins.png',
  'assets/images/2.5k_coins.png',
  'assets/images/5k_coins.png',
  'assets/images/10k_coins.png',
  'assets/images/25k_coins.png',
  'assets/images/50k_coins.png',
  'assets/images/100k_coins.png',
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
      (route)
  {
    return false;
  },
);

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
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
    onPressed: (){
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: fontSize?? 25.0,
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
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isBool,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap: onTap,
  decoration:  InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: IconButton(
      icon: Icon(suffix),
      onPressed: ()
      {
        suffixPressed!();
      },
    ),
    border: border,
  ),
);


Widget defaultMissionDialog({
  required Function function,
}){
  return StreamBuilder<List<MissionsModel>>(
      stream: readMissions(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if(snapshot.hasData) {
          final missions = snapshot.data!;
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            content: SizedBox(
              height: 300,
              width: 300,
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Missions',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daily Missions',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView(
                        children: missions.map(buildMission).toList(),
                        shrinkWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: defaultButton(
                    function: (){
                      function();
                    },
                    text: "Ok",
                    textColor: Colors.white,
                    backgroundColorBox: Colors.amberAccent,

                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      }
  );
}

Widget buildMission(MissionsModel mission) => ListTile(
  title: Row(
    children: [
      Text(
        mission.name,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w300,
          color: Colors.white
        ),
      ),
      Spacer(),
      Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 20,
      ),
      SizedBox(
        width: 5,
      ),
      Icon(
        Icons.play_circle_fill_outlined,
        color: Colors.white,
        size: 20,
      ),
    ],
  ),
  subtitle: Text(
      '0/${mission.count}',
    style: const TextStyle(
      color: Colors.white
    ),
  ),
);

Future<UserModel?> readUser() async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  final snapshot = await docUser.get();
  if(snapshot.exists){
    return UserModel.fromJson(snapshot.data()!);
  }
  return null;
}

Stream<List<MissionsModel>> readMissions() => FirebaseFirestore.instance
    .collection('missions')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => MissionsModel.fromJson(doc.data())).toList());