import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final GlobalKey _apartmentFieldKey = GlobalKey();
  final GlobalKey _propertyFieldKey = GlobalKey();

  String? selectedPropertyId;
  String? selectedApartmentId;
  String? selectedUnitId;
  String? totalPropertyIncomeDisplay = '0';
  String? totalUnitIncomeDisplay = '0';
  List<String> propertyNames = [];
  List<String> propertyIds = [];
  List<String> apartmentNames = [];
  List<String> apartmentIds = [];
  List<String> unitNames = [];
  List<String> unitIds = [];

  @override
  void initState() {
    super.initState();
    retrieveUserProperties();
    _retrieveUserApartments(); // Ensure apartments are initialized on startup
  }

  // Step 1: Retrieve the list of properties
  void retrieveUserProperties() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(userId);

        DocumentSnapshot userSnapshot = await userRef.get();
        if (userSnapshot.exists) {
          CollectionReference propertiesCollection = userSnapshot.reference.collection('properties');

          QuerySnapshot propertiesSnapshot = await propertiesCollection.get();
          List<String> id = [];
          List<String> names = [];

          propertiesSnapshot.docs.forEach((QueryDocumentSnapshot propertySnapshot) {
            String propertyId = propertySnapshot.id;
            var propertyName = propertySnapshot.get('propertyName');
            id.add(propertyId);
            names.add(propertyName);
          });

          setState(() {
            propertyIds = id;
            propertyNames = names;
          });

          print("Properties fetched: ${propertyNames.length}");
        } else {
          print("User document does not exist");
        }
      } else {
        print("No user signed in");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Step 2: Retrieve apartments and check if they are properly fetched
  void _retrieveUserApartments() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(userId);

        DocumentSnapshot userSnapshot = await userRef.get();
        if (userSnapshot.exists) {
          CollectionReference apartmentsCollection = userSnapshot.reference.collection('apartments');

          QuerySnapshot apartmentsSnapshot = await apartmentsCollection.get();
          List<String> id = [];
          List<String> names = [];

          apartmentsSnapshot.docs.forEach((QueryDocumentSnapshot apartmentSnapshot) {
            String apartmentId = apartmentSnapshot.id;
            var apartmentName = apartmentSnapshot.get('propertyName');
            id.add(apartmentId);
            names.add(apartmentName);
          });

          setState(() {
            apartmentIds = id;
            apartmentNames = names;
          });

          print("Apartments fetched: ${apartmentNames.length}");
        } else {
          print("User document does not exist");
        }
      } else {
        print("No user signed in");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Step 3: Retrieve the list of units based on the selected apartment
  void _retrieveUnitsForApartment() async {
    if (selectedApartmentId != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userId = user.uid;

          DocumentReference apartmentRef = FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection('apartments')
              .doc(selectedApartmentId!);

          CollectionReference unitsCollection = apartmentRef.collection('units');
          QuerySnapshot unitsSnapshot = await unitsCollection.get();
          List<String> unitIdList = [];
          List<String> unitNameList = [];

          unitsSnapshot.docs.forEach((QueryDocumentSnapshot unitSnapshot) {
            String unitId = unitSnapshot.id;
            var unitName = unitSnapshot.get('unitName');
            unitIdList.add(unitId);
            unitNameList.add(unitName);
          });

          setState(() {
            unitIds = unitIdList;
            unitNames = unitNameList;
          });

          print("Units fetched for apartment ${selectedApartmentId}: ${unitNames.length}");
        } else {
          print("No user signed in");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // Step 4: Fetch the income for the selected unit
  void _fetchIncomeForUnit() async {
    if (selectedUnitId != null) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userId = user.uid;

          DocumentReference unitRef = FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .collection('apartments')
              .doc(selectedApartmentId!)
              .collection('units')
              .doc(selectedUnitId!);

          DocumentSnapshot unitSnapshot = await unitRef.get();
          if (unitSnapshot.exists) {
            var unitData = unitSnapshot.data() as Map<String, dynamic>;
            var tenantRent = unitData['tenantRent'];

            setState(() {
              totalUnitIncomeDisplay = tenantRent.toString();
            });

            print("Income fetched for unit $selectedUnitId: $totalUnitIncomeDisplay");
          } else {
            print("Unit document does not exist");
          }
        } else {
          print("No user signed in");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // Step 5: Open the property dropdown
  void openPropertyDropdown() {
    if (propertyNames.isNotEmpty) {
      // Get the RenderBox of the widget associated with the GlobalKey
      final RenderBox renderBox = _propertyFieldKey.currentContext!.findRenderObject() as RenderBox;
      final Offset offset = renderBox.localToGlobal(Offset.zero);

      showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(
          offset.dx,                                 // X position (left)
          offset.dy + renderBox.size.height,         // Y position (top + height of the widget)
          offset.dx + renderBox.size.width,          // Width (right)
          0,                                         // Unused (bottom)
        ),
        items: propertyIds.map((propertyId) {
          int index = propertyIds.indexOf(propertyId);
          String propertyName = propertyNames[index];
          return PopupMenuItem<String>(
            value: propertyId,
            child: Text('$propertyId - $propertyName'),
          );
        }).toList(),
      ).then((value) {
        setState(() {
          selectedPropertyId = value;
          fetchIncomeForProperty();
        });
      });
    } else {
      retrieveUserProperties();
    }
  }

  // Step 6: Fetch income for the selected property
  void fetchIncomeForProperty() async {
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

          DocumentSnapshot propertySnapshot = await propertyRef.get();
          if (propertySnapshot.exists) {
            var propertyData = propertySnapshot.data() as Map<String, dynamic>;
            var tenantRent = propertyData['tenantRent'];

            setState(() {
              totalPropertyIncomeDisplay = tenantRent.toString();
            });

            print("Income fetched for property $selectedPropertyId: $totalPropertyIncomeDisplay");
          } else {
            print("Property document does not exist");
          }
        } else {
          print("No user signed in");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // Property Tab Widget
  Widget _buildPropertyTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            key: _propertyFieldKey,  // Use the key here for "Select Property"
            onTap: openPropertyDropdown,  // Trigger the dropdown when tapped
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
                  "Total Income for Property",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("\$$totalPropertyIncomeDisplay"),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Apartment Tab Widget
  Widget _buildApartmentTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // First Dropdown for selecting the apartment complex
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Apartment Complex',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            value: selectedApartmentId,
            items: apartmentIds.map((apartmentId) {
              int index = apartmentIds.indexOf(apartmentId);
              String apartmentName = apartmentNames[index];
              return DropdownMenuItem<String>(
                value: apartmentId,
                child: Text(apartmentName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedApartmentId = value;
                selectedUnitId = null;  // Reset the selected unit when the apartment complex is changed
                unitIds = [];  // Clear the list of units
                unitNames = [];  // Clear the unit names
                totalUnitIncomeDisplay = '0';  // Reset the income display for the unit
                _retrieveUnitsForApartment();  // Fetch the new units for the selected apartment complex
              });
            },
          ),

          const SizedBox(height: 20),

          // Second Dropdown for selecting the individual unit
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Unit',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            value: selectedUnitId,
            items: unitIds.map((unitId) {
              int index = unitIds.indexOf(unitId);
              String unitName = unitNames[index];
              return DropdownMenuItem<String>(
                value: unitId,
                child: Text(unitName),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedUnitId = value;
                _fetchIncomeForUnit(); // Fetch income for the selected unit
              });
            },
          ),
          const SizedBox(height: 20),

          // Display the income for the selected unit
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
                  "Total Income for Unit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text("\$$totalUnitIncomeDisplay"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reports", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.black),
              ),
              tabs: [
                Tab(
                  child: Text(
                    "Properties",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "Apartments",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPropertyTab(),
                  _buildApartmentTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
