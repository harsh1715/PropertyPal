// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'login_screens.dart';
//
// class ReportScreenNBO extends StatefulWidget {
//   const ReportScreenNBO({super.key});
//
//   @override
//   State<ReportScreenNBO> createState() => _ReportScreenState();
// }
//
// class _ReportScreenState extends State<ReportScreenNBO> {
//   var isLogoutLoading = false;
//   logOut() async {
//     setState(() {
//       isLogoutLoading = true;
//     });
//     await FirebaseAuth.instance.signOut();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => Login()),
//     );
//
//     setState(() {
//       isLogoutLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Report"),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           ListTile(
//             title: const Text("This Month"),
//             subtitle: const Text("September 2021"),
//           ),
//           ListTile(
//             title: const Text("Total Income"),
//             subtitle: const Text("\$10,000"),
//           ),
//           ListTile(
//             title: const Text("Revenue"),
//             subtitle: const Text("\$8,000"),
//           ),
//           ListTile(
//             title: const Text("Expenses"),
//             subtitle: const Text("\$2,000"),
//           ),
//           ListTile(
//             title: const Text("Total Revenue Details"),
//             subtitle: const Text("James"),
//           ),
//         ],
//       ),
//     );
//   }
// }