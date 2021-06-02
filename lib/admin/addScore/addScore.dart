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
      var _game, var _gameODDS, var _currentBetslip) {
    // WE HAVE THE ACTUAL GAME
    // WE HAVE ALL ODDS WITH THEIR RESULTS ASSOCIATED TO IT
    // THEN WE HAVE THE BETSLIP TO UPDATE FINALLY
    //.................
    // WE GET THE CHOICE IN A CURRENT BETSLIP
    // GET ALL THE ODD DETAILS,
    // THEN FETCH THAT PARTICULAR RESULT IN THE GAME ODDS
    // FINALLY UPDATE THE BETSLIP WITH THE NEW RESULTS
    // GET THE SCORE IN GAME VARIABLE
    // UPDATE THE BETSLIP IN THE COLLECTION TO FINISH THE PROCESS
    //.................
    // GET THE LENGTH OF THE BETSLIP DATA
    // int _dataLength = _currentBetslip['rewards']['number_of_games'];
    int _dataLength = _currentBetslip['matches']['gameIDs'].length;
    // LOOP THROUGH ALL GAMES ON THE TICKET TO GET EXACT OPTIONS
    for (int _i = 0; _i < _dataLength; _i++) {
      // GET EVERY SINGLE GAME ON THE TICKET
      var _getGameTicket = _currentBetslip['matches'];
      // SHOWING RESULTS HERE
      // WE GET THE ODD ID
      int _oddID = _getGameTicket['oddIDs'][_i];
      // WE GET THE ODD NAME
      String _oddName = _getGameTicket['oddNames'][_i];
      // WE GET THE ODD INDEX
      int _oddIndex = _getGameTicket['oddIndexes'][_i];
      // WE GET THE ODD LABEL
      String _oddLabel = _getGameTicket['oddLabels'][_i];
      // PRINTING RESULTS MORE DETAILS
      print('------- SHOWING GAME ON TICKET DETAILS -----------');
      print('Game ID: ${_getGameTicket['gameIDs'][_i]}');
      print('Odd ID: ${_getGameTicket['oddIDs'][_i]}');
      print('OddName: ${_getGameTicket['oddNames'][_i]}');
      print('OddIndex: ${_getGameTicket['oddIndexes'][_i]}');
      print('OddLabel: ${_getGameTicket['oddLabels'][_i]}');
      print('OddValue: ${_getGameTicket['oddValues'][_i]}');
      print('OddTotal: ${_getGameTicket['oddTotals'][_i]}');
      print('OddHandicap: ${_getGameTicket['oddHandicaps'][_i]}');
      print('Scores: ${_getGameTicket['teamScores'][_i]}');
      print('Results: ${_getGameTicket['teamResults'][_i]}');
      print('--------------- END OF DETAILS ---------------------');
    }
  }
}
