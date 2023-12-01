import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:propertypal/screens/properties/house.dart';
import 'package:propertypal/screens/welcome_screen.dart';
import '../widgets/add_property_form.dart';
import 'login_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});
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

  final userID = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Properties",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPropertyForm()));
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(
              Icons.add_circle_outline,
            ),
          )
        ],
      ),
      body: HouseWidget(userId: userID)
    );
  }
}

class HouseWidget extends StatelessWidget {
  HouseWidget({
    super.key,
    required this.userId,
  });

  final String? userId;

  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
    FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Houses(
          userId: userId,
        );
      },
    );
  }
}


