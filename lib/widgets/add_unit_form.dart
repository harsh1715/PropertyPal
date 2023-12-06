import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:propertypal/utils/appvalidator.dart';
import '../google_maps_api/location_search_screen.dart';
import '../screens/notification/notification.dart';
import '../services/db.dart';
import 'dart:async';


class AddUnitForm extends StatefulWidget {
  final String propertyId;

  const AddUnitForm({super.key, required this.propertyId,});


  @override
  State<AddUnitForm> createState() => _AddUnitFormState();
}

class _AddUnitFormState extends State<AddUnitForm> {
  final _tenantName = TextEditingController();
  final _tenantPhone = TextEditingController();
  final _tenantEmail = TextEditingController();
  final _tenantRent = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final FocusNode _propertyAddressFocus = FocusNode();


  final _notifications = Notifications();
  var db = Db();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? _selectedDuration;

  var isLoader = false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        isLoader = true;
      });

      var data = {
        'tenantName': _tenantName.text,
        'tenantPhone': _tenantPhone.text,
        'tenantEmail': _tenantEmail.text,
        'tenantRent': _tenantRent.text,
        'startDate': _startDateController.text,
        'endDate': _calculateEndDate(),
      };
      await db.addUnit(widget.propertyId, data);
      setState(() {
        isLoader = false;
      });
      Navigator.pop(context);
    }
  }

  DateTime? _startDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate = DateTime(2040, 12, 31);

    DateTime initialDate = currentDate;


    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked;
        _startDateController.text = DateFormat.yMMMd().format(picked);
      });
    }
  }

  Future<void> _selectDuration(BuildContext context) async {
    final int? selected = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Duration (Months)'),
          content: DropdownButton<int>(
            items: List.generate(
              12,
                  (index) => DropdownMenuItem<int>(
                value: index + 1,
                child: Text((index + 1).toString()),
              ),
            ),
            onChanged: (value) {
              Navigator.pop(context, value);
            },
            value: _selectedDuration,
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedDuration = selected;
      });
    }
  }

  String _calculateEndDate() {
    if (_startDate != null && _selectedDuration != null) {
      final daysInMonth = 30.44;
      final endDate = _startDate!.add(Duration(days: (_selectedDuration! * daysInMonth).round()));
      return DateFormat.yMMMd().format(endDate);
    } else {
      return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    _notifications.init();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Apartment Unit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                TextFormField(
                  controller: _tenantName,
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s name'
                  ),
                ),
                TextFormField(
                  controller: _tenantPhone,
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Phone number'
                  ),
                ),
                TextFormField(
                  controller: _tenantEmail,
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Email'
                  ),
                ),
                TextFormField(
                  controller: _tenantRent,
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Rent'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  onTap: () {
                    _selectDate(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                  ),
                  controller: _startDateController,
                ),
                TextFormField(
                  validator: (value) {
                    if (_selectedDuration == null) {
                      return 'Select duration';
                    }
                    return null;
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Duration (Months)',
                  ),
                  onTap: () {
                    _selectDuration(context);
                  },
                  controller: TextEditingController(
                    text: _selectedDuration != null
                        ? _selectedDuration.toString()
                        : '',
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: (){
                      //isLoader ? print("Loading") : _submitForm();
                      if (isLoader == false){
                        _notificationNow();
                        _notificationLater();
                        _submitForm();
                      }
                    },
                    child:
                    isLoader ? Center(child: CircularProgressIndicator()):
                    Text("Add Apartment Unit")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _notificationNow() async{
    _notifications.sendNotificationNow("${_tenantName.text}\'s Apartment Added",
        "We will notify you 5 days before the end date.", _startDateController.text);
  }

  void _notificationLater() async {
    final daysInMonth = 30.44;
    String currentMonth = DateFormat('MMMM').format(DateTime.now());
    for (int i = 1; i <= _selectedDuration!; i++) {
      int delayDays = (daysInMonth).round();
      await Future.delayed(Duration(days: delayDays-5));
      _notifications.sendNotificationNow("Payment Update","${_tenantName.text}'s payment is due in 5 days for $currentMonth","" );
    }
  }
}