import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propertypal/utils/appvalidator.dart';
import '../google_maps_api/location_search_screen.dart';
import '../services/db.dart';
import 'dart:async';
import 'add_unit_form.dart';


class AddApartmentForm extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const AddApartmentForm({Key? key, this.initialData}) : super(key: key);

  @override
  State<AddApartmentForm> createState() => _AddApartmentFormState();
}

class _AddApartmentFormState extends State<AddApartmentForm> {
  final _propertyName = TextEditingController();
  final _propertyAddress = TextEditingController();
  final FocusNode _propertyAddressFocus = FocusNode();

  var db = Db();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoader = false;
  var appValidator = AppValidator();
  String _propertyId = '';
  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _propertyName.text = widget.initialData!['propertyName'];
      _propertyAddress.text = widget.initialData!['propertyAddress'];
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        isLoader = true;
      });
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      final userID = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef = users.doc(userID);
      CollectionReference additionalCollection = userDocRef.collection('apartments');

      QuerySnapshot querySnapshot = await additionalCollection.get();
      int propertyCount = querySnapshot.docs.length;

      _propertyId = 'apartment${propertyCount + 1}';
      print("$_propertyId + $propertyCount");
      var data = {
        'propertyName': _propertyName.text,
        'propertyAddress': _propertyAddress.text,
      };
      await db.addApartment(data);
      setState(() {
        isLoader = false;
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddUnitForm(propertyId: _propertyId),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _propertyName,
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Property Name'
                  ),
                ),
                TextFormField(
                  controller: _propertyAddress,
                  validator: appValidator.isEmptyCheck,
                  focusNode: _propertyAddressFocus,
                  onTap: () async {
                    _propertyAddressFocus.unfocus();

                    final selectedLocation = await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: SearchLocationScreen(
                            onLocationSelected: (selectedLocation) {
                              _propertyAddress.text = selectedLocation;
                            },
                          ),
                        );
                      },
                    );
                    if (selectedLocation != null) {
                      setState(() {
                        _propertyAddress.text = selectedLocation;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Property Address',
                  ),
                ),

                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: (){
                      //isLoader ? print("Loading") : _submitForm();
                      if (isLoader == false){
                        _submitForm();
                      }
                    },
                    child:
                    isLoader ? Center(child: CircularProgressIndicator()):
                    Text("Add Apartment")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}