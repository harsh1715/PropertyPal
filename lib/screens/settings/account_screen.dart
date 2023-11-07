import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key});

  @override
  State<AccountScreen> createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: _user != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildListTile("Change Password", () {
          }),
          buildListTile("Delete Account", () {
          }),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildListTile(String title, VoidCallback onTap) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          onTap: onTap,
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(
          color: Colors.grey.shade500,
          height: 0,
          thickness: 1,
        ),
      ],
    );
  }
}
