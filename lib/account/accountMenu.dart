// import 'package:betLwambo/account/login.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/database/selection.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

// class AccountMenu extends StatefulWidget {
//   @override
//   _AccountMenuState createState() => _AccountMenuState();
// }

// class _AccountMenuState extends State<AccountMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: new EdgeInsets.all(10.0),
//         margin: new EdgeInsets.only(left: 10.0),
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(color: Colors.grey, width: 1.0),
//             bottom: BorderSide(color: Colors.grey, width: 1.0),
//             left: BorderSide(color: Colors.grey, width: 1.0),
//             right: BorderSide(color: Colors.grey, width: 1.0),
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.only(top: 0.0),
//           children: [
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     Window.showWindow = 12;
//                     // print('Showing history panel');
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => BetLwambo()));
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'History',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13.0,
//                         fontWeight: FontWeight.w200,
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right,
//                       size: 22.0,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.0),
//             Divider(color: Colors.grey, thickness: 1.0),
//             SizedBox(height: 2.0),
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     Window.showWindow = 10;
//                     // print('Showing transaction panel');
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => BetLwambo()));
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Transactions',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13.0,
//                         fontWeight: FontWeight.w200,
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right,
//                       size: 22.0,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.0),
//             Divider(color: Colors.grey, thickness: 1.0),
//             SizedBox(height: 2.0),
//             MouseRegion(
//               cursor: SystemMouseCursors.click,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     Window.showWindow = 13;
//                     // print('Showing transaction panel');
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => BetLwambo()));
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Contact Us',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13.0,
//                         fontWeight: FontWeight.w200,
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right,
//                       size: 22.0,
//                       color: Colors.black,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.0),
//             Divider(color: Colors.grey, thickness: 1.0),
//             SizedBox(height: 2.0),
//             if (Selection.user != null)
//               MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       Window.showWindow = 18;
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => BetLwambo()));
//                     });
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Change Password',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 13.0,
//                           fontWeight: FontWeight.w200,
//                         ),
//                       ),
//                       Icon(
//                         Icons.chevron_right,
//                         size: 22.0,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             if (Selection.user != null) SizedBox(height: 2.0),
//             if (Selection.user != null)
//               Divider(color: Colors.grey, thickness: 1.0),
//             if (Selection.user != null) SizedBox(height: 5.0),
//             if (Selection.user == null)
//               MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       Window.showWindow = 14;
//                       // print('Showing transaction panel');
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => BetLwambo()));
//                     });
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Login / Register',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 13.0,
//                           fontWeight: FontWeight.w200,
//                         ),
//                       ),
//                       Icon(
//                         Icons.chevron_right,
//                         size: 22.0,
//                         color: Colors.black,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             // if (Selection.user != null) SizedBox(height: 2.0),
//             if (Selection.user != null)
//               MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       // log out the current user from the system
//                       Login.doLogout();
//                       // reload the main application frame
//                       Window.showWindow = 0;
//                       // Window.showWindow = 16;
//                       // Window.showWindow = 0;
//                       // using session to store user login details

//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => BetLwambo()));
//                       // print('log out');
//                       // log out the current user from the system
//                       // Login.doLogout();
//                       // reload the main application frame
//                     });
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Log Out',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 13.0,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                       Icon(
//                         Icons.power_settings_new,
//                         size: 25.0,
//                         color: Colors.red,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             // SizedBox(height: 2.0),
//             if (Selection.user == null) SizedBox(height: 10.0),
//             if (Selection.user == null)
//               Divider(color: Colors.grey, thickness: 1.0),
//             if (Selection.user != null)
//               Divider(color: Colors.grey, thickness: 1.0),
//             // Divider(color: Colors.grey, thickness: 1.0),
//             // SizedBox(height: 2.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
