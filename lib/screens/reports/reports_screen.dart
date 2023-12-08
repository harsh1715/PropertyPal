import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedPropertyId;
  String? totalIncomeDisplay = '0';
  List<String> propertyNames = [];
  List<String> propertyids = [];


  void retrieveUserProperties() {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(userId);

        userRef.get().then((DocumentSnapshot userSnapshot) {
          if (userSnapshot.exists) {
            CollectionReference propertiesCollection = userSnapshot.reference.collection('properties');

            propertiesCollection.get().then((QuerySnapshot propertiesSnapshot) {
              List<String> id = [];
              List<String> names = [];

              propertiesSnapshot.docs.forEach((QueryDocumentSnapshot propertySnapshot) {
                String propertyid = propertySnapshot.id;

                var propertyName = propertySnapshot.get('propertyName');

                id.add(propertyid);
                names.add(propertyName);
              });

              setState(() {
                propertyids = id;
                propertyNames = names; // Update propertyNames with fetched names
              });

              openPropertyDropdown();
            });
          } else {
            print("User document does not exist");
          }
        });
      } else {
        print("No user signed in");
      }
    } catch (e) {
      print(e.toString());
    }
  }


  void openPropertyDropdown() {
    if (propertyNames.isNotEmpty) {
      FocusScope.of(context).requestFocus(FocusNode()); // Close keyboard if open
      showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(0, 0, 0, 0),
        items: propertyids.map((propertyid) {
          // Find the index of the property ID in the propertyids list
          int index = propertyids.indexOf(propertyid);
          // Use the corresponding property name
          String propertyName = propertyNames[index];
          return PopupMenuItem<String>(
            value: propertyid,
            child: Text('$propertyid - $propertyName'), // Display property name
          );
        }).toList(),
      ).then((value) {
        setState(() {
          selectedPropertyId = value;
          fetchIncomeForProperty();
        });
      });
    } else {
      retrieveUserProperties(); // Fetch properties if the list is empty
    }
  }
  void fetchIncomeForProperty() {
    if (selectedPropertyId != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userId = user.uid;

          DocumentReference propertyRef = FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection('properties')
              .doc(selectedPropertyId!);

          propertyRef.get().then((DocumentSnapshot propertySnapshot) {
            if (propertySnapshot.exists) {
              var propertyData = propertySnapshot.data() as Map<String, dynamic>;
              var tenantRent = propertyData['tenantRent'];

              print('Tenant Rent: $tenantRent');

              setState(() {
                totalIncomeDisplay = tenantRent.toString();
              });
            } else {
              print("Property document does not exist");
            }
          });
        } else {
          print("No user signed in");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: openPropertyDropdown,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Select Property',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedPropertyId ?? 'Select Property'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Income",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text("\$$totalIncomeDisplay"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Text("Revenue"),
                  SizedBox(width: 8),
                  Text("Total Rent Collected"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}