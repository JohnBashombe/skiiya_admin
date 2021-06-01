// import 'package:betLwambo/database/selection.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// Future _itemCount;
// Future _countCountries;

// class Tournament extends StatefulWidget {
//   @override
//   _TournamentState createState() => _TournamentState();
// }

// class _TournamentState extends State<Tournament> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: 180.0,
//         decoration: BoxDecoration(
//           color: Colors.white70,
//           border: Border(
//             top: BorderSide(color: Colors.grey, width: 0.1),
//             bottom: BorderSide(color: Colors.grey, width: 0.1),
//             left: BorderSide(color: Colors.grey, width: 0.1),
//             right: BorderSide(color: Colors.grey, width: 0.1),
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               championship('Champions League', 'Europe', 0, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Europa League', 'Europe', 1, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Premier League', 'England', 2, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Serie A', 'Italy', 3, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('La Liga', 'Spain', 4, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Bundesliga', 'Germany', 5, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Ligue 1', 'France', 6, '1'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('England', 'Europe', 0, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Spain', 'Europe', 1, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('France', 'Europe', 2, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Italy', 'Europe', 3, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Germany', 'Europe', 4, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Belgium', 'Europe', 5, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Turkey', 'Europe', 6, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Japan', 'Asia', 7, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Brazil', 'S. America', 8, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Argentina', 'S. America', 9, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('USA', 'N. America', 10, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//               championship('Canada', 'N. America', 11, '2'),
//               Divider(color: Colors.grey, thickness: 0.2, height: 5.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void initState() {
//     super.initState();
//     _itemCount = Selection.getCountData();
//     _countCountries = Selection.getCountCountryData();
//   }

//   championship(String championship, String country, int index, String check) {
//     Future _content;
//     if (check.compareTo('1') == 0) {
//       _content = _itemCount;
//     } else {
//       _content = _countCountries;
//     }
//     return Container(
//       padding: new EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             Window.showWindow = 2;
//             print('clicked');
//           });
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           // crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // SizedBox(width: 10.0),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 105.0,
//                   child: Text(
//                     championship,
//                     style: TextStyle(
//                         color: Colors.black,
//                         // fontWeight: FontWeight.bold,
//                         fontSize: 12.0),
//                     maxLines: 2,
//                     overflow: TextOverflow.clip,
//                   ),
//                 ),
//                 Text(
//                   country,
//                   style: TextStyle(color: Colors.grey, fontSize: 11.0),
//                 ),
//               ],
//             ),

//             FutureBuilder(
//               future: _content,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return SpinKitFadingCube(
//                     color: Colors.lightGreen[400],
//                     size: 12.0,
//                   );
//                 } else {
//                   // print(snapshot.data[0]);
//                   int value = snapshot.data[index];
//                   String data = value.toString();
//                   if (data.length < 2) {
//                     data = '0' + data;
//                   }
//                   return Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
//                       decoration: BoxDecoration(
//                           color: Colors.lightGreen[400],
//                           borderRadius: BorderRadius.circular(10.0)),
//                       child: Text(
//                         '+' + (value >= 99 ? '99' : data),
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 11.0),
//                       ));
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
