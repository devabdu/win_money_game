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
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
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


Widget defaultMissionsDialog({
  required String missionsType,
  required Stream<List<MissionsModel>> function,
}){
  return StreamBuilder<List<MissionsModel>>(
      stream: function,
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
                   Center(
                    child: Text(
                      '$missionsType Missions',
                      style: const TextStyle(
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
                      Text(
                        '$missionsType Missions',
                        style: const TextStyle(
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
                      Navigator.pop(context);
                    },
                    isUpperCase: false,
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


Widget buildMission(MissionsModel mission) {
  return FutureBuilder<UserModel?>(
    future: readUser(),
    builder: (context, snapshot) {
      if(snapshot.hasError) {
        return Text('Something went wrong! ${snapshot.error}');
      } else if(snapshot.hasData){
        final user = snapshot.data;
        return user == null ? const Center(child:Text('No User')) : ListTile(
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
              const Spacer(),
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.play_circle_fill_outlined,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
          subtitle: Text(
            mission.mId == 'HudQyQtHj7wqPp6yoGm9' ? '${user.firstDMCount}/${mission.count}' :
            mission.mId == 'f2Sov2X78STX1T1Fen5J' ? '${user.secondDMCount}/${mission.count}':
            mission.mId == 'wjfHjC1lcwnmYBR763zv' ? '${user.thirdDMCount}/${mission.count}' :
            mission.mId == 'MbN1wL6DeOOzfd9vLF5v' ? '${user.firstWMCount}/${mission.count}' :
            mission.mId == 'O0SDLwX9XkIWrKr3I1SH' ? '${user.secondWMCount}/${mission.count}' :
            mission.mId == 'u4K6wJVrrunTawElil4Y' ? '${user.thirdWMCount}/${mission.count}' :
            '',
            style: const TextStyle(
                color: Colors.white
            ),
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator(),);
      }
    },
  );
}

Future<UserModel?> readUser() async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  final snapshot = await docUser.get();
  if(snapshot.exists){
    return UserModel.fromJson(snapshot.data()!);
  }
  return null;
}

Stream<List<MissionsModel>> readMissions({
  required String missionsType,
  required int firstMissionCount,
  required int secondMissionCount,
  required int thirdMissionCount,
}) => FirebaseFirestore.instance
    .collection(missionsType)
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => MissionsModel.fromJson(doc.data())).toList());

void updateAvatar({
  required int avatarIndex,
}) async {
  final id = FirebaseAuth.instance.currentUser!.uid;

  UserModel? userModel;

  final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  final snapshot = await docUser.get();
  if(snapshot.exists){
    userModel = UserModel.fromJson(snapshot.data()!);
  }

  UserModel newUserModel = UserModel(
    name: userModel!.name,
    email: userModel.email,
    uId: userModel.uId,
    exp: userModel.exp,
    level: userModel.level,
    coins: userModel.coins,
    avatar: avatarIndex,
    amount: userModel.amount,
    firstDMCount: userModel.firstDMCount,
    secondDMCount: userModel.secondDMCount,
    thirdDMCount: userModel.thirdDMCount,
    firstWMCount: userModel.firstWMCount,
    secondWMCount: userModel.secondWMCount,
    thirdWMCount: userModel.thirdWMCount,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update(newUserModel.toJson())
      .then((value)
  {
  })
      .catchError((error) {
  });
}

