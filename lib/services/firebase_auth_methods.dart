import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/login_screen.dart';
import 'package:flutter_application_1/utils/custom_snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  //SIGN UP WITH EMAIL
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: use_build_context_synchronously
      showToastBar(
          context: context,
          message: 'Account Created Successfully',
          onSucess: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          });
    } on FirebaseAuthException catch (e) {
      showToastBar(context: context, message: e.message!, onSucess: () {});
    }
  }

  //SIGN IN WITH EMAIL
  Future<void> signInWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      if (_auth.currentUser != null) {
        // ignore: use_build_context_synchronously
        showToastBar(
            context: context,
            message: 'Login Successful',
            onSucess: () {
              // Navigator.pushNamed(context, LoginScreen.routeName);
            });
      }
    } on FirebaseAuthException catch (e) {
      showToastBar(context: context, message: e.message!, onSucess: () {});
    }
  }

  //SIGN IN WITH GOOGLE
  Future<void> signInWithGoogle({
    required BuildContext context,
  }) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        //create the credentials
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          // ignore: use_build_context_synchronously
          showToastBar(
              context: context,
              message: 'Login Successful',
              onSucess: () {
                // TODO: Navigator.pushNamed(context, HomePage.routeName);
              });
        }
        // ignore: use_build_context_synchronously
      }
    } on FirebaseAuthException catch (e) {
      showToastBar(context: context, message: e.message!, onSucess: () {});
    }
  }
}
