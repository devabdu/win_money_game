import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:win_money_game/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  bool isAFacebookUser = false;

  bool aLoggedUser = false;

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      aLoggedUser = false;

      FirebaseAuth.instance.signInWithCredential(credential).then((value)
      async {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if(value.user!.email.toString() == doc["email"])
              aLoggedUser = true;
          });
        });

        if(!aLoggedUser)
        {
          userSignUp(
            name: value.user!.displayName.toString(),
            email: value.user!.email.toString(),
            uId: value.user!.uid,
          );
          aLoggedUser = false;
        }
      }).catchError((error){
        print('error');
      });
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future facebookLogin() async {
    try {
      final result = await FacebookAuth.instance.login();

      final credential = FacebookAuthProvider.credential(result.accessToken!.token);

      aLoggedUser = false;

      FirebaseAuth.instance.signInWithCredential(credential).then((value)
      async {
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if(value.user!.email.toString() == doc["email"])
              aLoggedUser = true;
          });
        });

        if(!aLoggedUser)
        {
          userSignUp(
            name: value.user!.displayName.toString(),
            email: value.user!.email.toString(),
            uId: value.user!.uid,
          );
          aLoggedUser = false;
        }

        isAFacebookUser = true;

      }).catchError((error){
        print('error');
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

  void userSignUp({
    required String name,
    required String email,
    required String uId,
}) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      uId: uId,
      coins: 0,
      level: 1,
      amount: 0,
      exp: 0,
      avatar: 7,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value)
    {
      print('User Created');
    })
        .catchError((error){
      print(error.toString());
    });
  }
}