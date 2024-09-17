import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UnitPaymentsTab extends StatefulWidget {
  final Map<dynamic, dynamic> unitInfo;
  final String apartmentId;

  const UnitPaymentsTab({
    Key? key,
    required this.unitInfo,
    required this.apartmentId,
  }) : super(key: key);

  @override
  _UnitPaymentsTabState createState() => _UnitPaymentsTabState();
}

class _UnitPaymentsTabState extends State<UnitPaymentsTab> {
  Map<String, Map<String, dynamic>> monthlyRentDetails = {};

  @override
  void initState() {
    super.initState();
    _getBalanceText(widget.apartmentId, widget.unitInfo['unitId']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
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
                        _getCurrentYear(),
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
          Expanded(
            child: ListView.builder(
              itemCount: 12, // 12 months from January to December
              itemBuilder: (context, index) {
                String month = DateFormat('MMMM')
                    .format(DateTime(0, index + 1)); // Get the month name
                Map<String, dynamic>? rentData = monthlyRentDetails[month];

                bool isPaid = rentData?['paid'] ?? false;
                double? rentAmount;

                // Safely parse the rent value
                try {
                  rentAmount = rentData != null
                      ? double.parse(rentData['rent'] ?? '0.0')
                      : null;
                } catch (e) {
                  rentAmount = 0.0; // Fallback to 0.0 if parsing fails
                }

                return Row(
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
                              month, // Display the month name
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
                              rentData != null
                                  ? isPaid
                                      ? '\$${rentAmount?.toStringAsFixed(2)} (Paid)' // Rent is paid
                                      : '\$${rentAmount?.toStringAsFixed(2)} (Not paid)' // Rent is not paid
                                  : 'No rent data', // No data for this month
                              style: TextStyle(
                                color: isPaid
                                    ? Colors.green
                                    : Colors
                                        .red, // Change color based on payment status
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getBalanceText(String apartmentId, String unitId) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    try {
      // Fetching all monthly details
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('apartments')
          .doc(apartmentId)
          .collection('units')
          .doc(unitId)
          .collection('monthlyDetails')
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          monthlyRentDetails.clear(); // Clear previous data
          for (var doc in snapshot.docs) {
            final month = doc
                .id; // Assume the document ID is the month name (e.g., "January", "February")
            final bool isPaid = doc.data()['paid'] ?? false;
            final String rentAmount = doc.data()['rent'] ??
                '0.0'; // Use '0.0' as default if 'rent' field is missing or invalid

            monthlyRentDetails[month] = {
              'paid': isPaid,
              'rent': rentAmount,
            };
          }
        });
      }
    } catch (error) {
      print('Error getting rent details: $error');
    }
  }

  String _getCurrentYear() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy').format(now); // Display only the year
  }
}
