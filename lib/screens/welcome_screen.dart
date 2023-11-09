import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/add_property_form.dart';
import 'login_screens.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key});

  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    size: 80, // Increase the size of the icon
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: 'Welcome\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30, // Increase the font size of "Welcome"
                      ),
                    ),
                    TextSpan(
                      text:
                      'PropertyPal helps you to become an even better landlord. Hopefully this is the beginning of a beautiful friendship.\n\n'
                    ),
                    TextSpan(
                      text:
                          'Track tenant payments\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Log rent payments, share payment receipts with a singletap. Keep track of tenant balance and payment history.\n\n'
                    ),
                    TextSpan(
                      text:
                          "Tidy your Finances\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Track and categorize expenses easily, keep receipt photos. Get instant reports and data for tax time.\n\n'
                    ),
                    TextSpan(
                      text:
                      "Don't miss important dates\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                      'Reminders for late rent payments, expenses due, upcoming lease renewals, and maintenance/safety checks.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add some space between text and the button
              ElevatedButton(
                onPressed: () {
                  // Add functionality here for the button
                  // For example, to navigate to a new screen for property creation
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPropertyForm(),
                    ),
                  );
                },
                child: Text('Create a Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


