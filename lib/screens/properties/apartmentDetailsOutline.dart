import 'package:flutter/material.dart';
import 'package:propertypal/screens/properties/apartment_details.dart';



class ApartmentDetails extends StatelessWidget {

  final Map<String, dynamic> propertyInfo;

  const ApartmentDetails({Key? key, required this.propertyInfo}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(propertyInfo['propertyName']),
      ),
      body: ApartmentDetailsTab(property: propertyInfo)
    );
  }
}
