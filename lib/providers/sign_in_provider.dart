import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:win_money_game/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(scopes:['email']);

  bool aLoggedUser = false;

  Future googleLogin(context) async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      aLoggedUser = false;

      await FirebaseAuth.instance.signInWithCredential(credential).then((value)
      async {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if(value.user!.email.toString() == doc["email"]) {
              aLoggedUser = true;
            }
          });
        });

        if(!aLoggedUser)
        {
          await userSignUp(
            name: value.user!.displayName.toString(),
            email: value.user!.email.toString(),
            uId: value.user!.uid,
          );
        }
      }).catchError((error){
        print(error.toString());

        var content = '';
        switch(error.code) {
          case 'account-exists-with-different-credential':
            content = 'This account exists with a different sign in provider';
            break;
          case 'invalid-credential':
            content = 'Unknown error has occurred';
            break;
          case 'operation-not-allowed':
            content = 'This operation is not allowed';
            break;
          case 'user-disabled':
            content = 'The user you tried to log into is disabled';
            break;
          case 'user-not-found':
            content = 'The user you tried to log into was not found';
            break;
        }
        showDialog(context: context, builder: (context) => AlertDialog(
          title: const Text('log in with google failed'),
          content: Text(content),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text('Ok'),
            ),
          ],
        ));
      });
    } catch (error) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text('log in with google failed'),
        content: const Text('An unknown error occurred'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text('Ok'),
          ),
        ],
      ));
    }
    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future facebookLogin(context) async {
    try {
      final result = await FacebookAuth.instance.login();

      final credential = FacebookAuthProvider.credential(result.accessToken!.token);

      aLoggedUser = false;

      await FirebaseAuth.instance.signInWithCredential(credential).then((value)
      async {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if(value.user!.email.toString() == doc["email"]) {
              aLoggedUser = true;
            }
          });
        });

        if(!aLoggedUser)
        {
          await userSignUp(
            name: value.user!.displayName.toString(),
            email: value.user!.email.toString(),
            uId: value.user!.uid,
          );
        }
      }).catchError((error){
        print(error.toString());

        var content = '';
        switch(error.code) {
          case 'account-exists-with-different-credential':
            content = 'This account exists with a different sign in provider';
            break;
          case 'invalid-credential':
            content = 'Unknown error has occurred';
            break;
          case 'operation-not-allowed':
            content = 'This operation is not allowed';
            break;
          case 'user-disabled':
            content = 'The user you tried to log into is disabled';
            break;
          case 'user-not-found':
            content = 'The user you tried to log into was not found';
            break;
        }
        showDialog(context: context, builder: (context) => AlertDialog(
          title: const Text('log in with facebook failed'),
          content: Text(content),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: const Text('Ok'),
            ),
          ],
        ));
      });

    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  Future facebookLogout() async {
    await FacebookAuth.i.logOut();
    FirebaseAuth.instance.signOut();
  }

  Future userSignUp({
    required String name,
    required String email,
    required String uId,
}) async {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      uId: uId,
      coins: 0,
      level: 1,
      amount: 0,
      exp: 0,
      avatar: 7,
      firstDMCount: 0,
      secondDMCount: 0,
      thirdDMCount: 0,
      firstWMCount: 0,
      secondWMCount: 0,
      thirdWMCount: 0,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson())
        .then((value)
    {
    })
        .catchError((error){
      print(error.toString());
    });
  }
}