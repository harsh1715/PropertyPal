import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Db{

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(data, context) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocRef = users.doc(userID);
    await userDocRef
      .set(data)
      .then((value) => print("User Added"))
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

  Future<void> addProperty(data) async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocRef = users.doc(userID);
    CollectionReference additionalCollection = userDocRef.collection('properties');

    QuerySnapshot querySnapshot = await additionalCollection.get();
    int propertyCount = querySnapshot.docs.length;


    String newPropertyName = 'property${propertyCount + 1}';

    Map<String, dynamic> newData = {
      ...data,
      'propertyId': newPropertyName,
    };

    await additionalCollection
        .doc(newPropertyName)
        .set(newData)
        .then((value) => print("Data Added to Additional Collection"))
        .catchError((error) {
              print("Failed");
      });
  }

  Future<void> addApartment(data) async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocRef = users.doc(userID);
    CollectionReference additionalCollection = userDocRef.collection('apartments');

    QuerySnapshot querySnapshot = await additionalCollection.get();
    int propertyCount = querySnapshot.docs.length;


    String newPropertyName = 'apartment${propertyCount + 1}';

    Map<String, dynamic> newData = {
      ...data,
      'propertyId': newPropertyName,
    };

    await additionalCollection
        .doc(newPropertyName)
        .set(newData)
        .then((value) => print("Data Added to Additional Collection"))
        .catchError((error) {
      print("Failed");
    });
  }


  Future<void> editProperty(String propertyId, Map<String, dynamic> newData) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference propertyDocRef = users.doc(userID).collection('properties').doc(propertyId);

    await propertyDocRef
        .update(newData)
        .then((value) => print("Property Updated"))
        .catchError((error) {
      print("Failed to update property: $error");
    });
  }

}