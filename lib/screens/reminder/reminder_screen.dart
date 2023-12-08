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
  late List<String> propertyIds;
  late List<String> apartmentIds;
  late List<String> unitIds;
  late List<String> combinedIds;
  late List<bool> isCheckedList;
  late String selectedMonth;
  Map<String, bool> isMonthExpanded = {};
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  @override
  void initState() {
    super.initState();
    propertyNames = [];
    propertyIds = [];
    apartmentIds = [];
    combinedIds = [];
    unitIds = [];
    isCheckedList = [];
    _initializeLists();
  }

  void navigateToRemindersDetails() {}
  final userID = FirebaseAuth.instance.currentUser!.uid;

  void _initializeLists() async {
    PropertyData propertyData = await _fetchPropertiesAndApartments();
    propertyNames = propertyData.propertyNames;
    propertyIds = propertyData.propertyIds;
    apartmentIds = propertyData.apartmentIds;
    unitIds = propertyData.unitIds;
    combinedIds.addAll(propertyData.propertyIds);
    combinedIds.addAll(propertyData.apartmentIds);
    int lengthDifference = combinedIds.length - unitIds.length;
    if (lengthDifference > 0) {
      unitIds.insertAll(0, List.filled(lengthDifference, ''));
    }


    setState(() {
      propertyNames = propertyNames;
      propertyIds = propertyIds;
      apartmentIds = apartmentIds;
      unitIds = unitIds;
      combinedIds = combinedIds;
      isCheckedList = List.generate(propertyNames.length, (index) => false);
      for (String month in months) { isMonthExpanded[month] = false;}

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
                    "Unpaid",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Paid",
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

  Widget _buildPropertyTab() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: propertyNames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Row(
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
                      update(combinedIds[index], unitIds[index], isCheckedList[index]);
                      print("property Names: $propertyNames");
                      print("property Ids: $propertyIds");
                      print("apartment Ids: $apartmentIds");
                      print("combinedIds Ids: $combinedIds");
                      print("unitIds Ids: $unitIds");
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}

  String _getCurrentMonth() {
    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMMM').format(now);
    return currentMonth;
  }

  Widget _buildStatusTab() {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        elevation: 1,
        expandedHeaderPadding: EdgeInsets.all(0),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            // Toggle the expansion state of the panel
            isMonthExpanded[months[index]] = !isExpanded;
          });
        },
        children: months.map<ExpansionPanel>((String month) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(month),
              );
            },
            body: ListTile(
              title: Text('Details for $month'), // Add your details here
            ),
            isExpanded: isMonthExpanded[month] ?? false,
          );
        }).toList(),
      ),
    );
  }

  Future<void> update(String combinedIds, String unitId, bool value) async {
    String documentField = _getCurrentMonth();
    String tenantRent = '';
    try {
      if (combinedIds.contains("property")) {
        var documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('properties')
            .doc(combinedIds);

        var snapshot = await documentReference.get();
        if (snapshot.exists) {
          if (snapshot.data()?['tenantRent'] != null) {
            tenantRent = snapshot.data()?['tenantRent'];
            print('Tenant Rent: $tenantRent');
          } else {
            print('Tenant Rent does not exist in the document.');
          }
        }
        tenantRent = value ? tenantRent : '';
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('properties')
            .doc(combinedIds)
            .collection('monthlyDetails')
            .doc(documentField)
            .update({'paid': value, 'rent': tenantRent});
      }

      else {
        var documentReference = FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('apartments')
            .doc(combinedIds)
            .collection("units")
            .doc(unitId);

        var snapshot = await documentReference.get();
        if (snapshot.exists) {
          if (snapshot.data()?['tenantRent'] != null) {
            tenantRent = snapshot.data()?['tenantRent'];
            print('Tenant Rent: $tenantRent');
          } else {
            print('Tenant Rent does not exist in the document.');
          }
        }
        tenantRent = value ? tenantRent : '';
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('apartments')
            .doc(combinedIds)
            .collection('units')
            .doc(unitId)
            .collection('monthlyDetails')
            .doc(documentField)
            .update({'paid': value, 'rent': tenantRent});
      }
    } catch (e) {
      print('Error updating Firebase: $e');
    }
    print('PropertyId: $combinedIds, isChecked: $value');
  }

}

Future<PropertyData> _fetchPropertiesAndApartments() async {
  final userID = FirebaseAuth.instance.currentUser!.uid;

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

    List<String> propertyNames = [];
    List<String> propertyIds = [];
    List<String> unitIds = [];
    List<String> apartmentIds = [];

    List<String> propertyNamesFromProperties =
    propertiesSnapshot.docs.map((doc) => doc['propertyName'] as String).toList();
    propertyNames.addAll(propertyNamesFromProperties);

    List<String> propertyIDFromProperties =
    propertiesSnapshot.docs.map((doc) => doc['propertyId'] as String).toList();
    propertyIds.addAll(propertyIDFromProperties);

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
      propertyNames.addAll(propertyNamesFromApartments);

      List<String> propertyIDFromApartments =
      unitsSnapshot.docs.map((doc) => doc['unitId'] as String).toList();
      unitIds.addAll(propertyIDFromApartments);

      // Add apartmentId and unitId to the respective lists
      apartmentIds.addAll(List.generate(propertyIDFromApartments.length, (index) => apartmentDoc.id));
    }

    // Now you can access propertyIds, propertyNames, unitIds, and apartmentIds outside this function

    return PropertyData(
      propertyNames: propertyNames,
      propertyIds: propertyIds,
      unitIds: unitIds,
      apartmentIds: apartmentIds,
    );
  } catch (e) {
    print('Error fetching data: $e');
    return PropertyData(
      propertyNames: [],
      propertyIds: [],
      unitIds: [],
      apartmentIds: [],
    );
  }
}

class PropertyData {
  List<String> propertyNames;
  List<String> propertyIds;
  List<String> unitIds;
  List<String> apartmentIds;
  PropertyData({
    required this.propertyNames,
    required this.propertyIds,
    required this.unitIds,
    required this.apartmentIds,
  });
}


