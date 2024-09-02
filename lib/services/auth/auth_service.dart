import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
// import 'package:quickalert/quickalert.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signinWithEmailandPassword(BuildContext context,
      {required String email, required String password}) async {
    try {
      // user sign in
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // savve user info if it doesn't exist
      _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
      //  QuickAlert.show(
      //     context: context, type: QuickAlertType.error, text: e.message);
    }
  }

  //signup
  Future<UserCredential> signupWithEmailandPassword(BuildContext context,
      {required String email, required String password}) async {
    try {
      // create user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // savve user info in separate doc
      _firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'uid': userCredential.user!.uid, 'email': email});

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception('while signup ${e.message}');
      // QuickAlert.show(
      //     context: context, type: QuickAlertType.error, text: e.message);
    }
  }

  //sigout
  Future<void> signout() async {
    return await _auth.signOut();
  }
}
