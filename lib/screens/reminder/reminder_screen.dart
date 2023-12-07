import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../login_screens.dart';
import 'details/property_details.dart';

class ReminderScreen extends StatefulWidget {
  ReminderScreen({Key? key});
  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  var isLogoutLoading = false;
  List<String> propertyNames = [];

  void navigateToRemindersDetails() {}

  final userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminders", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.black),
              ),
              tabs: [
                Tab(
                  child: Text(
                    "by Property",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "by Status",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FutureBuilder<List<String>>(
                    future: _fetchPropertiesAndApartments(),
                    builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      // Process the data from the snapshot
                      List<String> propertyNames = snapshot.data!;

                      return ListView.builder(
                        itemCount: propertyNames.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text(
                                        propertyNames[index],
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  _buildStatusTab()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatusTab() {
    // Get the current month
    String currentMonth = DateFormat('MMMM').format(DateTime.now());

    return ListView.builder(
      itemCount: 5, // Adjust the itemCount based on your data or requirements
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200, // Customize the color as needed
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      '$currentMonth Item $index', // Include the current month
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Future<List<String>> _fetchPropertiesAndApartments() async {
    QuerySnapshot propertiesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('properties')
        .get();

    QuerySnapshot apartmentsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('apartments')
        .get();

    List<String> propertyNamesFromProperties =
    propertiesSnapshot.docs.map((doc) => doc['propertyName'] as String).toList();
    List<String> propertyNamesFromApartments =
    apartmentsSnapshot.docs.map((doc) => doc['propertyName'] as String).toList();

    List<String> combinedPropertyNames =
    Set<String>.from([...propertyNamesFromProperties, ...propertyNamesFromApartments]).toList();

    return combinedPropertyNames;
  }
}