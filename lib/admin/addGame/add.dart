import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiya_admin/admin/addGame/fetch/apiMatch.dart';
import 'package:skiiya_admin/admin/addGame/fetch/countries.dart';
import 'package:skiiya_admin/admin/addGame/fetch/leagues.dart';
import 'package:skiiya_admin/database/selection.dart';
import 'package:flutter/material.dart';

// Store all fetched matches and ready-to-use
var _matches = [];
// Instance of Fetchmatch class to access methods
FetchMatch _fetchMatch = new FetchMatch();
// Instance of Leagues class to access methods
Leagues _leagues = new Leagues();
// Instance of Countries class to access methods
Countries _countries = new Countries();
// Will stoore the user variable
FirebaseUser user;
// THE LOADER FOR ADDING MATCHES ACTION BUTTON
bool _addingMatchLoader = false;
// TRACK IF WE HAVE NEW RESULTS FROM THE API
int _newData = 0;

class AddNewGame extends StatefulWidget {
  const AddNewGame({Key key}) : super(key: key);

  @override
  _AddNewGameState createState() => _AddNewGameState();
}

class _AddNewGameState extends State<AddNewGame> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: new EdgeInsets.only(left: 15.0),
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
                  children: [
                    Text(
                      'Load new more games'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    if (_newData != 0)
                      GestureDetector(
                        onTap: () {
                          if (mounted)
                            setState(() {
                              _newData = 0;
                            });
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Divider(color: Colors.grey),
                              SizedBox(height: 10.0),
                              if (_newData == 1)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check,
                                        color: Colors.green.shade300,
                                        size: 20.0),
                                    Text(
                                      'Games list have been successfully updated',
                                      style: TextStyle(
                                        color: Colors.green.shade300,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              if (_newData == 2)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.close,
                                        color: Colors.red.shade300, size: 20.0),
                                    Text(
                                      'No new games have been found from the API',
                                      style: TextStyle(
                                        color: Colors.red.shade300,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 5.0),
                              Text(
                                'Click on this message to close it',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Divider(color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      child: _addingMatchLoader
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
                                    'GETTING NEW GAMES'.toUpperCase(),
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
                                    if (Selection.user != null) {
                                      // ADD MATCH BY SHOWING THE LOADING BUTTON
                                      _addingMatchLoader = true;
                                      // print('adding the game to database');
                                      print(
                                          'We will load more new games if any.');
                                      print('The user has logged in here');
                                      loadInitialMethods();
                                    } else {
                                      print('No User has been detected');
                                    }
                                  });
                              },
                              fillColor: Colors.lightGreen[400],
                              disabledElevation: 5.0,
                              child: Text(
                                'LOAD NEW GAMES'.toUpperCase(),
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

  // @override
  // void initState() {
  //   // INITIALIZE ALL METHODS HERE
  //   super.initState();
  // }

  loadInitialMethods() {
    // THIS LOADS MATCHES BASED ON PROVIDED DATES
    loadMatchesByDates();
    // FECTH ALL LEAGUES AFTER FECTHING MATCHES FOR THE USER ID
    _leagues.fetchLeagues();
    // FECTH ALL COUNTRIES
    _countries.fetchCountries();
  }

  // LOAD MATCHES BY SPECIFIC DATES
  loadMatchesByDates() {
    // WE GET THE UTC DATE AND TIME
    // LET GET THE CURRENT DATE
    DateTime _todayDate = DateTime.now();
    // GIVEN THAT WE WILL BE FORCED TO LOAD MATCHES RESULTS OF LATE GAME OF YESTERDAY
    // WE SHOULD ADD A FUNCTIONALITY TO BE CHECKING FOR RESULTS AND UPDATES MATCHES RESULTS FOR ALL GAMES
    // TODAY DATE FOR MATCHES TO BE LOADED
    //
    // WE DO THIS BECAUSE OF THE YESTERDAY LATE MATCHES AND WE KNOW TO GET THEIR RESULTS
    // THAT'S WHY WE GO BACK ONE DAY TO LOAD THE CONTENT THEN KEEP ON WITH THE TODAY DATE
    // AND THE NEXT DAY AND AFTER NEXT DAY
    //
    // LOAD MATCHES FROM YESTERDAY AND TWO DAYS AFTER TODAYS
    // YESTEDAY - TODAY - TOMORROW - AFTER TOMORROW
    // THIS COUNT THE NUMBER OF DAYS TO BE CONSIDERED
    int maxDaysCount = 4;
    // WE SET THE DAY TO YESTERDAY AND MAKING SURE IT RETURN TO YESTERSDAY
    // if today = 01/02/2021 => Yesterday = 31/01/2021
    // LET US CONVERT IT TO MILLISECONDS
    int _dateToMilliseconds = _todayDate.millisecondsSinceEpoch;
    // milliseconds in a single day 24x60x60x1000
    // WE CAN JUST MULTIPLY THIS BY 2 or 3 IF WE WANT MORE PREVIOUS DAY RESULTS
    // int _MoreMillisecondsInDay = _millisecondsInDay * 5; // 5 days BACK
    int _millisecondsInDay = 86400000;

    // day = day - 1;
    // THIS STORE THE EXACT DATE OF YESTERDAY BY REMOVING THE SECONDS OF 1 FULL DAY
    // int _dayDiff = (_dateToMilliseconds - _MoreMillisecondsInDay).abs(); // TO GO BACK 5 DAYS
    int _dayDiff = (_dateToMilliseconds - _millisecondsInDay).abs();

    int _tracker = 0;

    for (int _moreDays = 0; _moreDays < maxDaysCount; _moreDays++) {
      // BUILD A NEW DATE FROM THE NEWLY CALCULATED SECONDS
      DateTime _ref = DateTime.fromMillisecondsSinceEpoch(_dayDiff);
      // Store the date to fetch
      String todayDate =
          '${_ref.year.toString()}-${_ref.month.toString()}-${_ref.day.toString()}';
      // Load only once for date specification
      _fetchMatch.fetchMatches(todayDate).then((value) {
        // CHECK IF WE HAVE ACTUAL VALUES BEFORE ADDING TO THE LIST
        if (value.isNotEmpty) {
          if (mounted)
            setState(() {
              // Do a checking to display only available matches
              _matches.addAll(value);
              // STOP THE LOADING WHEN COMPLETED
              _addingMatchLoader = false;
              _newData = 1;
              print('loading completed');
              // print('Size: ${_matches.length}');
              _tracker = _tracker + 1;
            });
        } else {
          if (mounted)
            setState(() {
              _newData = 2;
              _addingMatchLoader = false;
              print('No data has been found');
            });
        }
      });
      // print('THE TRACKER IS: $_tracker');
      // if (_tracker == (maxDaysCount)) {
      //   // SHOW FALSE ONLY IF WE HAVE FETCHED ALL NEEDED GAMES
      //   if (mounted)
      //     setState(() {
      //     });
      // }
      // increase to today, tomorrow and after tomorrow
      // day++;
      // AFTER GOING BACK 1 DAY, WE NOW ADD ONE DAY TO FETCH NEXT DAY MATCHES AND RESULTS
      _dayDiff = _dayDiff + _millisecondsInDay;
    }
  }
}
