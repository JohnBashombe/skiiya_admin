import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiya_admin/database/selection.dart';

class PriceAndRewards extends StatefulWidget {
  // BOOL TO SHOW LOADING ACTION BUTTON
  @override
  _PriceAndRewardsState createState() => _PriceAndRewardsState();
}

class _PriceAndRewardsState extends State<PriceAndRewards> {
  bool _showLoadingButton = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: new EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
          )),
          child: Selection.user == null
              ? Center(
                  child: Text(
                    'Please! Login First',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'REWARDS USERS WITH COMPLETED TICKETS '.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: double.infinity,
                      child: _showLoadingButton
                          ? RawMaterialButton(
                              padding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              onPressed: null,
                              fillColor: Colors.lightGreen[400],
                              disabledElevation: 5.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'REWARDING USERS WITH WON TICKETS'
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                  SizedBox(width: 5.0),
                                  SpinKitCircle(
                                    color: Colors.white,
                                    size: 18.0,
                                  )
                                ],
                              ),
                            )
                          : RawMaterialButton(
                              padding: new EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 15.0),
                              onPressed: () {
                                if (mounted)
                                  setState(() {
                                    // SHOW LOADING BUTTON
                                    _showLoadingButton = true;
                                    // UPDATE BETSLIPS WITH RESULTS
                                    fetchPendingBetslips();
                                  });
                              },
                              fillColor: Colors.lightGreen[400],
                              disabledElevation: 5.0,
                              child: Text(
                                'REWARDS WON TICKETS'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void fetchPendingBetslips() {
    // print('Fetching pending betslip');
    // FETCH BETSLIPS WITH PENDING STATUS ONLY
    Firestore.instance
        .collection('betslip')
        .where('status', isEqualTo: 'pending')
        .where('update_status', isEqualTo: 'pending')
        .getDocuments()
        .then((_pendBetslip) {
      // CONDITIONS OF REWARDING STARTS HERE
      if (_pendBetslip.documents.isNotEmpty) {
        // LOOP THROUGH ALL DOCUMENTS TO VIEW THEM
        for (int _i = 0; _i < _pendBetslip.documents.length; _i++) {
          // print(_pendBetslip.documents[_i].documentID);
          // print(_pendBetslip.documents[_i].data);
          // print('-------------------------------------------');
          // WE START GEETING THE RESULTS FROM RESULTS ARRAY AND SEE IF WE CAN UPDATE THEM SUCCESSFULLY
          updateIndividualBetslipResults(_pendBetslip.documents[_i]);
          // FOR TESTING PURPOSES
          // break;
        }
      }
      // else {
      //   // DO NOTHING IF IT IS EMPTY
      //   print('No betslip to update result right now');
      // }
      if (mounted)
        setState(() {
          // SET THE LOADING ACTION BUTTON TO FALSE
          _showLoadingButton = false;
        });
    }).catchError((e) {
      // PRINTING OUT THE ERROR
      print('could not fetch the pending betslip : Error: $e');
    });
  }

  void updateIndividualBetslipResults(var _data) {
    // LET US STORE OUR RESULTS IN A SAFE VARIABLE
    var _ourResults = _data['matches']['teamResults'];
    // GET THE CURRENT BETSLIP ID
    String _betslipID = _data.documentID.toString();
    // print('Updating this current betslip ${_data.documentID}');
    // THIS WILL INDICATES WEITHER THE TICKET IS WON OR LOAST OR STILL PENDING
    int _isTicketWon = -1; // WON STATUS
    int _isTicketLost = -1; // LOST STATUS
    int _isTicketPending = -1; // PENDING STATUS
    // LET US LOOP THROUGH ALL DATA RESULTS
    for (int _j = 0; _j < _ourResults.length; _j++) {
      // CONDITIONS TO CHECK FOR SUCCESSFULL MATCHES OR UNSUCCESSFULL
      if (_ourResults[_j] == false) {
        // THE TICKET IS LOAST IF AT LEAST ONE VALUE IS FALSE
        // SET THE VALUE TO NOT ELIGIBLE TO UPDATE THE RESULTS POSITIVELY
        _isTicketLost++;
        // WE BREAK THE LOPP SINCE NO ADDITIONAL INFORMATION IS NEEDED HERE
        break;
      } else if (_ourResults[_j] == null) {
        // IT MEANS WE STILL HAVE PENDING RESULTS SO DO NOTHING
        // SET THE VALUE TO NOT ELIGIBLE TO UPDATE THE RESULTS POSITIVELY
        _isTicketPending++;
        // WE CANNOT BREAK THE LOOP
      } else if (_ourResults[_j] == true) {
        // IT MEANS WE STILL HAVE PENDING RESULTS SO DO NOTHING
        // print('The result here is true');
        // SET THE VALUE CURRENT INDEX
        _isTicketWon++;
      }
    }

    if (_isTicketWon == (_ourResults.length - 1)) {
      // print(
      //     'THIS BETSLIP : $_betslipID HAVE BEEN WON THE AMOUNT : ${_data['rewards']['payout']}');
      // IF RESULTS IS EQUAL TO THE NUMBER OF GAMES
      // ON SUCCESSFULL COMPLETION, REWARD THE USER WITH THE CURRENT AMOUNT
      // LET US GET THE AMOUNT TO REWARD
      double _reward = _data['rewards']['payout'];
      // GET THE CURRENCY SYMBOL
      String _currency = _data['rewards']['currency'].toString();
      // LET US GET THE USER ID
      String _uid = _data['uid'].toString();
      // UPDATE THE BETSLIP WITH A WON STATUS
      Firestore.instance.collection('betslip').document(_betslipID).updateData(
        {'status': 'won', 'update_status': 'completed'},
      ).then((value) {
        // REWARD THE USER BY INCREMENTING HIS ACCOUNT BY THE PAYOUT AMOUNT
        Firestore.instance
            .collection('UserBalance')
            .document(_uid)
            .updateData({'balance': FieldValue.increment(_reward)}).then((_) {
          // ADD THE TRANSACTION RECORD TO THE USER ACCOUNT
          addNewTransaction(_uid, 'Gain du ticket', _reward, _currency, '+')
              .catchError((e) {
            print('error while adding transaction: $e');
          });
        }).catchError((e) {
          print('error while updating user balance: $e');
        });
        // PRINT SUCCESS MESSAGE
        // print(
        //     'This ticket $_betslipID has been won and reward is given to $_uid');
      }).catchError((e) {
        print('Was unable to update the result to won');
      });
    }
    // PENDING TICKET DO NOTHING
    else if (_isTicketPending != -1 && _isTicketLost == -1) {
      // FOR PENDING RESULTS WITH NO LOSS STATUS, DO NOTHING
      // IF WE HAVE NO LOST DATA AND SOME PENDING DATA
      // print('The ticket is not lost yet and has pendings');
    }
    // LOSS TICKET SET TO LOST
    else if (_isTicketLost != -1) {
      // IF THE TICKET IS LOST
      // print('This ticket has been lost for real');
      // UPDATE THE BETSLIP WITH A LOSS STATUS
      Firestore.instance.collection('betslip').document(_betslipID).updateData(
        {'status': 'lost', 'update_status': 'completed'},
      ).then((value) {
        print('This ticket $_betslipID has been lost, no reward will given');
      }).catchError((e) {
        print('Was unable to update the result to loss');
      });
    }
    // print('The results are: $_ourResults');
    // print('--------------------------------------------------');
  }

  static Future addNewTransaction(String _uid, String _type, double _amount,
      String _currency, String _actionSign) {
    // WE GET THE USER ID
    // String _uid = Selection.user.uid;
    // print('Transaction details');
    // print(_type);
    // print(_amount);
    // print('-----------------------------------');
    // GET THE CURRENT DATE TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // STORE THE TIMESTAMP
    int _timestamp = _datetime.toUtc().millisecondsSinceEpoch;

    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    String _date = _getDate();
    // WE GET THE CUSTOM TIME HERE
    var _time = _getTime();

    // ADDING THE RECORDS TO THE COLLECTION OF TRANSACTIONS
    return Firestore.instance.collection('Transactions').add({
      'uid': _uid,
      'amount': _amount,
      'type': _type,
      'action_sign': _actionSign,
      'currency': _currency,
      'time': {
        'time': '$_time',
        'date': '$_date',
        'date_time': '$_datetime',
        'timestamp': _timestamp,
        'timezone': 'UTC',
        'created': FieldValue.serverTimestamp(),
      },
    });
  }

  static String _getTime() {
    // GET CURRENT TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // GET MINUTE IN A CUSTOM FORMAT
    String _minute = _formatOf10(_datetime.minute);
    // GET HOUR IN A CUSTOM FORMAT
    String _hour = _formatOf10(_datetime.hour);
    // GET SECOND IN A CUSTOM FORMAT
    String _second = _formatOf10(_datetime.second);
    // RETURN A STRING IN TIME FORMAT
    return _hour + ':' + _minute + ':' + _second;
  }

  static String _getDate() {
    // GET CURRENT TIME IN UTC FORMAT
    var _datetime = new DateTime.now().toUtc();
    // WE ADD OUR CUSTOM DATE FORMAT TO VARIABLES
    // WE GET THE DAY
    String _day = _formatOf10(_datetime.day);
    // WE GET THE MONTH
    String _month = _formatOf10(_datetime.month);
    // WE GET THE YEAR
    String _year = _datetime.year.toString();
    // RETURN A STRING IN DATE FORMAT
    return _day + '-' + _month + '-' + _year;
  }

  static String _formatOf10(int _newVal) {
    // WE CREATE AN EMPTY VALUE
    String _val = _newVal.toString();
    // IF THE VALUE IS LESS THAN 10 ADD A ZERO BEFORE
    // OTHERWISE DO NOT ADD ANYTHING BEFORE THE VALUE
    if (_newVal < 10) _val = '0' + _newVal.toString();
    // RETURN THE MODIFIED VALUE
    return _val;
  }
}
