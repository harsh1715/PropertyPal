import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Db{

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(data, context) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    await users
      .doc(userID)
      .set(data)
      .then((value) => print("User Added poeroperpeorepoarkeopajefoajfowefawefnwefnoefnweofnawoefnnafnefaonfoenfoanf ashwin"))
      .catchError((error){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Sign up Failed"),
                content: Text(error.toString()),
              );
            }
        );
      });
  }

}