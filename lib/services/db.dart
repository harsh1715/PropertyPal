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

    DocumentReference newPropertyRef = additionalCollection.doc(newPropertyName);

    CollectionReference monthlyCollection = newPropertyRef.collection('monthlyDetails');

    // String januaryDocumentName = 'January';
    // Map<String, dynamic> januaryData = {
    //   'rent': "",
    //   'paid': false,
    // };
    //
    // String februaryDocumentName = 'February';
    // Map<String, dynamic> februaryData = {
    //   'rent': "",
    //   'paid': false,
    // };

    Map<String, dynamic> createMonthlyData() {
      const months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];

      Map<String, dynamic> monthlyData = {};

      for (String month in months) {
        monthlyData[month] = {
          'rent': "",
          'paid': false,
        };
      }

      return monthlyData;
    }

    Map<String, dynamic> monthlyData = createMonthlyData();

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

    monthlyData.forEach((month, data) {
      monthlyCollection.doc(month).set(data);
    });

    // await monthlyCollection.doc(januaryDocumentName).set(januaryData);
    // await monthlyCollection.doc(februaryDocumentName).set(februaryData);

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