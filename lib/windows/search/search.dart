// import 'package:betLwambo/Responsive/responsive_widget.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// // store loaded results
// var _queryResults = [];
// // store filtered results
// var _queryDisplay = [];
// // check weither input is empty or not to display no data found
// bool isQueryEmpty = true;

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         width: double.infinity,
//         margin: EdgeInsets.only(
//             left: ResponsiveWidget.isBigScreen(context) ? 15.0 : 10.0),
//         padding: new EdgeInsets.all(10.0),
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
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 5.0),
//                 Container(
//                   padding: EdgeInsets.all(12.0),
//                   height: 50.0,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white70,
//                       border: Border(
//                         top: BorderSide(color: Colors.lightGreen, width: 1.5),
//                         bottom:
//                             BorderSide(color: Colors.lightGreen, width: 1.5),
//                         left: BorderSide(color: Colors.lightGreen, width: 1.5),
//                         right: BorderSide(color: Colors.lightGreen, width: 1.5),
//                       )),
//                   child: TextField(
//                     cursorColor: Colors.lightGreen,
//                     maxLines: 1,
//                     keyboardType: TextInputType.text,
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.singleLineFormatter,
//                       FilteringTextInputFormatter.allow(RegExp(
//                           r'[a-zA-Z0-9]')), // create a pattern for text only
//                     ],
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.5),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Search Match',
//                         icon: Icon(
//                           Icons.search,
//                           color: Colors.lightGreen[400],
//                         ),
//                         hintMaxLines: 1,
//                         hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.0)),
//                     onChanged: (value) {
//                       if (value.isEmpty) {
//                         setState(() {
//                           _queryResults.clear();
//                           _queryDisplay.clear();
//                           isQueryEmpty = true;
//                         });
//                         return;
//                       }
//                       try {
//                         setState(() {
//                           // if reaches here it means the value is not empty
//                           isQueryEmpty = false;
//                           // everytime a value is changed, do update the results
//                           loadingSearch(value);
//                         });
//                       } catch (e) {
//                         // caught the error if any one show in the user typing
//                         print('Error: $e');
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Text(
//                   'Results'.toUpperCase(),
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 5.0),
//                 Divider(color: Colors.grey, thickness: 0.5),
//                 // if something has been found in collection, execute this
//                 _queryResults.length > 0
//                     // if both contents are greater than 0 print this
//                     ? _queryDisplay.length > 0
//                         ? Column(
//                             children: _queryDisplay.map<Widget>(
//                               (result) {
//                                 // return Container(child: Text(word['team1']));
//                                 return thisResult(result);
//                               },
//                             ).toList(),
//                           )
//                         // if there is no matching content then do thi
//                         : Center(
//                             child: Column(
//                               children: [
//                                 SizedBox(height: 8.0),
//                                 Text(
//                                   'No Match found',
//                                   style: TextStyle(
//                                     color: Colors.lightGreen[400],
//                                     fontSize: 15.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10.0),
//                                 SpinKitHourGlass(
//                                   color: Colors.lightGreen[400],
//                                   size: 30.0,
//                                   // lineWidth: 5.0,
//                                 ),
//                               ],
//                             ),
//                           )
//                     // if the query is empty return three dots
//                     : isQueryEmpty
//                         ? Padding(
//                             padding: const EdgeInsets.only(top: 10.0),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'Search Results',
//                                   style: TextStyle(
//                                     color: Colors.lightGreen[400],
//                                     fontSize: 15.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10.0),
//                                 Center(
//                                   child: SpinKitDualRing(
//                                     color: Colors.lightGreen[400],
//                                     size: 30.0,
//                                     lineWidth: 5.0,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         // if that means nothing has been found in collection
//                         : Center(
//                             child: Column(
//                               children: [
//                                 SizedBox(height: 8.0),
//                                 Text(
//                                   'No Match found',
//                                   style: TextStyle(
//                                     color: Colors.lightGreen[400],
//                                     fontSize: 15.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 SizedBox(height: 10.0),
//                                 SpinKitHourGlass(
//                                   color: Colors.lightGreen[400],
//                                   size: 20.0,
//                                   // lineWidth: 5.0,
//                                 ),
//                               ],
//                             ),
//                           ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget thisResult(DocumentSnapshot result) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           print('loading ${result['team1']} and ${result['team2']}');
//           Window.showWindow = 0;
//           // assign the results to match more odds and load game details
//           matchMoreOdds = result;
//         });
//       },
//       child: Column(
//         children: [
//           SizedBox(height: 5.0),
//           Row(
//             children: [
//               Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.blue),
//               SizedBox(width: 4.0),
//               Container(
//                 width: ResponsiveWidget.isExtraSmallScreen(context)
//                     ? 150
//                     : ResponsiveWidget.isSmallScreen(context)
//                         ? 250
//                         : (ResponsiveWidget.isMediumScreen(context) ||
//                                 ResponsiveWidget.customScreen(context) ||
//                                 ResponsiveWidget.isExtraLargeScreen(context))
//                             ? 450
//                             : 350,
//                 child: Text(
//                   result['team1'] + ' - ' + result['team2'],
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: ResponsiveWidget.isExtraSmallScreen(context)
//                         ? 11.0
//                         : 14.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   maxLines: 4,
//                   overflow: TextOverflow.clip,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           SizedBox(height: 5.0),
//           Divider(color: Colors.grey, thickness: 0.4),
//         ],
//       ),
//     );
//   }

//   loadingSearch(String search) {
//     // starting letters will be stored in an array ['B','R'] for e.g. Barcelona and Real Madrid
//     // we will use the or operator to load and search through them
//     // load all matches starting with the letter only
//     var capitalizedValue =
//         search.substring(0, 1).toUpperCase() + search.substring(1);

//     if ((_queryResults.length == 0) && (search.length == 1)) {
//       // print('The value to send on server is: $capitalizedValue');
//       // _queryResults.add('match found');
//       // this method sent the letter to be located in firebase games collection
//       sentRequest(capitalizedValue);
//       // when receiving values, the will be stored in the query array
//       // query array will be filtered to matching search key and results will be stored in the _display results
//       // _display results will be then displayed to the screen.
//     } else {
//       setState(() {
//         // print('the full search string is $capitalizedValue');
//         _queryDisplay = [];
//         _queryResults.forEach((element) {
//           if ((element['team1']
//                   .toString()
//                   .toLowerCase()
//                   .startsWith(capitalizedValue.toLowerCase())) ||
//               (element['team2']
//                   .toString()
//                   .toLowerCase()
//                   .startsWith(capitalizedValue.toLowerCase()))) {
//             _queryDisplay.add(element);
//             // print(element);
//           }
//         });
//       });
//     }
//     // print(_queryDisplay.length);
//   }

//   sentRequest(String request) async {
//     var _thisData = Firestore.instance;
//     // This query snapshot load all games available in the system
//     QuerySnapshot qn;
//     qn = await _thisData
//         .collection('Games')
//         .where('searchKey', arrayContains: request)
//         .getDocuments();
//     setState(() {
//       // add all results to the first array
//       for (var j = 0; j < qn.documents.length; j++) {
//         // print(qn.documents[j]['team1']);
//         // print(qn.documents[j]['team2']);
//         // we add all fetched values to the query results array
//         _queryResults.add(qn.documents[j]);
//         _queryDisplay.add(qn.documents[j]);
//       }
//     });
//     return qn.documents;
//   }

// }
