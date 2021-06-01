// code removed
// oddEvenFirstHalfEven(List<Object> firstHalf, int index) {
//   updateColors(selectionTeamOdds[index]);
//   return Expanded(
//     child: RawMaterialButton(
//       onPressed: () {
//         setState(() {
//           updateAndSaveState();
//           updateHomeMatches();
//           if (selectionTeamOdds[index] == true) {
//             selectionTeamOdds[index] = false;
//             // remove match from betslip
//             removeMatchFromBetSlip(match);
//           } else {
//             setUnselectedToFalse(index);
//             // add game odds to betslip
//             addMatchToBetSlip(match, '1st-H.', 'Even', firstHalf[2]);
//           }
//           updateAndSaveState();
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => SideMenu()));
//         });
//       },
//       fillColor: colorBg,
//       padding: new EdgeInsets.symmetric(horizontal: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Even',
//             style: TextStyle(fontSize: 12.0, color: color),
//           ),
//           Text(
//               double.parse(firstHalf[2].toString())
//                   .toStringAsFixed(2)
//                   .toString(),
//               style: TextStyle(color: color, fontSize: 12.0)),
//         ],
//       ),
//     ),
//   );
// }

// oddEvenFirstHalfOdd(List<Object> firstHalf, int index) {
//   updateColors(selectionTeamOdds[index]);
//   return Expanded(
//     child: RawMaterialButton(
//       onPressed: () {
//         setState(() {
//           updateAndSaveState();
//           updateHomeMatches();
//           if (selectionTeamOdds[index] == true) {
//             selectionTeamOdds[index] = false;
//             // remove match from betslip
//             removeMatchFromBetSlip(match);
//           } else {
//             setUnselectedToFalse(index);
//             // add game odds to betslip
//             addMatchToBetSlip(match, '1st-H.', 'Odd', firstHalf[1]);
//           }
//           updateAndSaveState();
//           Navigator.push(
//               context, MaterialPageRoute(builder: (_) => SideMenu()));
//         });
//       },
//       fillColor: colorBg,
//       padding: new EdgeInsets.symmetric(horizontal: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'Odd',
//             style: TextStyle(fontSize: 12.0, color: color),
//           ),
//           Text(
//               double.parse(firstHalf[1].toString())
//                   .toStringAsFixed(2)
//                   .toString(),
//               style: TextStyle(color: color, fontSize: 12.0)),
//         ],
//       ),
//     ),
//   );
// }

