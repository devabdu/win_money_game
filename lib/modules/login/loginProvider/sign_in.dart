import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

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

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Map? _userData;

  Map get userData => _userData!;

  Future facebookLogin() async {
    try {
      final result = await FacebookAuth.i.login(
          permissions: ["public_profile", "email"]
      );

      if (result.status == LoginStatus.success) {
        final credential = FacebookAuthProvider.credential(result.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (error) {
      print(error.toString());
    }
    notifyListeners();
  }

  Future facebookLogout() async {
    await FacebookAuth.i.logOut();
    _userData = null;
    FirebaseAuth.instance.signOut();
    print(_userData);
  }
}