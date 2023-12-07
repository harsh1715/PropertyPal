import 'package:flutter/material.dart';
import 'package:propertypal/screens/properties/unitdetails.dart';
import '../DetailsTab.dart';
import '../BalanceTab.dart';
import '../InvoicesTab.dart';
import '../PaymentsTab.dart';

import '../../../widgets/navbar.dart';

class UnitDetails extends StatelessWidget {

  //final Map<String, dynamic> propertyInfo;

  final String userId; // Add the user ID if needed
  final String apartmentId; // Add the apartment ID if needed
  final String unitId;

  const UnitDetails(
      {
        Key? key,
        // required this.propertyInfo,
        required this.userId,
        required this.apartmentId,
        required this.unitId,
      }
  ) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unit Details"),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.black),
              ),
              tabs: [
                Tab(text: 'Details'),
                Tab(text: 'Balance'),
                Tab(text: 'Invoices'),
                Tab(text: 'Payments'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UnitDetailsPage(userId: userId, apartmentId: apartmentId, unitId: unitId),
                  BalanceTab(),
                  InvoicesTab(),
                  PaymentsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: NavBar(
      //   selectedIndex: 0,
      //   onDestinationSelected: (int value) {},
      // ),
    );
  }
}
