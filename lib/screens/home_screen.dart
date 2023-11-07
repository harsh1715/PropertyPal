// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'login_screens.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
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
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: Colors.blue.shade900,
//         title: Text("All Properties",style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             onPressed: (){
//               logOut();
//             },
//             icon: isLogoutLoading
//                 ? CircularProgressIndicator()
//                 : Icon(Icons.exit_to_app,),
//           )
//         ],
//       ),
//       body: Container(
//         width: double.infinity,
//         height: 210,
//         color: Colors.blue.shade200,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   alignment: Alignment.topLeft,
//                   padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
//                   child: CircleAvatar(
//                     radius: 38,
//                     backgroundColor: Colors.black,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(top: 8, right: 8),
//                       child: Row(
//                         children: [
//                           Icon(Icons.home_filled, color: Colors.black54),
//                           SizedBox(width: 8),
//                           Text("544 Winchester", style: TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(bottom: 2),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text("544 Winchester, Oshawa, ON", style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Stack(
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 12,top: 35),
//                       child: Transform.rotate(
//                         angle: -90 * 3.1415926535 / 180,
//                         child: Container(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "Home",
//                             style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       width: 356,
//                       height: 102,
//                       color: Colors.white,
//                       alignment: Alignment.topRight,
//                       padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
//                       child: const Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Text("James",style:TextStyle(fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.key, color: Colors.grey),
//                                       Text("  10/01/2023 - 10/31/2023",
//                                         style:TextStyle(color: Colors.black26, fontSize: 15),
//                                       )],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Text('-\$1600.00 CAD',style:TextStyle(color: Colors.red, fontSize: 15)),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 8.0, top:7),
//                                   child: Row(
//                                     children: [
//                                       Text('Tenant Balance',style:TextStyle(color: Colors.black54, fontSize: 11)),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           CircleAvatar(
//                             radius: 40,
//                             backgroundColor: Colors.black,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//         )
//     );
//   }
// }
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              logOut();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Change this to the number of containers you want
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 210,
            color: Colors.blue.shade200,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                      child: CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.black,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: Row(
                            children: [
                              Icon(Icons.home_filled, color: Colors.black54),
                              SizedBox(width: 8),
                              Text("544 Winchester",
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("544 Winchester, Oshawa, ON",
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12, top: 35),
                          child: Transform.rotate(
                            angle: -90 * 3.1415926535 / 180,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 356,
                          height: 102,
                          color: Colors.white,
                          alignment: Alignment.topRight,
                          padding:
                          EdgeInsets.only(right: 8, top: 8, bottom: 8),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            "James",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.key, color: Colors.grey),
                                          Text(
                                            "  10/01/2023 - 10/31/2023",
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Text('-\$1600.00 CAD',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, top: 7),
                                      child: Row(
                                        children: [
                                          Text('Tenant Balance',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
