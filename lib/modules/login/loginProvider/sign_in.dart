import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:win_money_game/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn(scopes:['email']);

  bool aLoggedUser = false;

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(context) async {
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

      await FirebaseAuth.instance.signInWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if(googleUser.email == doc["email"])
            aLoggedUser = true;
        });
      });

      if(!aLoggedUser)
      {
        userSignUp(
          name: googleUser.displayName.toString(),
          email: googleUser.email,
          uId: googleUser.id,
        );
      }
    } on FirebaseAuthException catch (error){
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
      notifyListeners();
    } catch (e) {
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
          title: Text('log in with facebook failed'),
          content: Text(content),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('Ok'),
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

  void userSignUp({
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
    );
    await FirebaseFirestore.instance
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