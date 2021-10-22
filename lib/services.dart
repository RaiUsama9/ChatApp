import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAuthe {
  FirebaseAuth _auth = FirebaseAuth.instance;

  late Stream streamQuery;
  late String user_exist;
  final databaseref = FirebaseDatabase.instance.reference();
  final _fireStore = FirebaseFirestore.instance.collection('User');
  Future SignupwithEmail(String email, String password) async {
    try {
      UserCredential user_credentail = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = user_credentail.user;

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future SigninwithEmail(String email, String password) async {
    try {
      UserCredential user_credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = user_credential.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future StoreData(String email, String password) async {
    return await _fireStore.doc().set({
      'Email': email,
      'Password': password,
    });
  }

  String fetch_data() {
    String? data = _auth.currentUser!.email;
    //print(data.toString());
    return data!;
  }

  Future<String> searchUser(String email) async {
    // final return_user = await _fireStore.doc(docID).get();
    final user = _fireStore.where('Email', isEqualTo: email);
    return user.toString();
  }

  Future addMessagetoRealTime(String message, String email) async {
    return await databaseref.push().set({
      'Message': message,
      'Email': email,
    });
  }

  Future msgtoSpecificUser(String message, String uid, String email) async {
    return await databaseref.child(uid).push().set({
      'Message': message,
      'Email': email,
    });
  }
}
