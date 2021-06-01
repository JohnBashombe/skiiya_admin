// import 'package:betLwambo/Responsive/responsive_widget.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:flutter/material.dart';

// class RegisterAcount extends StatefulWidget {
//   @override
//   _RegisterAcountState createState() => _RegisterAcountState();
// }

// class _RegisterAcountState extends State<RegisterAcount> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
//         padding: new EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(color: Colors.grey, width: 0.5),
//             bottom: BorderSide(color: Colors.grey, width: 0.5),
//             left: BorderSide(color: Colors.grey, width: 0.5),
//             right: BorderSide(color: Colors.grey, width: 0.5),
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.only(top: 0.0),
//           children: [
//             Container(
//               alignment: Alignment.center,
//               child: Text(
//                 'Register',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 25.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Divider(color: Colors.grey, thickness: 0.4),
//             SizedBox(height: 20.0),
//             Text(
//               'Phone Number [ +243 ]',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.0),
//             Container(
//               padding: EdgeInsets.all(12.0),
//               height: 50.0,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: Colors.white70,
//                   border: Border(
//                     top: BorderSide(color: Colors.grey, width: 1.5),
//                     bottom: BorderSide(color: Colors.grey, width: 1.5),
//                     left: BorderSide(color: Colors.grey, width: 1.5),
//                     right: BorderSide(color: Colors.grey, width: 1.5),
//                   )),
//               child: TextField(
//                 cursorColor: Colors.lightGreen,
//                 maxLines: 1,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 0.5),
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     // fillColor: Colors.deepOrange[400],
//                     // contentPadding: EdgeInsets.all(10.0),
//                     hintText: 'e.g. 97...',
//                     hintMaxLines: 1,
//                     hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12.0)),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             // Divider(color: Colors.grey, thickness: 0.4),
//             // SizedBox(height: 10.0),
//             Text(
//               'Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.0),
//             Container(
//               padding: EdgeInsets.all(12.0),
//               height: 50.0,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: Colors.white70,
//                   border: Border(
//                     top: BorderSide(color: Colors.grey, width: 1.5),
//                     bottom: BorderSide(color: Colors.grey, width: 1.5),
//                     left: BorderSide(color: Colors.grey, width: 1.5),
//                     right: BorderSide(color: Colors.grey, width: 1.5),
//                   )),
//               child: TextField(
//                 obscureText: true,
//                 cursorColor: Colors.lightGreen,
//                 maxLines: 1,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 0.5),
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     // fillColor: Colors.deepOrange[400],
//                     // contentPadding: EdgeInsets.all(10.0),
//                     hintText: 'Password',
//                     hintMaxLines: 1,
//                     hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12.0)),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             // Divider(color: Colors.grey, thickness: 0.4),
//             // SizedBox(height: 10.0),
//             Text(
//               'Confirm Password',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5.0),
//             Container(
//               padding: EdgeInsets.all(12.0),
//               height: 50.0,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: Colors.white70,
//                   border: Border(
//                     top: BorderSide(color: Colors.grey, width: 1.5),
//                     bottom: BorderSide(color: Colors.grey, width: 1.5),
//                     left: BorderSide(color: Colors.grey, width: 1.5),
//                     right: BorderSide(color: Colors.grey, width: 1.5),
//                   )),
//               child: TextField(
//                 obscureText: true,
//                 cursorColor: Colors.lightGreen,
//                 maxLines: 1,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 0.5),
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     // fillColor: Colors.deepOrange[400],
//                     // contentPadding: EdgeInsets.all(10.0),
//                     hintText: 'Confirm Password',
//                     hintMaxLines: 1,
//                     hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12.0)),
//               ),
//             ),
//             SizedBox(height: 15.0),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       Window.showWindow = 14;
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => BetLwambo()));
//                     });
//                   },
//                   child: Text(
//                     'An account already?',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 13.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'By creating this account, you agree to our terms and conditions.'
//                         .toUpperCase(),
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 13.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Divider(color: Colors.grey, thickness: 0.5),
//               ],
//             ),
//             SizedBox(height: 15.0),
//             Container(
//               width: double.infinity,
//               child: RawMaterialButton(
//                 onPressed: () {},
//                 fillColor: Colors.lightBlue,
//                 disabledElevation: 3.0,
//                 child: Text(
//                   'Register'.toUpperCase(),
//                   style: TextStyle(
//                       color: Colors.white,
//                       // fontWeight: FontWeight.bold,
//                       fontSize: 18.0),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