// winToNil() {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'WIN TO NIL',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//               fontSize: 15.0,
//               letterSpacing: 1.0,
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Text(
//             'Barcelona - Full Time',
//             style: TextStyle(
//               color: Colors.grey,
//               fontSize: 12.0,
//             ),
//           ),
//         ],
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: RawMaterialButton(
//               onPressed: null,
//               fillColor: Colors.grey[300],
//               padding: new EdgeInsets.symmetric(horizontal: 5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Yes',
//                     style: TextStyle(
//                         fontSize: 12.0,
//                         // fontWeight:
//                         //     FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   Text('1.99',
//                       style: TextStyle(
//                           color: Colors.black,
//                           // fontWeight:
//                           //     FontWeight.bold,
//                           fontSize: 12.0)),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(width: 5.0),
//           Expanded(
//             child: RawMaterialButton(
//               onPressed: null,
//               fillColor: Colors.grey[300],
//               padding: new EdgeInsets.symmetric(horizontal: 5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'No',
//                     style: TextStyle(
//                         fontSize: 12.0,
//                         // fontWeight:
//                         //     FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                   Text('1.72',
//                       style: TextStyle(
//                           color: Colors.black,
//                           // fontWeight:
//                           //     FontWeight.bold,
//                           fontSize: 12.0)),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

//  StreamBuilder<QuerySnapshot>(
//             stream: Firestore.instance.collection('Games').snapshots(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 print(snapshot.error);
//                 return new Column(
//                   children: [
//                     Icon(Icons.warning, color: Colors.red, size: 20.0),
//                     Text('An error occured',
//                         style: TextStyle(color: Colors.grey, fontSize: 12.0)),
//                   ],
//                 );
//               }
//               switch (snapshot.connectionState) {
//                 case ConnectionState.waiting:
//                   // return new Text('Loading...');
//                   return new SpinKitHourGlass(
//                     color: Colors.lightGreen[400],
//                     size: 50.0,
//                   );

//                 default:
//                   return new ListView(
//                     children: snapshot.data.documents
//                         .map((DocumentSnapshot document) {
//                       // convert all documents values to
//                       // var time = document['time'][2];
//                       return singleMatch(document);
//                       // new ListTile(
//                       //   title: new Text(
//                       //       document['team1'] + ' - ' + document['team2']),
//                       //   subtitle: new Text(document['championship'] + time),
//                       // );
//                     }).toList(),
//                   );
//               }
//             },
//           ),

// Future _data;
//  @override
//   void initState() {
//     super.initState();
//     _data = Selection.getPosts();
//     // print('executed iniState');
//   }

// FutureBuilder(
//               future: _data,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text('Loading...');
//                 } else {
//                   return ListView.builder(
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (_, index) {
//                         // print(
//                         //     'Snapshot content is: ${snapshot.data[index].data['team1']}');
//                         return singleMatch(snapshot, index);
//                         //  ListTile(
//                         //   title:
//                         //       Text(snapshot.data[index].data['championship']),
//                         // );
//                       });
//                 }
//               },
//             )

// import 'dart:async';
// import 'package:betLwambo/Responsive/responsive_widget.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/database/selection.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_web/firebase_auth_web.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';

// bool _isNumberVisible = true;
// bool _resendCode = false;

// String _phoneNumber = '';
// String _smsCode = '';
// // this store the phone to be checked
// String _numberFilter = '';
// String _codeFilter = '';

// String _phoneMessage = '';
// String _smsError = '';

// bool _displayPhoneError = false;
// bool _displaySmsError = false;

// bool _displayPhoneSuccess = false;
// // bool _displaySmsSuccess = false;
// // display the check icon
// bool _validNumber = false;

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   // Note: This is a `GlobalKey<FormState>`,
//   // not a GlobalKey<MyCustomFormState>.
//   final _formKeyPhone = GlobalKey<FormState>();
//   final _formKeyCode = GlobalKey<FormState>();

//   Timer _timer;
//   int _start;
//   int _timeManager;

//   int min, sec, divider;
//   String minutes = '00';
//   String seconds = '00';

//   void startTimer() {
//     _start = Selection.minTimer;
//     _timeManager = 0;
//     min = 0;
//     sec = 0;
//     divider = 60;

//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) => setState(
//         () {
//           if (_start < 1) {
//             timer.cancel();
//           } else {
//             // hide the counter and display the button only
//             if (_start == 1) {
//               _resendCode = true;
//             }
//             _start = _start - 1;
//             _timeManager = _start;
//             min = (_timeManager / divider).truncate();
//             sec = (_start % divider);
//             // print('time manager $_timeManager');
//             // print('mim $min');
//             minutes = min.toString();
//             seconds = sec.toString();

//             if (minutes.length == 1) {
//               minutes = '0' + minutes;
//             }
//             if (seconds.length == 1) {
//               seconds = '0' + seconds;
//             }
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   // we will use facebook login/sign up
//   // we will use twitter login/sign up
//   // we will use Gmail or Google account login/sign up

//   FirebaseAuth _auth;
//   String verificationID = '';

//   Future<bool> sendPhone(String phone) async {
//     _auth = FirebaseAuth.instance;
//     String callPhone = '+243' + _phoneNumber.trim();
//     print('The phone is: $callPhone');
//     _auth.verifyPhoneNumber(
//       phoneNumber: callPhone,
//       timeout: Duration(seconds: Selection.minTimer),
//       verificationCompleted: (AuthCredential credential) async {
//         AuthResult result = await _auth.signInWithCredential(credential);
//         Selection.user = result.user;
//         if (Selection.user != null) {
//           successMessage(context, 'You Login Successfully!');
//           print('This user has logged in');
//         } else {
//           print('No user has logged in so far');
//         }
//       },
//       verificationFailed: (AuthException exception) {
//         failMessage(context, 'An error occured');
//         print('The code was not sent: $exception');
//       },
//       codeSent: (String verificationId, [int forceResendingToken]) async {
//         verificationID = verificationId;

//         verifySmsCode(verificationId);
//       },
//       codeAutoRetrievalTimeout: null,
//     );
//     // return true;
//   }

//   Future<bool> verifySmsCode(String code) async {
//     AuthCredential credential = PhoneAuthProvider.getCredential(
//         verificationId: verificationID, smsCode: _smsCode.trim());
//     AuthResult result = await _auth.signInWithCredential(credential);

//     Selection.user = result.user;

//     if (Selection.user != null) {
//       successMessage(context, 'Login Successfully!');
//       print('Logged in');
//     } else {
//       failMessage(context, 'Sorry! Log in failed!');
//       print('no user account found');
//     }
//     return true;
//   }

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
//               child: _isNumberVisible
//                   ? Text(
//                       'Phone Number',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 30.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   : Text(
//                       'SMS Code',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 30.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//             ),
//             SizedBox(height: 20.0),
//             Divider(color: Colors.grey, thickness: 0.4),
//             SizedBox(height: 20.0),
//             _isNumberVisible ? getPhone(context) : getCode(context),
//           ],
//         ),
//       ),
//     );
//   }

//   getPhone(BuildContext context) {
//     return Form(
//       key: _formKeyPhone,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Phone Number',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 12.0,
//               color: Colors.grey,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Row(
//             children: [
//               Container(
//                 height: 50.0,
//                 padding: new EdgeInsets.symmetric(horizontal: 5.0),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(color: Colors.lightGreen[400], width: 2.0),
//                     bottom:
//                         BorderSide(color: Colors.lightGreen[400], width: 2.0),
//                     left: BorderSide(color: Colors.lightGreen[400], width: 2.0),
//                   ),
//                   // borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: Text(
//                   '+243',
//                   style: TextStyle(
//                     color: Colors.lightGreen[400],
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(12.0),
//                   height: 50.0,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white70,
//                       border: Border(
//                         top: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                         bottom: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                         left: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                         right: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                       )),
//                   child: TextFormField(
//                     onChanged: (value) {
//                       setState(() {
//                         _numberFilter = value;
//                         if (!checkNumber(value)) {
//                           return;
//                         }
//                       });
//                     },
//                     cursorColor: Colors.lightGreen,
//                     maxLines: 1,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.5),
//                     decoration: InputDecoration(
//                         border: InputBorder.none,
//                         // fillColor: Colors.deepOrange[400],
//                         // contentPadding: EdgeInsets.all(10.0),
//                         hintText: '972..',
//                         hintMaxLines: 1,
//                         hintStyle: TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12.0)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 3.0),
//           if (_displayPhoneError)
//             Text(
//               _phoneMessage,
//               style: TextStyle(
//                 color: Colors.red,
//                 fontSize: 12.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           if (_displayPhoneSuccess)
//             Row(
//               children: [
//                 Text(
//                   _phoneMessage,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 if (_validNumber)
//                   Icon(
//                     Icons.check,
//                     size: 16.0,
//                     color: Colors.green,
//                   )
//               ],
//             ),
//           SizedBox(height: 20.0),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'You will receive a Verification Code',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w300,
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     Window.showJackpotIndex = 2;
//                     Window.showWindow = 3;
//                     // this is here because of login is outside of the main app but will be set inside
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (_) => BetLwambo()));
//                   });
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.check,
//                       color: Colors.lightBlue,
//                       size: 25.0,
//                     ),
//                     SizedBox(width: 3.0),
//                     Expanded(
//                       child: MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: Text(
//                           'I agree to betLwambo terms and conditions',
//                           style: TextStyle(
//                             color: Colors.lightBlue,
//                             fontSize: 13.0,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10.0),
//           Container(
//             width: double.infinity,
//             child: RawMaterialButton(
//               padding: new EdgeInsets.symmetric(
//                   vertical:
//                       ResponsiveWidget.isSmallScreen(context) ? 10.0 : 15.0),
//               onPressed: () {
//                 setState(() {
//                   // Window.showWindow = 0;
//                   // print(_numberFilter.length);
//                   // print(_numberFilter);
//                   if (_numberFilter.length != 9) {
//                     _displayPhoneError = true;
//                     _displayPhoneSuccess = false;
//                     _validNumber = false;
//                     _phoneMessage = 'Invalid Phone Number';
//                   } else {
//                     // print('this phone number: $_phoneNumber');
//                     if (checkNumber(_phoneNumber)) {
//                       sendPhone(_phoneNumber).then((value) => () {
//                             // if the sending is successfull the show the snackbar success
//                             if (value) {
//                               _isNumberVisible = false;
//                               // set the resend code to false
//                               _phoneNumber = _phoneNumber.substring(0, 9);
//                               _resendCode = false;
//                               // set the phone number value
//                               // print('This phone 1: $_phoneNumber');
//                               // print('This phone: $_phoneNumber');
//                               // reset the number to empty
//                               _numberFilter = '';
//                               // call this method to send a code to the user phone
//                               successMessage(context, 'Code sent');
//                               // this count down when the user can resend the code again
//                               startTimer();
//                             } else {
//                               // if the sending is failed the show the snackbar fail
//                               failMessage(context, 'Code not sent');
//                             }
//                           });
//                     } else {
//                       _displayPhoneError = true;
//                       _displayPhoneSuccess = false;
//                       _validNumber = false;
//                       _phoneMessage = 'Invalid Phone Number';
//                       return;
//                     }
//                   }
//                 });
//               },
//               fillColor: Colors.lightGreen[400],
//               disabledElevation: 5.0,
//               child: Text(
//                 'Send Code'.toUpperCase(),
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool checkNumber(String value) {
//     if (value.isEmpty) {
//       _phoneNumber = '';
//       _displayPhoneError = false;
//       _displayPhoneSuccess = false;
//       return false;
//     } else {
//       // if (value.length == 1) {
//       //   _displayPhoneError = false;
//       //   _phoneMessage = '';
//       //   print('reached');
//       // }
//       // tell the user to remove the first 0 if entered
//       if (value.substring(0, 1).toString().compareTo('0') == 0) {
//         _displayPhoneError = true;
//         _phoneMessage = 'Remove the 1st \"0"';
//         return false;
//       }
//       // check if the phone is congo network based
//       if ((((value.substring(0, 1).toString().compareTo('8') == 0) &&
//               (value.substring(1, 2).toString().compareTo('4') == 0)) ||
//           ((value.substring(0, 1).toString().compareTo('8') == 0) &&
//               (value.substring(1, 2).toString().compareTo('5') == 0)) ||
//           ((value.substring(0, 1).toString().compareTo('8') == 0) &&
//               (value.substring(1, 2).toString().compareTo('9') == 0)) ||
//           ((value.substring(0, 1).toString().compareTo('8') == 0) &&
//               (value.substring(1, 2).toString().compareTo('1') == 0)) ||
//           ((value.substring(0, 1).toString().compareTo('8') == 0) &&
//               (value.substring(1, 2).toString().compareTo('2') == 0)) ||
//           ((value.substring(0, 1).toString().compareTo('9') == 0) &&
//               (value.substring(1, 2).toString().compareTo('7') == 0)) ||
//           ((value.substring(0, 1).toString().compareTo('9') == 0) &&
//               (value.substring(1, 2).toString().compareTo('9') == 0)))) {
//         if ((value.length == 9)) {
//           // display success only if the number is right and valid
//           // print(value.substring(1, 2).toString());
//           _displayPhoneError = false;
//           _displayPhoneSuccess = true;
//           _validNumber = true;
//           _phoneMessage = 'Valid Phone Number';
//           // return true;
//         } else if (value.length < 9) {
//           _displayPhoneError = false;
//           _displayPhoneSuccess = true;
//           _validNumber = false;
//           _phoneMessage = 'Checking...';
//           return false;
//         }
//       } else {
//         _displayPhoneError = true;
//         _displayPhoneSuccess = false;
//         _phoneMessage = 'Invalid Phone Number';
//         return false;
//       }

//       if (value.length > 9) {
//         _displayPhoneError = true;
//         _displayPhoneSuccess = false;
//         _phoneMessage = 'Phone number too long';
//         return false;
//       }

//       // get only nine numbers and give a damn about the rest
//       // else if (value.length == 9) {
//       // _phoneNumber = value.substring(0, 9);
//       _phoneNumber = value.toString();
//       //   print(value.substring(0, 9));
//       //   return true;
//       // }
//       // print('the extracted phone number is: $_phoneNumber');
//       // else {
//       //   _phoneNumber = value;
//       //   _displayPhoneError = false;
//       // }
//     }
//     return true;
//   }

//   bool checkCode(String value) {
//     if (value.isEmpty) {
//       _phoneNumber = '';
//       _displaySmsError = false;
//       // _displaySmsSuccess = false;
//       return false;
//     } else {
//       // if (value.length < 6) {
//       //   // _displaySmsError = false;
//       //   _displaySmsError = true;
//       //   // _displayPhoneSuccess = true;
//       //   // _validNumber = false;
//       //   _smsError = 'Code too short';
//       //   // _phoneMessage = 'Checking...';
//       //   return false;
//       // } else
//       if (value.length > 6) {
//         _displaySmsError = true;
//         // _displayPhoneSuccess = false;
//         _smsError = 'Code too long';
//         return false;
//       } else {
//         _displaySmsError = false;
//       }
//     }
//     _smsCode = value.toString();
//     return true;
//   }

//   getCode(BuildContext context) {
//     return Form(
//       key: _formKeyCode,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text('Type Code here',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 12.0,
//                 color: Colors.grey,
//               )),
//           SizedBox(height: 8.0),
//           Row(
//             children: [
//               Container(
//                 height: 50.0,
//                 padding: new EdgeInsets.symmetric(horizontal: 13.0),
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(color: Colors.lightGreen[400], width: 2.0),
//                     bottom:
//                         BorderSide(color: Colors.lightGreen[400], width: 2.0),
//                     left: BorderSide(color: Colors.lightGreen[400], width: 2.0),
//                   ),
//                   // borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: Icon(
//                   Icons.sms,
//                   size: 25.0,
//                   color: Colors.lightGreen[400],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(12.0),
//                   height: 50.0,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: Colors.white70,
//                       border: Border(
//                         top: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                         bottom: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                         left: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                         right: BorderSide(
//                             color: Colors.lightGreen[400], width: 2.0),
//                       )),
//                   child: TextField(
//                     onChanged: (result) {
//                       setState(() {
//                         _codeFilter = result;
//                         checkCode(result);
//                       });
//                     },
//                     cursorColor: Colors.lightGreen,
//                     maxLines: 1,
//                     keyboardType: TextInputType.number,
//                     inputFormatters: <TextInputFormatter>[
//                       FilteringTextInputFormatter.digitsOnly,
//                     ],
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.5),
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'SMS Code',
//                       hintMaxLines: 1,
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12.0,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (_displaySmsError)
//             Row(
//               children: [
//                 Text(
//                   _smsError,
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           SizedBox(height: 20.0),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'A code was sent to +243 ',
//                     style: TextStyle(
//                       fontSize: 12.0,
//                       color: Colors.grey,
//                       // fontWeight: FontWeight.bold,
//                       // decoration: TextDecoration.underline,
//                     ),
//                   ),
//                   Text(
//                     _phoneNumber,
//                     style: TextStyle(
//                       fontSize: 12.0,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       // decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10.0),
//               _resendCode
//                   ? Text(
//                       'Select one option below',
//                       style: TextStyle(
//                           fontSize: 13.0,
//                           color: Colors.lightGreen[400],
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic
//                           // decoration: TextDecoration.underline,
//                           ),
//                     )
//                   : Text(
//                       'Did not get the code? \nor wrong number?',
//                       style: TextStyle(
//                           fontSize: 13.0,
//                           color: Colors.lightGreen[400],
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic
//                           // decoration: TextDecoration.underline,
//                           ),
//                     ),
//               SizedBox(height: 3.0),
//               if (_resendCode)
//                 // if the user is allowed to resend code then display this
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _isNumberVisible = true;
//                           _displaySmsError = false;
//                           _displayPhoneError = false;
//                           _displayPhoneSuccess = false;
//                         });
//                       },
//                       child: Text(
//                         'Change your phone number',
//                         style: TextStyle(
//                             fontSize: 13.0,
//                             color: Colors.black,
//                             fontStyle: FontStyle.italic,
//                             fontWeight: FontWeight.bold,
//                             decoration: TextDecoration.underline),
//                       ),
//                     ),
//                   ),
//                 ),
//               if (_resendCode) SizedBox(height: 3.0),
//               _resendCode
//                   ? Container(
//                       alignment: Alignment.centerLeft,
//                       child: MouseRegion(
//                         cursor: SystemMouseCursors.click,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               // print('you clicked on login button');
//                               // after sending a new sms code to user, set the button to false
//                               // so that no any other request will be made
//                               _resendCode = false;
//                               successMessage(context, 'Resending code...');
//                               startTimer();
//                             });
//                           },
//                           child: Text(
//                             'or Send a new SMS code',
//                             style: TextStyle(
//                                 fontSize: 13.0,
//                                 color: Colors.black,
//                                 fontStyle: FontStyle.italic,
//                                 fontWeight: FontWeight.bold,
//                                 decoration: TextDecoration.underline),
//                           ),
//                         ),
//                       ),
//                     )
//                   :
//                   // this is the time counter before allowing next login
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // this will be removed
//                         // RaisedButton(
//                         //   onPressed: () {
//                         //     startTimer();
//                         //   },
//                         //   child: Text("Testing button"),
//                         // ),
//                         // SizedBox(width: 5.0),
//                         Text(
//                           'Code validity: ',
//                           style: TextStyle(
//                             fontSize: 14.0,
//                             color: Colors.grey,
//                             fontStyle: FontStyle.italic,
//                             // fontWeight: FontWeight.bold,
//                             // decoration: TextDecoration.underline,
//                           ),
//                         ),
//                         Text(
//                           minutes + ' Min. : ' + seconds + ' Sec.',
//                           style: TextStyle(
//                             fontSize: 14.0,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             // decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ],
//                     ),
//               if (_resendCode) SizedBox(height: 3.0),
//             ],
//           ),
//           SizedBox(height: 10.0),
//           Container(
//             width: double.infinity,
//             child: RawMaterialButton(
//               padding: new EdgeInsets.symmetric(
//                   vertical:
//                       ResponsiveWidget.isSmallScreen(context) ? 10.0 : 15.0),
//               onPressed: () {
//                 setState(() {
//                   if (_codeFilter.length > 6) {
//                     _displaySmsError = true;
//                     _smsError = 'Code too long';
//                   } else if (_codeFilter.length < 6) {
//                     _displaySmsError = true;
//                     _smsError = 'Code too short';
//                   } else {
//                     // check if the number is still valid
//                     if (checkCode(_smsCode)) {
//                       successMessage(context, 'Checking...');
//                       verifySmsCode(_smsCode).then((value) => () {
//                             if (value) {
//                               // reset everything to false
//                               _displaySmsError = false;
//                               // show the message error
//                               successMessage(context, 'Code Accepted');
//                               // execute the functions here
//                               print('Validation was successfull: $_smsCode');
//                             } else {
//                               // show the message error
//                               failMessage(context, 'Code Rejected');
//                               // execute the functions here
//                               print('Validation was a failure: $_smsCode');
//                             }
//                           });
//                     } else {
//                       // print error
//                       _displaySmsError = true;
//                       _smsError = 'Invalid Code';
//                     }
//                   }
//                   // print('you clicked on login button');
//                   // if the code is valid set user back to home or somewhere else
//                   // _isNumberVisible = true;
//                   // set the resend code to false
//                   // _resendCode = false;
//                   // reset all values to false
//                   _displayPhoneError = false;
//                   _displayPhoneSuccess = false;
//                   _validNumber = false;
//                 });
//               },
//               fillColor: Colors.lightGreen[400],
//               disabledElevation: 5.0,
//               child: Text(
//                 'Verify Code'.toUpperCase(),
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18.0),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   successMessage(BuildContext context, String message) {
//     return Scaffold.of(context).showSnackBar(
//       SnackBar(
//         elevation: 0,
//         backgroundColor: Colors.lightGreen[400],
//         duration: Duration(seconds: 3),
//         content: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               message,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.0),
//             ),
//             // Icon(
//             //   Icons.check,
//             //   size: 25.0,
//             //   color: Colors.white,
//             // )
//           ],
//         ),
//       ),
//     );
//   }

//   failMessage(BuildContext context, String message) {
//     return Scaffold.of(context).showSnackBar(
//       SnackBar(
//         elevation: 0,
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 3),
//         content: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               message,
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14.0),
//             ),
//             // Icon(
//             //   Icons.check,
//             //   size: 25.0,
//             //   color: Colors.white,
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:betLwambo/Responsive/responsive_widget.dart';
// import 'package:betLwambo/app/betLwambo.dart';
// import 'package:betLwambo/mywindow.dart';
// import 'package:flutter/material.dart';

