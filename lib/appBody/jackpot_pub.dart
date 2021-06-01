// import 'package:betLwambo/database/price.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:flutter/material.dart';

// class JackpotPub extends StatefulWidget {
//   @override
//   _JackpotPubState createState() => _JackpotPubState();
// }

// class _JackpotPubState extends State<JackpotPub> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 180.0,
//       decoration: BoxDecoration(
//         color: Colors.lightGreen[100],
//         // borderRadius: BorderRadius.circular(10.0),
//         border: Border(
//           top: BorderSide(color: Colors.lightGreen[400], width: 4.0),
//           bottom: BorderSide(color: Colors.lightGreen[400], width: 4.0),
//           left: BorderSide(color: Colors.lightGreen[400], width: 4.0),
//           right: BorderSide(color: Colors.lightGreen[400], width: 4.0),
//         ),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Jackpot'.toUpperCase(),
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15.0),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis),
//                         SizedBox(height: 2.0),
//                         Text('Pick 20 teams to win',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 11.0),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis)
//                       ],
//                     ),
//                     Container(
//                       padding: EdgeInsets.all(5.0),
//                       decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(5.0)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'New',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 11.0),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 Divider(color: Colors.black, thickness: 0.3),
//                 Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text('Ticket',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 11.0)),
//                       // SizedBox(height: 10.0),
//                       Text(
//                         Price.getWinningValues(Price.jackpotMinimumBet) + ' Fc',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12.0,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 // SizedBox(height: 5.0),
//                 Container(
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Price',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.0),
//                       ),
//                       Text(
//                         Price.getWinningValues(Price.jackpotWinningAmount) +
//                             ' Fc',
//                         style: TextStyle(
//                           color: Colors.lightGreen,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16.0,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 // SizedBox(height: 5.0),
//                 // Divider(color: Colors.grey, thickness: 0.3),
//               ],
//             ),
//           ),
//           // Container(
//           //   // padding: EdgeInsets.symmetric(vertical: 5.0),
//           //   decoration: BoxDecoration(
//           //       border: Border(
//           //           bottom: BorderSide(
//           //               color: Colors.grey, width: 0.3))),
//           // ),
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
//             child: RawMaterialButton(
//               onPressed: () {
//                 setState(() {
//                   // underline jackpot menu in topbar
//                   Window.showWindow = 2;
//                   // show jackpot window
//                   Window.showJackpotIndex = 1;
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => BetLwambo(),
//                     ),
//                   );
//                 });
//               },
//               fillColor: Colors.lightGreen,
//               disabledElevation: 3.0,
//               child: Text(
//                 'Buy a Ticket'.toUpperCase(),
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12.0,
//                     letterSpacing: 0.5),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
