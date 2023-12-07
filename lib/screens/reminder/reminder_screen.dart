import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
class ReminderScreen extends StatefulWidget {
  ReminderScreen({Key? key});
  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}



class _ReminderScreenState extends State<ReminderScreen> {
  late List<String> propertyNames;
  late List<bool> isCheckedList;

  @override
  void initState() {
    super.initState();
    // Initialize lists in initState
    propertyNames = [];
    isCheckedList = [];
    _initializeLists();
  }

  void navigateToRemindersDetails() {}
  final userID = FirebaseAuth.instance.currentUser!.uid;

  // Helper method to initialize lists
  void _initializeLists() async {
    List<String> properties = await _fetchPropertiesAndApartments();
    setState(() {
      propertyNames = properties;
      isCheckedList = List.generate(properties.length, (index) => false);
    });
  }

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
                    "Unpayed",
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
                  _buildPropertyTab(),
                  _buildStatusTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the property tab
  Widget _buildPropertyTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Text(
        //     'Rent Paid?',
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 18,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        Expanded(
          child: ListView.builder(
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
                  Checkbox(
                    value: isCheckedList[index],
                    onChanged: (bool? value) {
                      setState(() {
                        isCheckedList[index] = value ?? false;
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
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
    try {
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

      List<String> combinedPropertyNames = [];

      for (QueryDocumentSnapshot apartmentDoc in apartmentsSnapshot.docs) {
        QuerySnapshot unitsSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('apartments')
            .doc(apartmentDoc.id)
            .collection('units')
            .get();

        List<String> propertyNamesFromApartments =
        unitsSnapshot.docs.map((doc) => doc['unitName'] as String).toList();

        combinedPropertyNames.addAll(propertyNamesFromApartments);
      }

      // Add properties outside the loop
      List<String> propertyNamesFromProperties =
      propertiesSnapshot.docs.map((doc) => doc['propertyName'] as String).toList();
      combinedPropertyNames.addAll(propertyNamesFromProperties);

      return combinedPropertyNames;
    } catch (e) {
      // Handle any potential errors (e.g., network issues, Firestore errors)
      print('Error fetching data: $e');
      return []; // Return an empty list in case of an error or no data
    }
  }
}