// class ForgotPassword extends StatefulWidget {
//   @override
//   _ForgotPasswordState createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
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
//                 'Reset Password',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.w200,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Divider(color: Colors.grey, thickness: 0.4),
//             SizedBox(height: 15.0),
//             Text(
//               'Enter phone number to reset password.',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 14.0,
//                 // fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 3.0),
//             Text(
//               'You will receive a code shortly',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 13.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
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
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   Window.showWindow = 16;
//                   // Navigator.push(
//                   //     context, MaterialPageRoute(builder: (_) => BetLwambo()));
//                 });
//               },
//               child: Text(
//                 'No Account? Create an Account.',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 13.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 5.0),
//             Divider(color: Colors.grey, thickness: 0.5),
//             SizedBox(height: 15.0),
//             Container(
//               width: double.infinity,
//               child: RawMaterialButton(
//                 padding: new EdgeInsets.all(15.0),
//                 onPressed: () {
//                   setState(() {
//                     print('Reset Clicked.');
//                   });
//                 },
//                 fillColor: Colors.lightGreen[400],
//                 disabledElevation: 3.0,
//                 child: Text(
//                   'Reset Password'.toUpperCase(),
//                   style: TextStyle(
//                       color: Colors.white,
//                       // fontWeight: FontWeight.bold,
//                       fontSize: 18.0),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// addGameToCollection() {
//     // variables declaration
//     // variables declaration
//     var date = new DateTime.now();
//     String min = date.minute < 10
//         ? '0' + date.minute.toString()
//         : date.minute.toString();
//     String hour =
//         date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString();

