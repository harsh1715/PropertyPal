// import 'package:flutter/material.dart';
//
// class ReportScreen extends StatelessWidget {
//   const ReportScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Report"),
//         centerTitle: true,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//
//         children: [
//           Container(
//             color: Colors.blue, // Color of the container
//             child: ListTile(
//               subtitle: Text("Property/Unit"),
//               title: Text("All Properties"),
//             ),
//           ),
//           _buildDivider(),
//           Container(
//             color: Colors.green, // Color of the container
//             child: ListTile(
//               title: const Text("This Month"),
//               subtitle: const Text("September 2021"),
//             ),
//           ),
//           Container(
//             color: Colors.orange, // Color of the container
//             child: ListTile(
//               title: const Text("Total Income"),
//               subtitle: const Text("\$10,000"),
//             ),
//           ),
//           Container(
//             color: Colors.purple, // Color of the container
//             child: ListTile(
//               title: const Text("Revenue"),
//               subtitle: Text("Total Rent Collected"),
//             ),
//           ),
//           Container(
//             color: Colors.yellow, // Color of the container
//             child: ListTile(
//               title: const Text("Expenses"),
//               subtitle: Text("Total Expenses Paid"),
//             ),
//           ),
//           Container(
//             color: Colors.red, // Color of the container
//             child: ListTile(
//               title: const Text("Total Revenue Details"),
//             ),
//           ),
//           Container(
//             color: Colors.teal, // Color of the container
//             child: ListTile(
//               title: const Text("James"),
//               subtitle: const Text(""),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// Widget _buildDivider() {
//   return Divider(
//     color: Colors.grey, // Color of the divider
//     thickness: 1, // Thickness of the divider
//   );
// }

// void retrieveUserProperties() {
//   try {
//     // Get the currently signed-in user
//     User? user = FirebaseAuth.instance.currentUser;
//
//     // Check if the user is signed in
//     if (user != null) {
//       // Get the user's ID
//       String userId = user.uid;
//
//       // Create a reference to the user's document in the "users" collection
//       DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(userId);
//
//       // Retrieve the user's document
//       userRef.get().then((DocumentSnapshot userSnapshot) {
//         if (userSnapshot.exists) {
//           // Retrieve the "properties" subcollection within the user's document
//           CollectionReference propertiesCollection = userSnapshot.reference.collection('properties');
//
//           // Retrieve all documents in the "properties" subcollection
//           propertiesCollection.get().then((QuerySnapshot propertiesSnapshot) {
//             // Loop through the documents and print their names
//             propertiesSnapshot.docs.forEach((QueryDocumentSnapshot propertySnapshot) {
//               String propertyName = propertySnapshot.id;
//               print(propertyName);
//             });
//           });
//         } else {
//           print("User document does not exist");
//         }
//       });
//     } else {
//       print("No user signed in");
//     }
//   } catch (e) {
//     // Handle error
//     print(e.toString());
//   }
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}
FirebaseFirestore firestore = FirebaseFirestore.instance;

class _ReportScreenState extends State<ReportScreen> {
  // List<String> propertyNames = [];

  // void propertyInfo(){
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   FirebaseFirestore.instance.collection("users").get().then((value) => {
  //     value.docs.forEach((result){
  //       print(result.data());
  //     })
  //   });
  // }



  void retrieveUserProperties() {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the user is signed in
      if (user != null) {
        // Get the user's ID
        String userId = user.uid;

        // Create a reference to the user's document in the "users" collection
        DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(userId);

        // Retrieve the user's document
        userRef.get().then((DocumentSnapshot userSnapshot) {
          if (userSnapshot.exists) {
            // Retrieve the "properties" subcollection within the user's document
            CollectionReference propertiesCollection = userSnapshot.reference.collection('properties');

            // Retrieve all documents in the "properties" subcollection
            propertiesCollection.get().then((QuerySnapshot propertiesSnapshot) {
              List<String> propertyNames = [];

              // Loop through the documents and add their names to the list
              propertiesSnapshot.docs.forEach((QueryDocumentSnapshot propertySnapshot) {
                String propertyName = propertySnapshot.id;
                propertyNames.add(propertyName);
              });

              // Display the list of property names and update the subtitle
              displayProperties(propertyNames);
            });
          } else {
            print("User document does not exist");
          }
        });
      } else {
        print("No user signed in");
      }
    } catch (e) {
      // Handle error
      print(e.toString());
    }
  }
  var titleText;
  void displayProperties(List<String> propertyNames) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Properties'),
          content: DropdownButton<String>(
            value: null, // Set the initial value here
            items: propertyNames.map((String propertyName) {
              return DropdownMenuItem<String>(
                value: propertyName,
                child: Text(propertyName),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // Handle the selected value here
              setState(() {
                titleText = newValue;
              });
              Navigator.of(context).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }


  String selectedPeriod = "This Month";
  List<String> periods = ["This Month", "Last Month", "Custom Date"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  titleText ?? "Select Property",
                  style: const TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  retrieveUserProperties();
                },
                child: const Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
          _buildDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Select Period"),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedPeriod,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedPeriod = newValue;
                    });
                  }
                },
                items: periods.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          _buildDivider(),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
            ),
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Income", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
                Text("\$10,000"),
              ],
            ),
          ),
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
          _buildDivider(),
          Container(
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Text("Expenses"),
                SizedBox(width: 8),
                Text("Total Expenses Paid"),
              ],
            ),
          ),
          _buildDivider(),
          Container(
            padding: const EdgeInsets.all(16),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
            ),
            alignment: Alignment.centerLeft,
            child:  const Text("Total Revenue Details",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("James", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,)),

                    Text("Rent payments, Address/ house", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12,)),
                    SizedBox(width: 8),
                    Text(""),
                  ],
                ),
              ],
            ),
          ),
          _buildDivider(),
        ],
      ),
    );
  }


  Widget _buildDivider() {
    return Container(
      padding: EdgeInsets.zero,
      child: const Divider(
        color: Colors.grey, // Color of the divider
        thickness: 1, // Thickness of the divider
      ),
    );
  }
}

