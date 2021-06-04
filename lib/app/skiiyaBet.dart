import 'dart:ui';
import 'package:skiiya_admin/account/login.dart';
import 'package:skiiya_admin/admin/addGame/add.dart';
import 'package:skiiya_admin/admin/addScore/addScore.dart';
import 'package:skiiya_admin/admin/dashboard/dashboard.dart';
import 'package:skiiya_admin/admin/userWithdraw/userwithdraw.dart';
import 'package:skiiya_admin/encryption/encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiya_admin/Responsive/responsive_widget.dart';
import 'package:skiiya_admin/database/betslip.dart';
import 'package:skiiya_admin/database/selection.dart';
import 'package:skiiya_admin/mywindow.dart';
import 'package:skiiya_admin/account/forgot.dart';
import 'package:skiiya_admin/account/resetUpdate.dart';
import 'package:skiiya_admin/account/update.dart';
import 'package:skiiya_admin/admin/updateGame/updateGame.dart';
import 'package:skiiya_admin/admin/contact/updateContact.dart';
import 'package:skiiya_admin/admin/rewards/rewards.dart';
import 'package:http/http.dart' as http;

// create a variable that loads game details
DocumentSnapshot matchMoreOdds;
Color color, colorBg, colorRounded, colorCaption;
int _selectedIndex = 0;
// store loaded games
var data = [];
// this array contains
var loadSideDataArrayChamp = [];
var loadSideDataArrayCountry = [];
// this variable indicated which field should have load more
int fieldLoadMore = 0;
// display the betslip error message
bool _displayTextError = false;
bool _displayTextMaxError = false;
// variable from search panel
// store loaded results
var _queryResults = [];
// store filtered results
var _queryDisplay = [];
// check weither input is empty or not to display no data found
bool _isQueryEmpty = true;
// this variable display betting slip error message
bool showBetslipMessagePanel = false;
String showBetslipMessage = '';
// color to show along with the message
Color showBetslipMessageColor = Colors.red;
Color showBetslipMessageColorBg = Colors.red[100];
// bool _resendCode = false;
FirebaseAuth _auth = FirebaseAuth.instance;
// boolean that displays the loading process.. on buttons
bool _loadingBettingButton = false;

class SkiiyaBet extends StatefulWidget {
  @override
  _SkiiyaBetState createState() => _SkiiyaBetState();
}