//     int indicRef = date.hour;
//     String timeIndicator = '';
//     if (indicRef < 12)
//       timeIndicator = 'AM';
//     else
//       timeIndicator = 'PM';

//     String day =
//         date.day < 10 ? '0' + date.day.toString() : date.day.toString();
//     String month =
//         date.month < 10 ? '0' + date.month.toString() : date.month.toString();
//     String year =
//         date.year < 10 ? '0' + date.year.toString() : date.year.toString();
//     int today = date.weekday;

//     String weekday = '';
//     if (today == 1) weekday = 'Mon';
//     if (today == 2) weekday = 'Tue';
//     if (today == 3) weekday = 'Wed';
//     if (today == 4) weekday = 'Thu';
//     if (today == 5) weekday = 'Fri';
//     if (today == 6) weekday = 'Sat';
//     if (today == 7) weekday = 'Sun';
//     // we will be inserting in games and History at the same time

//     Firestore.instance.collection('Games').add({
//       'admin': 'ntavigwa',
//       'bothTeamsToScore': {'1': 1.33, '2': 1.64},
//       'championship': 'Lazio',
//       'cleanSheet': {
//         '1': 2.30,
//         '2': 1.30,
//         '3': 2.18,
//         '4': 1.43,
//       },
//       'country': 'Italy',
//       'date': {
//         '1': 'Sun',
//         '2': '20',
//         '3': '09',
//         '4': '2020',
//       },
//       'dateAdded': {
//         '1': '$weekday',
//         '2': '$day',
//         '3': '$month',
//         '4': '$year',
//       },
//       'drawNoBet': {
//         '1': 1.59,
//         '2': 1.52,
//       },
//       'half': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//         '9': 1.28,
//         '10': 1.29,
//         '11': 1.20,
//       },
//       'isPopular': true,
//       'oddEven': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//       },
//       'oneTimesTwo': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//         '9': 1.28,
//       },
//       'other': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//       },
//       'overUnder': {
//         '1': 1.24,
//         '2': 1.21,
//         '3': 1.22,
//         '4': 1.23,
//         '5': 1.24,
//         '6': 1.25,
//         '7': 1.26,
//         '8': 1.27,
//         '9': 1.28,
//         '10': 1.29,
//         '11': 1.20,
//         '12': 1.20,
//       },
//       'searchKey': ['P', 'N'], // Leeds United - Fulham
//       'status': 'pending',
//       'team1': 'Parma',
//       'team2': 'Napoli',
//       'time': {
//         '1': '09',
//         '2': '30',
//         '3': 'AM',
//       },
//       'timeAdded': {
//         '1': '$hour',
//         '2': '$min',
//         '3': '$timeIndicator',
//       },
//       'type': 'football',
//       'sorter': '20' + '09' + '2020' + '09' + '30',
//       'timestamp': DateTime.now(),
//     }).then((value) {
//       print('id is: ${value.documentID}');
//       print('Game Added successfully and adding to history collection');
//       Firestore.instance.collection('GamesHistory').add({
//         'gameID': value.documentID,
//         'admin': 'ntavigwa',
//         'bothTeamsToScore': {'1': 1.33, '2': 1.64},
//         'championship': 'Lazio',
//         'cleanSheet': {
//           '1': 2.30,
//           '2': 1.30,
//           '3': 2.18,
//           '4': 1.43,
//         },
//         'country': 'Italy',
//         'date': {
//           '1': 'Sun',
//           '2': '20',
//           '3': '09',
//           '4': '2020',
//         },
//         'dateAdded': {
//           '1': weekday,
//           '2': '$day',
//           '3': '$month',
//           '4': '$year',
//         },
//         'drawNoBet': {
//           '1': 1.59,
//           '2': 1.52,
//         },
//         'half': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//           '9': 1.28,
//           '10': 1.29,
//           '11': 1.20,
//         },
//         'isPopular': true,
//         'oddEven': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//         },
//         'oneTimesTwo': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//           '9': 1.28,
//         },
//         'other': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//         },
//         'overUnder': {
//           '1': 1.24,
//           '2': 1.21,
//           '3': 1.22,
//           '4': 1.23,
//           '5': 1.24,
//           '6': 1.25,
//           '7': 1.26,
//           '8': 1.27,
//           '9': 1.28,
//           '10': 1.29,
//           '11': 1.20,
//           '12': 1.20,
//         },
//         'searchKey': ['P', 'N'], // Leeds United - Fulham
//         'status': 'pending',
//         'team1': 'Parma',
//         'team2': 'Napoli',
//         'time': {
//           '1': '09',
//           '2': '30',
//           '3': 'AM',
//         },
//         'timeAdded': {
//           '1': '$hour',
//           '2': '$min',
//           '3': '$timeIndicator',
//         },
//         'type': 'football',
//         'sorter': '20' + '09' + '2020' + '09' + '30',
//         'timestamp': DateTime.now(),
//         'resultBothTeamsToScore': [null, null],
//         'resultOddEven': [null, null, null, null, null, null, null, null],
//         'resultHalf': [
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null,
//           null
//         ],
//         'resultCleanSheet': [null, null, null, null],
//         'resultDrawNoBet': [null, null],
//         'resultOther': [null, null, null, null, null, null]
//       }).then((value) {
//         print('Game History Added successfully');
//       }).catchError((e) {
//         print('Could not add game : Error : $e');
//       });
//     }).catchError((e) {
//       print('Could not add game : Error : $e');
//     });
//   }

