// import 'package:betLwambo/Responsive/responsive_widget.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class BetDetails extends StatefulWidget {
//   @override
//   _BetDetailsState createState() => _BetDetailsState();
// }

// class _BetDetailsState extends State<BetDetails> {
//   @override
//   Widget build(BuildContext context) {
//     // Window.showWindow = 15;
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
//         padding: EdgeInsets.all(10.0),
//         decoration: BoxDecoration(
//           border: Border(
//             top: BorderSide(color: Colors.grey, width: 0.3),
//             bottom: BorderSide(color: Colors.grey, width: 0.3),
//             left: BorderSide(color: Colors.grey, width: 0.3),
//             right: BorderSide(color: Colors.grey, width: 0.3),
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.only(top: 0.0),
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     icon: Icon(Icons.arrow_back_ios),
//                     onPressed: () {
//                       if (Window.backToHistory == 0) {
//                         Window.showWindow = 11;
//                         // print('Back to Bets');
//                       } else if (Window.backToHistory == 1) {
//                         Window.showWindow = 12;
//                         // print('Back to History bets');
//                       }
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => BetLwambo()));
//                     }),
//               ],
//             ),

//             Divider(color: Colors.grey, thickness: 0.5),
//             SizedBox(height: 5.0),
//             // top row containing column decsription
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Date',
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 13.0,
//                         fontWeight: FontWeight.bold)),
//                 Text('Bet details',
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 13.0,
//                         fontWeight: FontWeight.bold)),
//                 Text('Odds',
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 13.0,
//                         fontWeight: FontWeight.bold)),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             Divider(color: Colors.grey, thickness: 0.4),
//             SizedBox(height: 5.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('23/12/2020',
//                         style: TextStyle(fontSize: 12.0, color: Colors.grey)),
//                     SizedBox(height: 2.0),
//                     Text('12:53 AM',
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           color: Colors.black,
//                         )),
//                   ],
//                 ),
//                 SizedBox(width: 5.0),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       width: ResponsiveWidget.isExtraSmallScreen(context)
//                           ? 120
//                           : ResponsiveWidget.isSmallScreen(context) ? 170 : 200,
//                       child: Text(
//                         'Hatayspor - Balikesirspor',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14.0,
//                           // fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 4,
//                         overflow: TextOverflow.clip,
//                       ),
//                     ),
//                     SizedBox(height: 1.0),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       width: ResponsiveWidget.isExtraSmallScreen(context)
//                           ? 120
//                           : ResponsiveWidget.isSmallScreen(context) ? 170 : 200,
//                       child: Text(
//                         'Football - Turkey - 1. Lig',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12.0,
//                           // fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 1.0),
//                     Text(
//                       '1x2 - FT [ 1 ]'.toUpperCase(),
//                       style: TextStyle(
//                         color: Colors.lightGreen,
//                         fontSize: 12.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '3-0',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14.0,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 1.0),
//                     Icon(FontAwesomeIcons.checkCircle,
//                         size: 18.0, color: Colors.lightGreen),
//                     SizedBox(height: 2.0),
//                     Text(
//                       '2.10',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             Divider(color: Colors.grey, thickness: 0.4),
//             SizedBox(height: 5.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Odds:',
//                   style: TextStyle(color: Colors.grey, fontSize: 12.0),
//                 ),
//                 Text(
//                   '162 115.50',
//                   style: TextStyle(
//                       color: Colors.black,
//                       // fontWeight: FontWeight.bold,
//                       fontSize: 13.0),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Your Stake:',
//                   style: TextStyle(color: Colors.grey, fontSize: 12.0),
//                 ),
//                 Text(
//                   '100.00 FC',
//                   style: TextStyle(
//                       color: Colors.black,
//                       // fontWeight: FontWeight.bold,
//                       fontSize: 13.0),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Price:',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12.0,
//                     // fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   '173 427.87 Fc',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14.0,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             Divider(color: Colors.grey, thickness: 0.5),
//             SizedBox(height: 5.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Result:',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 13.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Lost'.toUpperCase(),
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13.0,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             Divider(color: Colors.grey, thickness: 0.5),
//             // SizedBox(height: 5.0),
//             SizedBox(height: 15.0),
//             Container(
//               alignment: Alignment.center,
//               child: Text(
//                 'Bet placed on 23/11/2020 at 12:34 PM',
//                 style: TextStyle(color: Colors.grey, fontSize: 11.0),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(FontAwesomeIcons.clock, size: 16.0, color: Colors.grey),
//                 SizedBox(width: 3.0),
//                 Text('Pending',
//                     style: TextStyle(color: Colors.grey, fontSize: 12.0)),
//                 SizedBox(width: 8.0),
//                 Icon(FontAwesomeIcons.checkCircle,
//                     size: 16.0, color: Colors.lightGreen),
//                 SizedBox(width: 3.0),
//                 Text('Won',
//                     style: TextStyle(color: Colors.grey, fontSize: 12.0)),
//                 SizedBox(width: 8.0),
//                 Icon(FontAwesomeIcons.timesCircle,
//                     size: 16.0, color: Colors.redAccent),
//                 SizedBox(width: 3.0),
//                 Text('Lost',
//                     style: TextStyle(color: Colors.grey, fontSize: 12.0)),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