class _SkiiyaBetState extends State<SkiiyaBet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: true,
      body: GestureDetector(
        onTap: () {
          if (mounted)
            setState(() {
              FocusScope.of(context).requestFocus(new FocusNode());
              // print('clicked');
            });
        },
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topAppBar(context),
            ],
          ),
        ),
      ),
    );
  }

  topAppBar(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: ResponsiveWidget.isSmallScreen(context) ? 40.5 : 60.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: Column(
            children: [
              if (!ResponsiveWidget.isSmallScreen(context))
                Container(
                  height: ResponsiveWidget.isSmallScreen(context) ? 50.0 : 59.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width) * 0.80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // This contains the title of the whole page
                            Container(
                              alignment: Alignment.center,
                              padding: ResponsiveWidget.isSmallScreen(context)
                                  ? EdgeInsets.symmetric(horizontal: 10.0)
                                  : EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Skiiya'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 3.0),
                                  Text(
                                    'Bet'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 3.0),
                                  Text(
                                    'Admin'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // this contains the admin menu list [dashboard, add game, add results, etc.]
                            Row(
                              children: _topMenu
                                  .asMap()
                                  .entries
                                  .map(
                                    (MapEntry map) => myTopMenu(
                                      map.key,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      // it contains the login button / link and the logout button once logged in
                      Container(
                        alignment: Alignment.centerRight,
                        padding: new EdgeInsets.only(right: 10.0),
                        width: (MediaQuery.of(context).size.width) * 0.20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // scrollDirection: Axis.horizontal,
                          children: [
                            if (ResponsiveWidget.isLargeScreen(context) ||
                                ResponsiveWidget.customScreen(context) ||
                                ResponsiveWidget.isMediumScreen(context))
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 10.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.grey, width: 1.5))),
                                  // child: IconButton(
                                  //     icon: Icon(Icons.notifications), onPressed: null),
                                ),
                              ),
                            // SizedBox(width: 10.0),
                            // isUserLoggedIn
                            (Selection.user != null)
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width: 2.0),
                                      Text(
                                        Selection.userTelephone.toString(),
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        width: 2.0,
                                      ),
                                      IconButton(
                                          tooltip: 'Log Out',
                                          icon: Icon(Icons.logout,
                                              color: Colors.red, size: 25.0),
                                          onPressed: () {
                                            if (mounted)
                                              setState(() {
                                                Window.showWindow = 0;
                                                Login.doLogout();
                                              });
                                          })
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (mounted)
                                        setState(() {
                                          // on click display the login button
                                          // redirect to login page
                                          Window.showWindow = 8;
                                        });
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Selection.userTelephone
                                                  .toString()
                                                  .compareTo('') ==
                                              0
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Adhérer Ici'.toUpperCase(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                                !ResponsiveWidget
                                                        .isMediumScreen(context)
                                                    ? Text(
                                                        'Connexion',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                                    : Text(
                                                        'Connectez-Vous Ici',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      )
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Chargement...',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 11.0,
                                                  ),
                                                ),
                                                SizedBox(height: 3.0),
                                                SpinKitCubeGrid(
                                                  color: Colors.lightGreen[400],
                                                  size: 18.0,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              if (ResponsiveWidget.isSmallScreen(context))
                Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  margin: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _topMenu
                        .asMap()
                        .entries
                        .map(
                          (MapEntry map) => myTopMenu(
                            map.key,
                          ),
                        )
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
        appBody(context),
      ],
    );
  }

  List<String> _topMenu = [
    'Dashboard',
    'Add Match',
    'Update Match Details',
    'Add Game Score',
    'Withdrawals Request',
    'Update Password',
    'Prices and Rewards',
    'Update Skiiya Contact',
  ];

  Widget myTopMenu(int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (mounted)
            setState(() {
              Window.showJackpotIndex = index;
              if (Window.showJackpotIndex == 0) {
                Window.selectedMenu = 1;
                Window.showWindow = 0; // Dashboard
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
              }
              if (Window.showJackpotIndex == 1) {
                Window.showWindow = 1; // add new Game
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
                // Window.showWindow = 2; // show jackpot panel
              }
              if (Window.showJackpotIndex == 2) {
                Window.showWindow = 2; // Update game Details
              }
              if (Window.showJackpotIndex == 3) {
                Window.showWindow = 3; // add game Results
              }
              if (Window.showJackpotIndex == 4) {
                Window.showWindow = 4; // Withdrawals
              }
              if (Window.showJackpotIndex == 5) {
                Window.showWindow = 5; // Update Password
              }

              if (Window.showJackpotIndex == 6) {
                Window.showWindow = 6; // Update Contact
              }
              if (Window.showJackpotIndex == 7) {
                // rewards section
                Window.showWindow = 7; // Prices and Rewards
              }
            });
        },
        child: Container(
          padding: new EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
              bottom: Window.showJackpotIndex == index
                  ? BorderSide(
                      color: Colors.lightGreen[400],
                      width:
                          ResponsiveWidget.isSmallScreen(context) ? 4.0 : 3.0,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Text(
            _topMenu[index],
            style: TextStyle(
              color:
                  Window.showJackpotIndex == index ? Colors.black : Colors.grey,
              fontSize: 12.0,
              fontWeight: Window.showJackpotIndex == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget appBody(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: ResponsiveWidget.isSmallScreen(context)
              // web view and padding limits
              ? MediaQuery.of(context).size.height - 100.0 - 55.5
              // mobile view and padding limit
              // ? MediaQuery.of(context).size.height - 100.0 - 55.5 - 40.0
              : MediaQuery.of(context).size.height - 60.0,
          padding: ResponsiveWidget.isLargeScreen(context)
              ? EdgeInsets.all(20.0)
              : EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
          decoration: BoxDecoration(color: Colors.white70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    // SizedBox(height: 10.0),
                    // if no button has been clicked so far then.
                    _changeWindow(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String selectedMobileTopItem = '';

  _changeWindow(BuildContext context) {
    int val = Window.showWindow;
    if (val == 0) {
      // show dashboard Panel
      return Dashboard();
    } else if (val == 1) {
      // show add new game Panel
      return AddNewGame();
    } else if (val == 2) {
      // show update game details Panel
      return UpdateGameDetails();
    } else if (val == 3) {
      // show add game score panel
      return AddGameScore();
    } else if (val == 4) {
      // show user withdraw panel
      return UserWithdraw();
    } else if (val == 5) {
      // show update admin password panel
      return UpdatePassword();
    } else if (val == 6) {
      // show skiiya contact panel
      return PriceAndRewards();
    } else if (val == 7) {
      // show contact panel
      return UpdateContact();
    } else if (val == 8) {
      // show contact panel
      return Login();
    } else if (val == 9) {
      return ForgotPassword();
    } else if (val == 10) {
      return RecoverPassword();
    } else {
      return Dashboard();
      // return games();
    }
  }

  @override
  void initState() {
    // this match check weither matches are still available or have expired
    // checkMatchValidity();
    // New methods loading...
    // placed here because this widget execute only once
    // this method helps us to detect if a certain user was already logged in
    if (mounted)
      setState(() {
        // reload from existing session and set new values
        // logged the user in if existed before
        reLoginUser(); // uncomment after coding
      });
    // this loadingGames method load only once at first lunch
    // loadingGames(fieldLoadMore);
    // loadSideData();
    super.initState();
  }

  bool isNoInternetNetwork = false;
  // bool isNoInternetNetworkOrOtherError = false;

  void checkInternet() async {
    try {
      final response =
          await http.get('https://jsonplaceholder.typicode.com/albums/1');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        // print('fetched successfully');
        isNoInternetNetwork = false;
      } else {
        // If the server did not return a 200 OK response,
        // if there is an error
        if (mounted)
          setState(() {
            // print('failed to load data');
            isNoInternetNetwork = true;
          });
        // then throw an exception.
        // throw Exception('Failed to load album');
      }
    } catch (e) {
      if (mounted)
        setState(() {
          // clear the array so the condition can be reached
          // data.clear();
          // if there is an error based on network
          isNoInternetNetwork = true;
          // print('network error is: $e');
        });
    }
  }

  // sesssion management
  reLoginUser() async {
    var session = FlutterSession();
    // await session.set("email", null);
    String userID = await session.get("sB1");
    String userID1 = await session.get("sB2");
    String customID = await session.get("sB3");
    String customID1 = await session.get("sB4");
    // LocalStorage storage = new LocalStorage('SKIIYA_BET');
    // print(Selection.user.uid);
    // if (email.compareTo('null') != 0) {
    //   if (id1.compareTo('null') != 0) {
    //     if (id2.compareTo('null') != 0) {
    // print('data logins is different from null');
    // print('Phone: $userID$userID1 and Passcode: $customID$customID1');
    // RELOGGIN THE USER IF NO USER IS FOUND
    if (Selection.user == null) {
      if (userID == null ||
          userID1 == null ||
          customID == null ||
          customID1 == null) {
        // print('values are null, No relogin will be made');
      } else {
        // print('login process started');
        doSessionUserLogin((userID + userID1), (customID + customID1));
      }
    }
    //  else {
    //   print('User logged in already');
    // }
    //     }
    //   }
    //   // else {
    //   //   print('password is empty $password');
    //   // }
    // }
  }

  doSessionUserLogin(String telephone, String passCode) async {
    // String code = '243';
    checkInternet();
    String congoCode = '243';
    // print('The telephone is: $telephone');
    // print('The passcode is: $passCode');
    String phone =
        Encryption.decryptAESCryptoJS(telephone, 'SKIIYA001_Telephone');
    String email = congoCode + phone + '@gmail.com';
    String pass = Encryption.decryptAESCryptoJS(passCode, phone);
    // print('login has been reached and phone is $phone');
    // print('login has been reached and email is $email');
    // print('login has been reached and code is $code');
    // String email =
    //     Encryption.decryptAESCryptoJS(generatedEmail, generatedEmail);
    // String email = generatedEmail;
    await _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((result) {
      Selection.user = result.user;
      // store credentials to session
      // setSessionLogin(phone.toString(), passCode.toString());
      // save the current user into the local storage for upcoming connection
      // get the right user balance and the right user phone number
      Firestore.instance
          .collection('UserBalance')
          .document(result.user.uid)
          .get()
          .then((_result) {
        if (mounted)
          setState(() {
            // String id = _result.documentID.toString();
            // print('the ID is $id');
            Selection.userTelephone = '0' + phone;
            Selection.userBalance = _result['balance'];
            // successMessage(context, 'Login Success!');
            // hide all messages error based
            isNoInternetNetwork = false;
            // isNoInternetNetworkOrOtherError = false;
          });
      }).catchError((e) {
        // print('error: $e');
      });
    }).catchError((e) {
      if (mounted)
        setState(() {
          if (e.toString().compareTo(
                  'FirebaseError: A network error (such as timeout, interrupted connection or unreachable host) has occurred. (auth/network-request-failed)') ==
              0) {
            // display internet connection problems
            isNoInternetNetwork = true;
          } else {
            // show other error messages
            isNoInternetNetwork = false;
          }
        });
    });
  }
}
