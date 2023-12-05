// import 'package:flutter/material.dart';
//
//
// class DetailsTab extends StatefulWidget {
//   final Map<String, dynamic> property;
//
//   const DetailsTab({Key? key, required this.property}) : super(key: key);
//
//   @override
//   _DetailsTabState createState() => _DetailsTabState();
// }
//
// class _DetailsTabState extends State<DetailsTab> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black),
//       ),
//       child: Column(
//         children: [
//           // Property Name
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade200,
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         widget.property['tenantName'],
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Phone",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         widget.property['tenantPhone'],
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Email Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Email",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         widget.property['tenantEmail'],
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Rental Fees Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade200,
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Rental Fees",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade200,
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         "Monthly",
//                         style: TextStyle(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Rent Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Rent",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         "\$${widget.property['tenantRent']}",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Rental Invoices & Payments Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade200,
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Rental Invoices & Payments",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Payment Due Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Payment Due",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         "5 days from invoice",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Deposit Paid Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Deposit Paid",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         "\$250",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           // Initial Balance Section
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 16),
//                       child: Text(
//                         "Initial Balance",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border(
//                       top: BorderSide(color: Colors.grey),
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 16),
//                       child: Text(
//                         "\$0",
//                         style: TextStyle(
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../home_screen.dart';

class DetailsTab extends StatefulWidget {
  final Map<String, dynamic> property;

  const DetailsTab({Key? key, required this.property}) : super(key: key);

  @override
  _DetailsTabState createState() => _DetailsTabState();
}

class _DetailsTabState extends State<DetailsTab> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late String? userId;
  final userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    userId = userID;
    _nameController = TextEditingController(text: widget.property['tenantName']);
    _phoneController = TextEditingController(text: widget.property['tenantPhone']);
    _emailController = TextEditingController(text: widget.property['tenantEmail']);
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _propertiesStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('properties')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: _propertiesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No data available');
          }

          DocumentSnapshot propertyDocument = snapshot.data!.docs.first;
          Map<String, dynamic> propertyData = propertyDocument.data() as Map<String, dynamic>;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
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
                              widget.property['tenantName'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Phone",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              widget.property['tenantPhone'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Email Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              widget.property['tenantEmail'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Rental Fees Section
                Row(
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
                              "Rental Fees",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              "Monthly",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Rent Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Rent",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              "\$${widget.property['tenantRent']}",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Rental Invoices & Payments Section
                Row(
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
                              "Rental Invoices & Payments",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Payment Due Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Payment Due",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              "5 days from invoice",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Deposit Paid",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              "\$250",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Initial Balance",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Text(
                              "\$0",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Edit button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showEditDialog(context);
                      },
                      child: Text("Edit Details"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Future<void> _showEditDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Details'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _updateFirestore();
                });
                //Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _updateFirestore() {
    var collection = " ";
    if (widget.property['propertyId'].contains('property')){
      collection = "properties";
    }
    else if(widget.property['propertyId'].contains('apartment')){
      collection = "apartments";
    }
    FirebaseFirestore.instance.collection('users').doc(userId).collection(collection).doc(widget.property['propertyId']).update({
      'tenantName': _nameController.text,
      'tenantPhone': _phoneController.text,
      'tenantEmail': _emailController.text,
    }).then((_) {
      print("Firestore update successful");
    }).catchError((error) {
      // Handle errors here
      print("Error updating Firestore: $error");
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
