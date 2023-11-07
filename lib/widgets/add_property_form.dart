import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propertypal/utils/appvalidator.dart';

class AddPropertyForm extends StatefulWidget {
  const AddPropertyForm({super.key});

  @override
  State<AddPropertyForm> createState() => _AddPropertyFormState();
}

class _AddPropertyFormState extends State<AddPropertyForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  var isLoader = false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        isLoader = true;
      });

      // var data = {
      //   "email": _emailController.text,
      //   "password": _passwordController.text,
      // };
      //
      // await authService.login(data, context);

      setState(() {
        isLoader = false;
      });
    }
  }



  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime currentDate = DateTime.now();
    final DateTime lastDate = currentDate.add(Duration(days: 30)); // Adjust this to your desired timeline

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _getFormattedTimeline() {
    if (_startDate != null && _endDate != null) {
      final startDateString = DateFormat.yMMMd().format(_startDate!);
      final endDateString = DateFormat.yMMMd().format(_endDate!);
      return '$startDateString - $endDateString';
    } else {
      return 'Select Timeline';
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
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Property Name'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Property Address'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s name'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Phone number'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Email'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  decoration: InputDecoration(
                      labelText: 'Tenant\'s Rent'
                  ),
                ),
                TextFormField(
                  validator: appValidator.isEmptyCheck,
                  onTap: () {
                    _selectDate(context, true);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Timeline',
                  ),
                  controller: TextEditingController(text: _getFormattedTimeline()),
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: (){
                      if (isLoader == false){
                        _submitForm();
                      }
                    },
                    child:
                    isLoader ? Center(child: CircularProgressIndicator()):
                    Text("Add Property")
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