//   printAllOut() {
//     // print all variables out
//     print('Championship: $championship');
//     print('Country: $country');
//     print('Type: $type');
//     print('Team 1: $team1');
//     print('Team 2: $team2');
//     print('Search Key 1: $searchKey1');
//     print('Search Key 2: $searchKey2');
//     print('WeekDay: $weekday');
//     print('Time Indicator: $timeIndicator');
//     print('Day: $day');
//     print('Month: $month');
//     print('Year: $year');
//     print('Hour: $hour');
//     print('Minutes: $minutes');
//     print('1x2 1: $oneTimes2_1');
//     print('1x2 x: $oneTimesTwoDraw');
//     print('1x2 2: $oneTimes2_2');
//     print('1x2 1-1: $oneTimes2_1_1');
//     print('1x2 1-X: $oneTimesTwo_1Draw');
//     print('1x2 1-2: $oneTimes2_1_2');
//     print('1x2 2-1: $oneTimes2_2_1');
//     print('1x2 2-X: $oneTimesTwo_2Draw');
//     print('1x2 2-2: $oneTimes2_2_2');
//     print('BTS YES: $btscoreYes');
//     print('BTS NO: $btscoreNo');
//     print('Clean Sheet1 Yes: $cleanSheet_1Yes');
//     print('Clean Sheet1 No: $cleanSheet_1No');
//     print('Clean Sheet2 Yes: $cleanSheet_2Yes');
//     print('Clean Sheet2 No: $cleanSheet_2No');
//     print('DNB 1: $drawNoBetFullTime_1');
//     print('DNB 2: $drawNoBetFullTime_2');
//     print('Half With More Goals 1: $halfWIthMoreGoals_1');
//     print('Half With More Goals 2: $halfWIthMoreGoals_2');
//     print('Half With More Goals X: $halfWIthMoreGoalsEqual');
//     print('Team 1 WEH Yes: $team1WinEitherHalfYes');
//     print('Team 1 WEH No: $team1WinEitherHalfNo');
//     print('Team 2 WEH Yes: $team2WinEitherHalfYes');
//     print('Team 2 WEH No: $team2WinEitherHalfNo');
//     print('Team 1 SBH Yes: $team1ScoreInBothHalvesYes');
//     print('Team 1 SBH No: $team1ScoreInBothHalvesNo');
//     print('Team 2 SBH Yes: $team2ScoreInBothHalvesYes');
//     print('Team 2 SBH No: $team2ScoreInBothHalvesNo');
//     print('Over 0.5: $over0_5');
//     print('Under 0.5: $under0_5');
//     print('Over 1.5: $over1_5');
//     print('Under 1.5: $under1_5');
//     print('Over 2.5: $over2_5');
//     print('Under 2.5: $under2_5');
//     print('Over 3.5: $over3_5');
//     print('Under 3.5: $under3_5');
//     print('Over 4.5: $over4_5');
//     print('Under 4.5: $under4_5');
//     print('Over 5.5: $over5_5');
//     print('Under 5.5: $under5_5');
//     print('FT ODD: $ftOdd');
//     print('FT EVEN: $ftEven');
//     print('TEAM 1 ODD: $team1Odd');
//     print('TEAM 1 EVEN: $team1Even');
//     print('TEAM 2 ODD: $team2Odd');
//     print('TEAM 2 EVEN: $team2Even');
//     print('1x2 - BTS 1 YES: $oneYes');
//     print('1x2 - BTS 1 NO: $oneNo');
//     print('1x2 - BTS 2 YES: $twoYes');
//     print('1x2 - BTS 2 No: $twoNo');
//     print('1x2 - BTS X YES: $drawYes');
//     print('1x2 - BTS X No: $drawNo');
//   }
// }
