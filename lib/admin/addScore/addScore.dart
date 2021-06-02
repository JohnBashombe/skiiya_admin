import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skiiya_admin/app/skiiyaBet.dart';
import 'package:skiiya_admin/database/bonus.dart';
import 'package:skiiya_admin/database/selection.dart';
import 'package:skiiya_admin/methods/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AddGameScore extends StatefulWidget {
  const AddGameScore({Key key}) : super(key: key);

  @override
  _AddGameScoreState createState() => _AddGameScoreState();
}

class _AddGameScoreState extends State<AddGameScore> {
  // STORE GAMES TO UPDATES
  var gameToUpdate = [];
  // BOOL TO SHOW LOADING ACTION BUTTON
  bool _showLoadingButton = false;

  @override
  Widget build(BuildContext context) {
    // load games from history collection
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'UPDATE FINISHED MATCHES IN BETSLIPS WITH SCORES'
                      .toUpperCase(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UPDATING GAMES SCORES IN BETSLIPS'.toUpperCase(),
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
                              // print(
                              //     'UPDATING BETSLIPS WITH REAL RESULTS AND SCORE');
                              getMatchesWithScores();
                            });
                        },
                        fillColor: Colors.lightGreen[400],
                        disabledElevation: 5.0,
                        child: Text(
                          'UPDATE BETSLIPS WITH SCORES'.toUpperCase(),
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

  int getUserBonus(int counter) {
    // print('This is counter: $counter');
    // print('This is bonus rate: $pourcentageRate');
    // int counter = 20;
    int pourcentageRate = 0;
    if (counter == 4) {
      pourcentageRate = Bonus.bonus1;
    } else if (counter == 5) {
      pourcentageRate = Bonus.bonus2;
    } else if (counter == 6) {
      pourcentageRate = Bonus.bonus3;
    } else if (counter == 7) {
      pourcentageRate = Bonus.bonus4;
    } else if (counter == 8) {
      pourcentageRate = Bonus.bonus5;
    } else if (counter == 9) {
      pourcentageRate = Bonus.bonus6;
    } else if (counter == 10) {
      pourcentageRate = Bonus.bonus7;
    } else if (counter == 11) {
      pourcentageRate = Bonus.bonus8;
    } else if (counter == 12) {
      pourcentageRate = Bonus.bonus9;
    } else if (counter == 13) {
      pourcentageRate = Bonus.bonus10;
    } else if (counter == 14) {
      pourcentageRate = Bonus.bonus11;
    } else if (counter == 15) {
      pourcentageRate = Bonus.bonus12;
    } else if (counter == 16) {
      pourcentageRate = Bonus.bonus13;
    } else if (counter == 17) {
      pourcentageRate = Bonus.bonus14;
    } else if (counter == 18) {
      pourcentageRate = Bonus.bonus15;
    } else if (counter == 19) {
      pourcentageRate = Bonus.bonus16;
    } else if (counter >= 20) {
      pourcentageRate = Bonus.bonus17;
    }
    return pourcentageRate;
  }

  showMessage(String message, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: color,
        duration: Duration(seconds: 3),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  void getMatchesWithScores() async {
    print('Updating the betslips with matches having scores');
    Firestore.instance
        .collection('football')
        .where('score_updated', isEqualTo: true)
        .getDocuments()
        .then((_matches) {
      if (mounted)
        setState(() {
          _showLoadingButton = false;
          // ADD ALL GAMES TO THE ARRAY OF GAMES WITH FULL SCORES
          gameToUpdate.addAll(_matches.documents);
        });
      // WE LOOP THROUGH ALL DATA FETCHES
      for (int _i = 0; _i < gameToUpdate.length; _i++) {
        // print(gameToUpdate[_i]['localTeam']);
        // print(gameToUpdate[_i]['visitorTeam']);
        print(gameToUpdate[_i]['id']);
        String _gameID = gameToUpdate[_i]['id'].toString();
        // print('-------------------------------');
        // GET THE ODDS OF EVERY SINGLE MATCH HERE AND STORES IT IN AN ARRAY
        Firestore.instance
            .collection('odds')
            .document(_gameID)
            .get()
            .then((_gameODDS) {
          print("THIS GAME HAS BEEN LOADED SUCCESSFULLY");
          print('THIS GAME ID IS: ${_gameODDS['matchId']}');
          // WE ADD THE GAME ODDS ALONG WITH THE SPECIFIED GAME
          fetchBetslipWithThisGame(gameToUpdate[_i], _gameODDS);
        });
      }
    });
  }

  void fetchBetslipWithThisGame(var game, var gameODDS) async {
    // START TO UPDATE THIS CURRENT GAME
    print('=========================================');
    print('GAME DETAILS: ${game['id']}');
    print('GAME DETAILS: ${game['scores']}');
    print('GAME ODD DETAILS: ${gameODDS['matchId']}');
    print('=========================================');
    // WE GET THE GAME ID HERE FIRST
    var _gameId = game['id'];
    // WE THEN GET THE BETSLIPS THAT HAVE THIS CURRENT GAME IN THEIR CONTENT
    // GETTING BETSLIP WITH THIS VERY CURRENT GAME ID
    await Firestore.instance
        .collection('betslip')
        .where('matches.gameIDs', arrayContains: _gameId)
        .getDocuments()
        .then((_betslipData) {
      // LOOP THROUGH ALL BETSLIPS HAVING THIS GAME AS A CONTENT
      for (int _j = 0; _j < _betslipData.documents.length; _j++) {
        // STORE THE CURRENT BETSLIP INTO THIS VARIABLE
        var _currentBetslip = _betslipData.documents[_j];
        print('**********************************************');
        print('BETSLIP TO UPDATE RESULTS IS: ${_currentBetslip.documentID}');
        // print(_currentBetslip.documentID);
        print(_currentBetslip['uid']);
        print(_currentBetslip['status']);
        print(_currentBetslip['update_status']);
        print(_currentBetslip['trans_id']);
        print(_currentBetslip['rewards']);
        print('**********************************************');
        // print(_betslipData);
        // NOW UPDATE EVERY SINGLE BETSLIP WITH CURRENT SCORE RESULTS
        // UPDATE ONLY THE USER BETSLIPS WITH REAL MATCH SCORE
        updateSingleBetslipWithThisGame(game, gameODDS, _currentBetslip);
      }
    });
  }

  void updateSingleBetslipWithThisGame(
      var _game, var _gameODDS, var _currentBetslip) async {
    // WE GET THE GAME ON TICKET INITIALIZER
    // GET EVERY SINGLE GAME ON THE TICKET
    var _getGameTicket = _currentBetslip['matches'];
    // WE HAVE THE ACTUAL GAME
    // WE HAVE ALL ODDS WITH THEIR RESULTS ASSOCIATED TO IT
    // THEN WE HAVE THE BETSLIP TO UPDATE FINALLY
    //.................
    // WE GET THE CHOICE IN A CURRENT BETSLIP
    // WE GET THE RIGHT GAME INDEX OF THE GAME FROM THE BETSLIP
    // GET ALL THE ODD DETAILS,
    // THEN FETCH THAT PARTICULAR RESULT IN THE GAME ODDS
    // FINALLY UPDATE THE BETSLIP WITH THE NEW RESULTS
    // GET THE SCORE IN GAME VARIABLE
    // UPDATE THE BETSLIP IN THE COLLECTION TO FINISH THE PROCESS
    //.................
    // GET THE LENGTH OF THE BETSLIP DATA
    // int _dataLength = _currentBetslip['rewards']['number_of_games'];
    int _dataLength = _getGameTicket['gameIDs'].length;
    // THIS CONTAINS THE GAME POSITION INTO THESE ARRAYS OF BETSLIP
    // WE NEED TO GET THE RIGHT INDEX TO UPDATE THE RIGHT DATA IN THE ARRAY
    // SETTING IT INITIALLY TO A NON ARRAY VALUE
    int _gamePos = -1;
    // LET US GET THE ID OOF THE GAME
    String _gameID = _game['id'].toString();
    // LOOP THROUGH ALL GAMES ON THE TICKET TO GET EXACT OPTIONS
    for (int _i = 0; _i < _dataLength; _i++) {
      // COMPARE THE CURRENT GAME ID WITH ALL IDS IN GAME IDS ARRAY FROM BETSLIP
      if (_getGameTicket['gameIDs'][_i].toString().compareTo(_gameID) == 0) {
        // IF IT MATCHES, SET THE MATCH INDEX TO THIS VERY CURRENT INDEX
        _gamePos = _i;
        // WE BREAK THE LOOP FOR A FASTER PROCESSING
        break;
      }
    }

    // SHOWING RESULTS HERE
    // WE GET THE ODD ID
    int _oddID = _getGameTicket['oddIDs'][_gamePos];
    // WE GET THE ODD NAME
    String _oddName = _getGameTicket['oddNames'][_gamePos];
    // WE GET THE ODD INDEX
    // int _oddIndex = _getGameTicket['oddIndexes'][_gamePos];
    // WE GET THE ODD LABEL
    String _oddLabel = _getGameTicket['oddLabels'][_gamePos];
    // PRINTING RESULTS MORE DETAILS
    print('------- SHOWING SPECIFIC GAME ON TICKET DETAILS -----------');
    print('Game ID: ${_getGameTicket['gameIDs'][_gamePos]}');
    print('Odd ID: ${_getGameTicket['oddIDs'][_gamePos]}');
    print('OddName: ${_getGameTicket['oddNames'][_gamePos]}');
    print('OddIndex: ${_getGameTicket['oddIndexes'][_gamePos]}');
    print('OddLabel: ${_getGameTicket['oddLabels'][_gamePos]}');
    print('OddValue: ${_getGameTicket['oddValues'][_gamePos]}');
    print('OddTotal: ${_getGameTicket['oddTotals'][_gamePos]}');
    print('OddHandicap: ${_getGameTicket['oddHandicaps'][_gamePos]}');
    print('Scores: ${_getGameTicket['teamScores'][_gamePos]}');
    print('Results: ${_getGameTicket['teamResults'][_gamePos]}');
    print('--------------- END OF DETAILS ---------------------');

    // DO THE UPDATE BETSLIP LOGIC HERE
    // BY GETTING THE RIGHT WINNING VALUE FROM _GAME_ODDS VARIABLE
    // GET THE RIGHT WINNING VALUE HERE

    // WE NOW HAVE THE RIGHT INDEX OF THE GAME IN THE BETSLIP
    // ALL WE HAVE TO DO IS TO GET THE RIGHT RESULT FROM ODDS ARRAY
    // AND UPDATE THE TICKET RESULTS OF THE BETSLIP

    // WORKING...
    print(
        '-- -- -- -- - -- - -- - - RANDOM DATA INIT - -- - - - - - -- - - -- - ');
    print(_gameODDS['odds'][0]['id']); // ODD ID [1]
    print(_gameODDS['odds'][0]['name']); // ODD NAME [1x2]
    // WE WILL LOOP TO GET THE RIGHT GAME ODD ID POSITION
    print(_gameODDS['odds'][0]['bookmaker']['data'][0]['id']); // BOOKMAKER ID
    // BOOKMAKER NAME
    print(_gameODDS['odds'][0]['bookmaker']['data'][0]['name']);
    // data loop
    print(_gameODDS['odds'][0]['bookmaker']['data'][0]['odds']['data'][0]
        ['label']);
    print(_gameODDS['odds'][0]['bookmaker']['data'][0]['odds']['data'][0]
        ['value']);
    print(_gameODDS['odds'][0]['bookmaker']['data'][0]['odds']['data'][0]
        ['winning']);
    print(
        '-- -- -- -- - -- - -- - - RANDOM DATA END- -- - - - - - -- - - -- - ');

    // GET THE POSITION ODD ID OF DATA HERE
    int _bigPos = -1;
    // LOOP TO GET THE RIGHT INDEX OF THE ODD
    for (int _j = 0; _j < _gameODDS['odds'].length; _j++) {
      // CHECK IF WE HAVE A MATCHED DATA
      if ((_gameODDS['odds'][_j]['id']
                  .toString()
                  .compareTo(_oddID.toString()) ==
              0) &&
          (_gameODDS['odds'][_j]['name']
                  .toString()
                  .compareTo(_oddName.toString()) ==
              0)) {
        // BREAK THE LOOP IF FOUND
        _bigPos = _j;
        break;
      }
    }
    // GETTING THE INDEX FROM THE CURRENT POSITION
    int _smallPos = -1;
    // LOOP TO GET THE RIGHT INDEX OF THE ODD INDEX
    // THIS IS THE ARRAY TAHT POINTS TO SUB-CONTENT
    var _smallPosData =
        _gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['odds']['data'];
    // LOOPING TO GET THE RIGHT INDEX HERE TOO
    for (int _j = 0; _j < _smallPosData.length; _j++) {
      // CHECK IF WE HAVE A MATCHED DATA
      if (_smallPosData[_j]['label'].toString().compareTo(_oddLabel) == 0) {
        // BREAK THE LOOP IF FOUND
        _smallPos = _j;
        break;
      }
    }

    if (_bigPos != -1 && _smallPos != -1) {
      // WE ARE NOW PRINTING THE RIGHT DATA VALUE
      print(
          '-- -- -- -- - -- - -- - - RANDOM DATA INIT - -- - - - - - -- - - -- - ');
      print(_gameODDS['odds'][_bigPos]['id']); // ODD ID [1]
      print(_gameODDS['odds'][_bigPos]['name']); // ODD NAME [1x2]
      // WE WILL LOOP TO GET THE RIGHT GAME ODD ID POSITION
      // BOOKMAKER ID
      print(_gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['id']);
      // BOOKMAKER NAME
      print(_gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['name']);
      // data loop
      print(_gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['odds']['data']
          [_smallPos]['label']);
      print(_gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['odds']['data']
          [_smallPos]['value']);
      print(_gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['odds']['data']
          [_smallPos]['winning']);
      print(
          '-- -- -- -- - -- - -- - - RANDOM DATA END- -- - - - - - -- - - -- - ');

      // GET THE RIGHT WINNING OF THIS GAME FROM ODDS COLLECTION
      var _winning = _gameODDS['odds'][_bigPos]['bookmaker']['data'][0]['odds']
          ['data'][_smallPos]['winning'];
      // GET THE RIGHT GAME SCORES HERE TOO FROM FOOTBALL COLLECTION
      var _scores = _game['scores'];
      // THIS IS EQUAL TO THE CURRENT TEAM SCORES OF THE BETSLIP
      var _scoreUpdated = _getGameTicket['teamScores'];
      // WE UPDATE THE SPECIFIC DATA AT INDEX _GAME_POSITION
      _scoreUpdated[_gamePos] = _scores;

      // THIS IS EQUAL TO THE CURRENT TEAM SCORES OF THE BETSLIP
      var _resultUpdated = _getGameTicket['teamResults'];
      // WE UPDATE THE SPECIFIC DATA AT INDEX _GAME_POSITION
      _resultUpdated[_gamePos] = _winning;

      // PRINTING LAST DATA
      print('SCORES: $_scores');
      print('RESULT: $_winning');

      // print('Results: ${_getGameTicket['teamResults'][_gamePos]}');
      // GET THE BETSLIP ID
      String _betslipID = _currentBetslip.documentID.toString();

      Firestore.instance.collection('betslip').document(_betslipID).updateData(
        {
          'teamScores': _scoreUpdated, // UPDATE SCORE AT SPECIFIC INDEX ONLY
          'teamResults': _resultUpdated, // UPDATE RESULT AT SPECIFIC INDEX ONLY
        },
      ).then((value) {
        print('The betslip of ID: $_betslipID has been updated successfully');
      }).catchError((e) {
        print('Error ocuured while updating betslip of ID: $_betslipID');
      });
    } else {
      print('Sorry, We could not verify this data');
    }
  }
}
