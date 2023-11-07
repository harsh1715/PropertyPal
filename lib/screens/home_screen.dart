import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );

    setState(() {
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue.shade900,
        title: Text("All Properties",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              logOut();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(Icons.exit_to_app,),
          )
        ],
      ),
      body: Text("All Properties Screen"),

    );
  }
}
