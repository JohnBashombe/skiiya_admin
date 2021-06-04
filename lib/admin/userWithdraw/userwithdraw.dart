import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiya_admin/database/selection.dart';

class UserWithdraw extends StatefulWidget {
  @override
  _UserWithdrawState createState() => _UserWithdrawState();
}

class _UserWithdrawState extends State<UserWithdraw> {
  // LOADING ACTION BUTTON
  bool _showLoadingButton = false;
  // STORE ALL ACTIVE WITHDRAW REQUESTS
  var _wRequest = [];
  // THIS WILL CONTAIN A SINGLE REQUEST
  var _singleRequest;

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
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  'WITHDRAW REQUESTS'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 0.5),
                                SizedBox(height: 15.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          // load request by date-time
                                          print('load request by date-time');
                                          // LOAD DATA BY DATE AND TIME
                                          loadWithdrawRequestByDateTime();
                                        },
                                        child: Text('Filter by Date-Time',
                                            style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          print('load request by amount');
                                          // LOAD DATA BY AMOUNT
                                          loadWithdrawRequestByAmount();
                                        },
                                        child: Text('Filter by Big Amount',
                                            style: TextStyle(
                                              color: Colors.lightBlue,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                // Divider(
                                //     color: Colors.grey.shade300,
                                //     thickness: 0.5),
                                SizedBox(height: 5.0),
                                // ONLY PRINT ITEM IF WE HAVE DATA AVAILABLE
                                if (_wRequest.length > 0)
                                  for (int _i = 0; _i < _wRequest.length; _i++)
                                    individualRequest(_wRequest[_i]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Text(
                                  'REQUEST DETAILS'.toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 0.5),
                                SizedBox(height: 5.0),
                                // DISPLAY THIS BUTTON ONLY IF WE HAVE DATA
                                if (_singleRequest != null)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _singleRequest['time']['date']
                                                .toString() +
                                            '\n' +
                                            _singleRequest['time']['time']
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        _singleRequest['currency'].toString() +
                                            ' ' +
                                            _singleRequest['amount'].toString(),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        _singleRequest['phone'].toString(),
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                // Text('Will hold all request details'),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          // DISPLAY THIS BUTTON ONLY IF WE HAVE DATA
                          if (_singleRequest != null)
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'AUTHORISING REQUEST',
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
                                            // fetchPendingBetslips();
                                            // WITHDRAW API REQUEST FOR WITHDRAW WILL BE IMPLEMENTED HERE
                                            // print('WITHDRAW API REQUEST FOR WITHDRAW WILL BE IMPLEMENTED HERE');
                                            validateRequest(_singleRequest);
                                          });
                                      },
                                      fillColor: Colors.lightGreen[400],
                                      disabledElevation: 5.0,
                                      child: Text(
                                        'AUTHORISE REQUEST',
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
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // WE FIRST OF ALL LOAD ALL REQUESTS THAT ARE STILL ACTIVE
    loadWithdrawRequestByDateTime();
    super.initState();
  }

  void loadWithdrawRequestByAmount() {
    // START BY LOADING ALL WITHDRAW REQUESTS
    Firestore.instance
        .collection('withdraw')
        .where('status', isEqualTo: 'pending')
        .orderBy('amount', descending: true)
        .getDocuments()
        .then((_withdrawRequest) {
      // CONDITIONS GOES HERE
      if (_withdrawRequest.documents.isNotEmpty) {
        if (mounted)
          setState(() {
            // CLEAR ALL CONTENTS BEFORE ADDING NEW ONES
            _wRequest.clear();
            // SET THE SINGLE REQUEST TO NULL
            _singleRequest = null;
            // ALL ALL FETCHED REQUEST INTO THE ARRAY
            _wRequest.addAll(_withdrawRequest.documents);
          });
      }
    }).catchError((e) {
      print('Was unable to load withdraw request : Error : $e');
    });
  }

  void loadWithdrawRequestByDateTime() {
    // START BY LOADING ALL WITHDRAW REQUESTS
    Firestore.instance
        .collection('withdraw')
        .where('status', isEqualTo: 'pending')
        .orderBy('time.date_time', descending: false)
        .getDocuments()
        .then((_withdrawRequest) {
      // CONDITIONS GOES HERE
      if (_withdrawRequest.documents.isNotEmpty) {
        if (mounted)
          setState(() {
            // CLEAR ALL CONTENTS BEFORE ADDING NEW ONES
            _wRequest.clear();
            // SET THE SINGLE REQUEST TO NULL
            _singleRequest = null;
            // ALL ALL FETCHED REQUEST INTO THE ARRAY
            _wRequest.addAll(_withdrawRequest.documents);
          });
      }
    }).catchError((e) {
      print('Was unable to load withdraw request : Error : $e');
    });
  }

  individualRequest(var wRequest) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.0),
        Divider(color: Colors.grey.shade300, thickness: 0.5),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              wRequest['time']['date'].toString() +
                  '\n' +
                  wRequest['time']['time'].toString(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              wRequest['currency'].toString() +
                  ' ' +
                  wRequest['amount'].toString(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              wRequest['phone'].toString(),
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: 30.0,
              child: RawMaterialButton(
                // padding:
                //     new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                onPressed: () {
                  if (mounted)
                    setState(() {
                      // WE SET THE CURRENT DETAILS REQUEST TO THIS DATA
                      _singleRequest = wRequest;
                    });
                },
                fillColor: Colors.lightGreen[400],
                disabledElevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Divider(color: Colors.grey.shade300, thickness: 0.5),
        SizedBox(height: 5.0),
      ],
    );
  }

  void validateRequest(singleRequest) {
    // IMPLEMENTATION OF THE WITHDRAW API
    print('WITHDRAW API REQUEST FOR WITHDRAW WILL BE IMPLEMENTED HERE');
  }
}
