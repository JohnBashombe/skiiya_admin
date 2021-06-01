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
  int team1FirstHalf,
      team2FirstHalf,
      team1SecondHalf,
      team2SecondHalf,
      team1FullTime,
      team2FullTime;

  String check1 = '', check2 = '', check3 = '', check4 = '';

  int initGame = 0;
  var games = [];

  var oneTimesTwo = [];
  var bothTeamsToScore = [];
  var oddEven = [];
  var overUnder = [];
  var doubleChance = [];
  var cleanSheet = [];
  var other = [false, false, false, false, false, false];
  var half = [];
  // contains all current betslips containing a certain GAME ID
  var betslipInvolved = [];
  @override
  Widget build(BuildContext context) {
    // load games from history collection
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: new EdgeInsets.only(left: 15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey, width: 0.4),
                bottom: BorderSide(color: Colors.grey, width: 0.4),
                left: BorderSide(color: Colors.grey, width: 0.4),
                right: BorderSide(color: Colors.grey, width: 1.0),
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Games List'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.refresh),
                            tooltip: 'Load all Pending Games',
                            onPressed: () {
                              if (mounted)
                                setState(() {
                                  loadGamesForScoreUpdate();
                                });
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Divider(color: Colors.grey, thickness: 0.5),
                  SizedBox(height: 5.0),
                  // load and diplay all games
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: games
                        .asMap()
                        .entries
                        .map(
                          (MapEntry map) => historyGamesList(
                            map.key,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: new EdgeInsets.only(left: 15.0),
              padding: new EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey, width: 0.4),
                bottom: BorderSide(color: Colors.grey, width: 0.4),
                left: BorderSide(color: Colors.grey, width: 0.4),
                right: BorderSide(color: Colors.grey, width: 1.0),
              )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('', st),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (games.length > 0)
                        Text(
                          games[initGame]['team1'] +
                              ' vs ' +
                              games[initGame]['team2'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      // if (games.length > 0) SizedBox(height: 3.0),
                      (games.length > 0)
                          ? Text(
                              games[initGame]['championship'] +
                                  ' - ' +
                                  games[initGame]['country'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0),
                            )
                          : Center(
                              child: Text(
                                'No Match Selected'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      if (games.length <= 0) SizedBox(height: 20.0),
                      if (games.length > 0)
                        Text(
                          games[initGame]['date']['1'] +
                              ' ' +
                              games[initGame]['date']['2'] +
                              '/' +
                              games[initGame]['date']['3'] +
                              ' - ' +
                              games[initGame]['time']['1'] +
                              ':' +
                              games[initGame]['time']['2'] +
                              games[initGame]['time']['3'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      // if (games.length > 0)
                      //   Text(
                      //     games[initGame]['time']['1'] +
                      //         ':' +
                      //         games[initGame]['time']['2'] +
                      //         games[initGame]['time']['3'],
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 12.0),
                      //   ),
                      if (games.length > 0) SizedBox(height: 3.0),
                      if (games.length > 0) SizedBox(height: 5.0),
                      if (games.length > 0)
                        Divider(color: Colors.grey, thickness: 0.5),
                      if (games.length > 0) SizedBox(height: 5.0),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Add Game Score'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Divider(color: Colors.grey, thickness: 0.5),
                  SizedBox(height: 5.0),
                  Text(
                    'First Half Score'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0),
                  ),
                  Divider(color: Colors.grey, thickness: 0.4),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      addGameFieldNumber('Team 1', 1),
                      SizedBox(width: 3.0),
                      addGameFieldNumber('Team 2', 2),
                    ],
                  ),
                  // SizedBox(height: 5.0),
                  SizedBox(height: 20.0),
                  Text(
                    'Second Half Score'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0),
                  ),
                  Divider(color: Colors.grey, thickness: 0.4),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      addGameFieldNumber('Team 1', 3),
                      SizedBox(width: 3.0),
                      addGameFieldNumber('Team 2', 4),
                    ],
                  ),
                  // SizedBox(height: 5.0),
                  // SizedBox(height: 20.0),
                  // Text(
                  //   'Full Time Score'.toUpperCase(),
                  //   style: TextStyle(
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16.0),
                  // ),
                  // Divider(color: Colors.grey, thickness: 0.4),
                  // SizedBox(height: 10.0),
                  // Row(
                  //   children: [
                  //     addGameFieldNumber('Team 1', 5),
                  //     SizedBox(width: 3.0),
                  //     addGameFieldNumber('Team 2', 6),
                  //   ],
                  // ),
                  // SizedBox(height: 5.0),
                  SizedBox(height: 30.0),
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      padding: new EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      onPressed: () {
                        if (mounted)
                          setState(() {
                            // check if all values are provided
                            if (check1.compareTo('') != 0 &&
                                check2.compareTo('') != 0 &&
                                check3.compareTo('') != 0 &&
                                check4.compareTo('') != 0) {
                              // set values to variables
                              team1FirstHalf = int.parse(check1);
                              team2FirstHalf = int.parse(check2);
                              team1SecondHalf = int.parse(check3);
                              team2SecondHalf = int.parse(check4);
                              team1FullTime =
                                  (team1FirstHalf + team1SecondHalf);
                              team2FullTime =
                                  (team2FirstHalf + team2SecondHalf);
                              // print('Result added successfully');
                              // showMessage('Result added successfully',
                              //     Colors.lightGreen[400]);
                              // after a succesfull update, reload the games list
                              // loadGamesForScoreUpdate();
                              if (games.length > 0) {
                                // update the game in gamesHistory now
                                updateGameInCollection(
                                    team1FirstHalf,
                                    team2FirstHalf,
                                    team1SecondHalf,
                                    team2SecondHalf,
                                    team1FullTime,
                                    team2FullTime);
                              } else {
                                showMessage(
                                    'Please! Select One Match', Colors.red);
                              }
                            } else {
                              showMessage(
                                  'Please! Fill all fields', Colors.red);
                            }
                          });
                      },
                      fillColor: Colors.lightGreen[400],
                      disabledElevation: 5.0,
                      child: Text(
                        'Add Game Result'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0),
                      ),
                    ),
                  ),
                  if (games.length > 0) SizedBox(height: 20.0),
                  if (games.length > 0)
                    Container(
                      width: double.infinity,
                      child: RawMaterialButton(
                        padding: new EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        onPressed: () {
                          if (mounted)
                            setState(() {
                              // showMessage(
                              //     'Game Cancelled!', Colors.lightGreen[400]);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Stack(
                                        // overflow: Overflow.visible,
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              Text(
                                                  'Do You want to cancel this Game?',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0)),
                                              SizedBox(height: 10.0),
                                              Divider(
                                                  thickness: 0.5,
                                                  color: Colors.grey),
                                              SizedBox(height: 10.0),
                                              Text(
                                                games[initGame]['team1'] +
                                                    ' vs ' +
                                                    games[initGame]['team2'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0),
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                games[initGame]
                                                        ['championship'] +
                                                    ' - ' +
                                                    games[initGame]['country'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.0),
                                              ),
                                              SizedBox(height: 10.0),
                                              Text(
                                                games[initGame]['date']['1'] +
                                                    ' ' +
                                                    games[initGame]['date']
                                                        ['2'] +
                                                    '/' +
                                                    games[initGame]['date']
                                                        ['3'] +
                                                    ' - ' +
                                                    games[initGame]['time']
                                                        ['1'] +
                                                    ':' +
                                                    games[initGame]['time']
                                                        ['2'] +
                                                    games[initGame]['time']
                                                        ['3'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12.0),
                                              ),
                                              SizedBox(height: 5.0),
                                              Divider(
                                                  color: Colors.grey,
                                                  thickness: 0.5),
                                              SizedBox(height: 5.0),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: RawMaterialButton(
                                                      padding: new EdgeInsets
                                                              .symmetric(
                                                          vertical: 15.0,
                                                          horizontal: 15.0),
                                                      onPressed: () {
                                                        if (mounted)
                                                          setState(() {
                                                            // GET HISTORY GAME ID
                                                            String id =
                                                                games[initGame]
                                                                    .documentID
                                                                    .toString();
                                                            // GET THE ORIGINAL GAME ID
                                                            String idOriginal =
                                                                games[initGame][
                                                                        'gameID']
                                                                    .toString();

                                                            Firestore.instance
                                                                .collection(
                                                                    'GamesHistory')
                                                                .document(id)
                                                                .updateData(
                                                              {
                                                                'status':
                                                                    'cancelled' // to complete after game rewarding completed
                                                              },
                                                            ).then((value) {
                                                              print(
                                                                  'Game Cancelled successfully');
                                                              // UPDATE BETSLIP DETAILS IN HERE
                                                              updateBetslipDetailsCancel(
                                                                  idOriginal);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              SkiiyaBet()));
                                                              // Reload the games uncompleted
                                                              // loadGamesForScoreUpdate();
                                                              // Navigator.of(context)
                                                              //     .pop();
                                                            });
                                                          });
                                                      },
                                                      fillColor: Colors.red,
                                                      disabledElevation: 5.0,
                                                      child: Text(
                                                        'Yes'.toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.0),
                                                  Expanded(
                                                    child: RawMaterialButton(
                                                      padding: new EdgeInsets
                                                              .symmetric(
                                                          vertical: 15.0,
                                                          horizontal: 15.0),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      fillColor: Colors.blue,
                                                      disabledElevation: 5.0,
                                                      child: Text(
                                                        'No'.toUpperCase(),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 13.0),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            });
                        },
                        fillColor: Colors.red,
                        disabledElevation: 5.0,
                        child: Text(
                          'Cancel Game'.toUpperCase(),
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
        ),
      ],
    );
  }

  updateGameInCollection(
      int t1h1, int t2h1, int t1h2, int t2h2, int t1FT, int t2FT) {
    // Get the game ID
    String id = games[initGame].documentID.toString();
    // update the game in gamesHistory collection
    // print('The current ID is: $id');
    String idOriginal = games[initGame]['gameID'].toString();
    // print('The very current ORIGINAL GAME ID is: $idOriginal');

    var finalScore = [t1FT, t2FT, t1h1, t2h1, t1h2, t2h2];
    // print(finalScore);
    // print(oneTimesTwoArray(t1h1, t2h1, t1h2, t2h2, t1FT, t2FT));
    // print(oddEvenArray(t1FT, t2FT));
    // print(overUnderArray(t1FT, t2FT));
    // print(halfArray(t1h1, t2h1, t1h2, t2h2, t1FT, t2FT));
    // print(cleanSheetArray(t1FT, t2FT));
    // print(doubleChanceArray(t1FT, t2FT));
    // print(otherArray(t1FT, t2FT));

    Firestore.instance.collection('GamesHistory').document(id).updateData(
      {
        'finalScore': finalScore,
        'resultOneTimesTwo':
            oneTimesTwoArray(t1h1, t2h1, t1h2, t2h2, t1FT, t2FT),
        'resultBothTeamsToScore': bothTeamsToScoreArray(t1FT, t2FT),
        'resultOddEven': oddEvenArray(t1FT, t2FT),
        'resultOverUnder': overUnderArray(t1FT, t2FT),
        'resultHalf': halfArray(t1h1, t2h1, t1h2, t2h2, t1FT, t2FT),
        'resultCleanSheet': cleanSheetArray(t1FT, t2FT),
        'resultDoubleChance': doubleChanceArray(t1FT, t2FT),
        'resultOther': otherArray(t1FT, t2FT),
        'status': 'completed' // to complete after game rewarding completed
      },
    ).then((value) {
      // UPDATE BETSLIP DETAILS IN HERE
      updateBetslipDetails(idOriginal);
      // 'gameScoreTeam1': t1FT,
      // 'gameScoreTeam2': t2FT,
      // print('Results added successfully');
      Navigator.push(context, MaterialPageRoute(builder: (_) => SkiiyaBet()));
      // Reload the games uncompleted
      // loadGamesForScoreUpdate();
      // Navigator.of(context).pop();
      // Navigator.of(context).pop();
    });
  }

  updateBetslipDetails(String idOriginal) {
    // print(idOriginal);
    // TO BE UPDATED IN BETSLIP COLLECTION
    betslipInvolved.clear();
    Firestore.instance
        .collection('BetSlip')
        .where('gameIDs', arrayContains: '$idOriginal')
        .getDocuments()
        .then((value) {
      // print(value.documents.length);
      //remove all elements before adding new ones
      betslipInvolved.addAll(value.documents);
      updateSingleBetslip(idOriginal);
      // print('Betslip with current Game IDs are : ${value.documents}');
      // print('Data is : ${value.documents.toString()}');
    }).catchError((e) {
      print('loading betslip error: $e');
    });
  }

  updateBetslipDetailsCancel(String idOriginal) {
    // print(idOriginal);
    // TO BE UPDATED IN BETSLIP COLLECTION
    betslipInvolved.clear();
    Firestore.instance
        .collection('BetSlip')
        .where('gameIDs', arrayContains: '$idOriginal')
        .getDocuments()
        .then((value) {
      // print(value.documents.length);
      //remove all elements before adding new ones
      betslipInvolved.addAll(value.documents);
      updateSingleBetslipCancel(idOriginal);
      // print('Betslip with current Game IDs are : ${value.documents}');
      // print('Data is : ${value.documents.toString()}');
    }).catchError((e) {
      print('loading betslip error: $e');
    });
  }

  int getUserBonus(int counter) {
    // print('This is counter: $counter');
    // print('This is bonus rate: $pourcentageRate');
    // int counter = 20;
    int pourcentageRate = 0;
    if (counter == 0) {
    } else if ((counter > 0) && (counter <= 3)) {
    } else if (counter == 4) {
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

  updateSingleBetslipCancel(String idOriginal) {
    // First we declare variables to hold database values
    // var gameChoices = [];
    var gameIDs = [];
    var gameRates = [];
    var gameResults = [];
    // var gameScoreTeam1 = [];
    // var gameScoreTeam2 = [];
    // double possibleWinning = 0.0;
    // String status;

    if (betslipInvolved.isNotEmpty) {
      // print('Contains elements');
      for (int i = 0; i < betslipInvolved.length; i++) {
        // store the betslip ID
        String betslipID = betslipInvolved[i].documentID;
        // We set values to our declared variables
        // gameChoices = betslipInvolved[i]['gameChoices'];
        gameIDs = betslipInvolved[i]['gameIDs'];
        gameRates = betslipInvolved[i]['gameRates'];
        gameResults = betslipInvolved[i]['gameResults'];
        // get the current status of the betslip
        // Let us get the index of that particular game in these arrays
        int index = gameIDs.indexOf(idOriginal);
        // Then we do calculation
        // We will update only values in arrays at this very particular index
        double thisStake = betslipInvolved[i]['stake'];
        // 'stake': Price.stake,
        double thisTotalRate = betslipInvolved[i]['totalRate'];
        // 'totalRate': totalRate(),
        double thisGameRate = gameRates[index];
        // 'bonusAmount': bonusAmount(),
        // UPDATE THE TOTAL RATE BY SUBSTRACTING THE CANCELLED RATE
        thisTotalRate = (thisTotalRate - thisGameRate).abs();
        // UPDATE THE RATE OF THIS NEW GAME TO 0.0
        gameRates[index] = 0.0;
        gameResults[index] = 'cancelled';
        // 'possibleWinning': possibleWinning(),
        // RECALCULATE THE POSSIBLE WINNING
        double thisPossibleWinning =
            (thisTotalRate.toDouble() * thisStake.floor()).round().toDouble();
        // BONUS AMOUNT
        // THE BONUS SHOULD BE CALCULATED WITH ONE GAME LESS
        double thisBonusAmount =
            thisPossibleWinning * (getUserBonus(gameIDs.length - 1) / 100);
        // GET THE TOTAL PAYOUT AMOUNT
        double thisTotalPayout = thisPossibleWinning + thisBonusAmount;
        // print(gameRates);
        // print(gameResults);
        // print(thisStake);
        // print(thisGameRate);
        // print(thisTotalRate);
        // print(thisPossibleWinning);
        // print(thisBonusAmount);
        // print(thisTotalPayout);
        // this array helps us store the current value without damaging its content like gameResults array that only
        // consider the values of the last betslip
        var currentResult = [];
        currentResult = gameResults;
        // print('Results: $gameResults');
        // IF THE GAME IS CANCELLED, UPDATE RESULTS HERE BEFORE SENDING TO DATABASE
        // THE ONLY ACTION TO PERFORM HERE IT IS TO REDUCE THE PRICE OF THE CANCELLED GAME
        Firestore.instance.collection('BetSlip').document(betslipID).updateData(
          {
            // THERE IS NO NEED TO UPDATE THE SCORE RESULT AS IT WILL REMAIN NULL
            'gameRates': gameRates,
            'gameResults': gameResults,
            'totalRate': thisTotalRate,
            'possibleWinning': thisPossibleWinning,
            'bonusAmount': thisBonusAmount,
            'totalPayout': thisTotalPayout
          },
          // print('');
        ).then((value) {
          // REWARD PROCESS GOES HERE
          // BEFORE UPDATING THE VALUE, CHECK FIRST IF THE GAME STATUS IS STILL PENDING
          // THIS CANCEL PROCESS SHOUD HAVE ITS OWN BUTTON ACTION
          bool isBetslipWon = true;
          // this betslip has been lost, change the status to lost
          String status = betslipInvolved[i]['status'];
          // CHECK IF NO GAME HAS BEEN LOST FOR THIS PARTICULAR BETSLIP
          for (int j = 0; j < currentResult.length; j++) {
            if (currentResult[j].toString().compareTo('null') == 0) {
              // this is still a pending status
              // IF ONE GAME IS STILL PENDING, THE WHOLE BETSLIP IS STILL PENDING
              isBetslipWon = false;
              break;
              // print('null');
            }
            if (currentResult[j].toString().compareTo('false') == 0) {
              // UPDATE THE STATUS IF IT HAS NOT BEEN YET UPDATED
              if (status.toString().compareTo('pending') == 0) {
                // IF ONE GAME IS LOST, THE WHOLE BETSLIP IS LOST
                // print('false');
                Firestore.instance
                    .collection('BetSlip')
                    .document(betslipID)
                    .updateData({'status': 'completed', 'result': 'lost'});
              }
              isBetslipWon = false;
              break;
            }
          }

          // if no game is still pending or has been lost then update the USER With it is winning
          if (isBetslipWon) {
            // print('Display after cancelled and the bet was won');
            // CHECK IF THE STATUS IS STILL PENDING TO AVOID DOUBLE REWARDING
            if (status.toString().compareTo('pending') == 0) {
              // get the right user id
              String userID = betslipInvolved[i]['uid'];
              // print(totalPayout);
              // print(userID);
              // UPDATE THE BETSLIP STATUS IN FIRESTORE
              Firestore.instance
                  .collection('BetSlip')
                  .document(betslipID)
                  .updateData({'status': 'completed', 'result': 'won'}).then(
                      (value) {
                // UPDATE THE USER ACCOUNT BALANCE
                Firestore.instance
                    .collection('UserBalance')
                    .document(userID)
                    .updateData({
                  'balance': FieldValue.increment(thisTotalPayout)
                }).then((value) {
                  Method.addTransactionRecords(
                          'Reward', userID, thisTotalPayout)
                      .then((value) {
                    // print('the user has been rewarded successfully');
                  });
                });
              });
            }
          }
        }).catchError((e) {
          print('last update error is: $e');
        });
      }
    } else {
      print('No player played on this game that will be cancelled');
    }
  }

  updateSingleBetslip(String idOriginal) {
    // First we declare variables to hold database values
    var gameChoices = [];
    var gameIDs = [];
    // var gameRates = [];
    var gameResults = [];
    var gameScoreTeam1 = [];
    var gameScoreTeam2 = [];
    String singleChoice;
    // double possibleWinning = 0.0;
    // String status;

    if (betslipInvolved.isNotEmpty) {
      // print('Contains elements');
      for (int i = 0; i < betslipInvolved.length; i++) {
        // store the betslip ID
        String betslipID = betslipInvolved[i].documentID;
        // We set values to our declared variables
        gameChoices = betslipInvolved[i]['gameChoices'];
        gameIDs = betslipInvolved[i]['gameIDs'];
        // gameRates = betslipInvolved[i]['gameRates'];
        gameResults = betslipInvolved[i]['gameResults'];
        gameScoreTeam1 = betslipInvolved[i]['gameScoreTeam1'];
        gameScoreTeam2 = betslipInvolved[i]['gameScoreTeam2'];
        // get the current status of the betslip
        // status = betslipInvolved[i]['status'];
        // possibleWinning = betslipInvolved[i]['possibleWinning'];
        // Let us get the index of that particular game in these arrays
        int index = gameIDs.indexOf(idOriginal);
        // Then we do calculation
        // We will update only values in arrays at this very particular index
        // TO BE UPDATED [ GameResults, gameScoreTeam1, gameScoreTeam2 ]
        gameScoreTeam1[index] = team1FullTime;
        gameScoreTeam2[index] = team2FullTime;
        // print('The index is: $index');
        // print('The current Game Choice is: ${gameChoices[index]}');
        // print('The betslip ID is: $betslipID');
        // print('-------------------------------- 1 1');
        // print(oneTimesTwo);
        // print(bothTeamsToScore);
        // print(oddEven);
        // print(overUnder);
        // print(doubleChance);
        // print(cleanSheet);
        // print(other);
        // print(half);
        // print('-------------------------------- 1 1 1');
        // GameResults Update process will be based on the result of the game
        singleChoice = getGameResult(gameChoices[index]);
        // print('-------------------------------- 1 2');
        // print(oneTimesTwo);
        // print(bothTeamsToScore);
        // print(oddEven);
        // print(overUnder);
        // print(doubleChance);
        // print(cleanSheet);
        // print(other);
        // print(half);
        // print('-------------------------------- 2 2');
        // print(singleGameChoice);
        gameResults[index] = singleChoice;
        // print('Game Choices: $gameChoices');
        // // print(gameIDs);
        // print('Results: $gameResults');
        // print('Score Team 1: $gameScoreTeam1');
        // print('Score Team 2: $gameScoreTeam2');
        // print('This game Result is : $singleChoice');
        // print(games[initGame]['resultOneTimesTwo']);
        // print(games[initGame]['resultOddEven']);
        // print(games[initGame]['resultOverUnder']);
        // print(games[initGame]['resultHalf']);
        // print(games[initGame]['resultCleanSheet']);
        // print(games[initGame]['resultDoubleChance']);
        // print(games[initGame]['resultOther']);
        // for (var i = 0; i < games.length; i++) {
        //   print(games[initGame]['resultOneTimesTwo']);
        // }
        // this array helps us store the current value without damaging its content like gameResults array that only
        // consider the values of the last betslip
        var currentResult = [];
        currentResult = gameResults;
        // print('Results: $gameResults');
        // IF THE GAME IS CANCELLED, UPDATE RESULTS HERE BEFORE SENDING TO DATABASE
        // print('This game Index is: $index');
        Firestore.instance.collection('BetSlip').document(betslipID).updateData(
          {
            'gameScoreTeam1': gameScoreTeam1,
            'gameScoreTeam2': gameScoreTeam2,
            'gameResults': gameResults,
          },
          // print('');
        ).then((value) {
          // REWARD PROCESS GOES HERE
          // BEFORE UPDATING THE VALUE, CHECK FIRST IF THE GAME STATUS IS STILL PENDING
          // THIS CANCEL PROCESS SHOUD HAVE ITS OWN BUTTON ACTION
          bool isBetslipWon = true;
          // this betslip has been lost, change the status to lost
          String status = betslipInvolved[i]['status'];
          // print('My in loop results : $gameResults');
          // print('True results : $currentResult');
          // if (status.toString().compareTo('pending') == 0) {
          // complete rewarding process if the status is pending
          // CHECK IF NO GAME HAS BEEN LOST FOR THIS PARTICULAR BETSLIP
          for (int j = 0; j < currentResult.length; j++) {
            if (currentResult[j].toString().compareTo('null') == 0) {
              // this is still a pending status
              // IF ONE GAME IS STILL PENDING, THE WHOLE BETSLIP IS STILL PENDING
              isBetslipWon = false;
              break;
              // print('null');
            }
            // if (gameResults[j].toString().compareTo('true') == 0) {
            //   // GET TRACK OF COUNT TO
            // }
            if (currentResult[j].toString().compareTo('false') == 0) {
              // UPDATE THE STATUS IF IT HAS NOT BEEN YET UPDATED
              if (status.toString().compareTo('pending') == 0) {
                // IF ONE GAME IS LOST, THE WHOLE BETSLIP IS LOST
                // print('false');
                Firestore.instance
                    .collection('BetSlip')
                    .document(betslipID)
                    .updateData({'status': 'completed', 'result': 'lost'});
              }
              isBetslipWon = false;
              break;
            }
          }

          //   // if no game is still pending or has been lost then update the USER With it is winning
          if (isBetslipWon) {
            // CHECK IF THE STATUS IS STILL PENDING TO AVOID DOUBLE REWARDING
            if (status.toString().compareTo('pending') == 0) {
              // get the total payout for this particular betslip
              double totalPayout = betslipInvolved[i]['totalPayout'];
              // get the right user id
              String userID = betslipInvolved[i]['uid'];
              // print(totalPayout);
              // print(userID);
              // UPDATE THE BETSLIP STATUS IN FIRESTORE
              Firestore.instance
                  .collection('BetSlip')
                  .document(betslipID)
                  .updateData({'status': 'completed', 'result': 'won'}).then(
                      (value) {
                // UPDATE THE USER ACCOUNT BALANCE
                Firestore.instance
                    .collection('UserBalance')
                    .document(userID)
                    .updateData({
                  'balance': FieldValue.increment(totalPayout)
                }).then((value) {
                  Method.addTransactionRecords('Reward', userID, totalPayout)
                      .then((value) {
                    // print('the user has been rewarded successfully');
                  });
                });
              });
            }
            //     // else {
            //     //   print('rewarded already');
            //     // }
            //     // print(betslipInvolved[i]['stake']);
            //     // print(betslipInvolved[i]['possibleWinning']);
            //     // print(betslipInvolved[i]['bonusAmount']);
            //     // print(betslipInvolved[i]['totalPayout']);
            //     // print('this betslip has been WON successfully');
          }
          //   // print(betslipInvolved[i].documentID);
          //   //  else {
          //   //   print(betslipInvolved[i].documentID);
          //   //   print(betslipInvolved[i]['stake']);
          //   //   print(betslipInvolved[i]['possibleWinning']);
          //   //   print(betslipInvolved[i]['bonusAmount']);
          //   //   print(betslipInvolved[i]['totalPayout']);
          //   //   print('this betslip has been LOST successfully');
          //   // }
          //   // }
          //   // if (singleChoice.compareTo('cancelled') == 0) {
          //   //   // do update of betslip reward here
          //   //   print('The game was cancelled'); // KEEP THE PROCESS TO PENDING
          //   // } else if (singleChoice.compareTo('false') == 0) {
          //   //   // do update of betslip reward here
          //   //   print('The game is lost');
          //   //   // CHANGE STATUS TO LOST SO THAT REWARD PROCESS WON'T BE APPLIED
          //   // } else if (singleChoice.compareTo('true') == 0) {
          //   //   // do update of betslip reward here
          //   //   print('The game is won and keep waiting');
          //   //   // KEEP THE STATUS TO PENDING
          //   // }
          //   // // Reward Calculation goes in here
          //   // print(
          //   //     'Print either reward user or end the betslip or leave it until next game completed');
        }).catchError((e) {
          print('last update error is: $e');
        });
        // print('Choices: $gameChoices');
        // print('IDs: $gameIDs');
        // print('Rates: $gameRates');
        // print('Results: $gameResults');
        // print('Game Score 1: $gameScoreTeam1');
        // print('Game Score 2: $gameScoreTeam2');
        // print('TotalWinning : $possibleWinning');
        // print('------------------------------------------');
      }
    } else {
      print('No player played on this game');
    }
  }

  String getGameResult(String singleChoice) {
    // String result = '';
    // RELOAD THE GAME DETAILS BEFORE CHECKING THE ANSWER
    // start comparing results to fetch the right value for this game results
    if (singleChoice.compareTo(Selection.reference[0].toString()) == 0) {
      return oneTimesTwo[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[1].toString()) == 0) {
      return oneTimesTwo[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[2].toString()) == 0) {
      return oneTimesTwo[2].toString();
    } else if (singleChoice.compareTo(Selection.reference[3].toString()) == 0) {
      return oneTimesTwo[3].toString();
    } else if (singleChoice.compareTo(Selection.reference[4].toString()) == 0) {
      return oneTimesTwo[4].toString();
    } else if (singleChoice.compareTo(Selection.reference[5].toString()) == 0) {
      return oneTimesTwo[5].toString();
    } else if (singleChoice.compareTo(Selection.reference[6].toString()) == 0) {
      return oneTimesTwo[6].toString();
    } else if (singleChoice.compareTo(Selection.reference[7].toString()) == 0) {
      return oneTimesTwo[7].toString();
    } else if (singleChoice.compareTo(Selection.reference[8].toString()) == 0) {
      return oneTimesTwo[8].toString();
    }
    // this is over and under conditions
    else if (singleChoice.compareTo(Selection.reference[9].toString()) == 0) {
      return overUnder[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[10].toString()) ==
        0) {
      return overUnder[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[11].toString()) ==
        0) {
      return overUnder[2].toString();
    } else if (singleChoice.compareTo(Selection.reference[12].toString()) ==
        0) {
      return overUnder[3].toString();
    } else if (singleChoice.compareTo(Selection.reference[13].toString()) ==
        0) {
      return overUnder[4].toString();
    } else if (singleChoice.compareTo(Selection.reference[14].toString()) ==
        0) {
      return overUnder[5].toString();
    } else if (singleChoice.compareTo(Selection.reference[15].toString()) ==
        0) {
      return overUnder[6].toString();
    } else if (singleChoice.compareTo(Selection.reference[16].toString()) ==
        0) {
      return overUnder[7].toString();
    } else if (singleChoice.compareTo(Selection.reference[17].toString()) ==
        0) {
      return overUnder[8].toString();
    } else if (singleChoice.compareTo(Selection.reference[18].toString()) ==
        0) {
      return overUnder[9].toString();
    } else if (singleChoice.compareTo(Selection.reference[19].toString()) ==
        0) {
      return overUnder[10].toString();
    } else if (singleChoice.compareTo(Selection.reference[20].toString()) ==
        0) {
      return overUnder[11].toString();
    }
    // this is Both teams to score panel
    else if (singleChoice.compareTo(Selection.reference[21].toString()) == 0) {
      return bothTeamsToScore[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[22].toString()) ==
        0) {
      return bothTeamsToScore[1].toString();
    }
    // this is odd and even conditions
    else if (singleChoice.compareTo(Selection.reference[23].toString()) == 0) {
      return oddEven[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[24].toString()) ==
        0) {
      return oddEven[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[25].toString()) ==
        0) {
      return oddEven[2].toString();
    } else if (singleChoice.compareTo(Selection.reference[26].toString()) ==
        0) {
      return oddEven[3].toString();
    } else if (singleChoice.compareTo(Selection.reference[27].toString()) ==
        0) {
      return oddEven[4].toString();
    } else if (singleChoice.compareTo(Selection.reference[28].toString()) ==
        0) {
      return oddEven[5].toString();
    }
    // half odds display here
    else if (singleChoice.compareTo(Selection.reference[29].toString()) == 0) {
      return half[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[30].toString()) ==
        0) {
      return half[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[31].toString()) ==
        0) {
      return half[2].toString();
    } else if (singleChoice.compareTo(Selection.reference[32].toString()) ==
        0) {
      return half[3].toString();
    } else if (singleChoice.compareTo(Selection.reference[33].toString()) ==
        0) {
      return half[4].toString();
    } else if (singleChoice.compareTo(Selection.reference[34].toString()) ==
        0) {
      return half[5].toString();
    } else if (singleChoice.compareTo(Selection.reference[35].toString()) ==
        0) {
      return half[6].toString();
    } else if (singleChoice.compareTo(Selection.reference[36].toString()) ==
        0) {
      return half[7].toString();
    } else if (singleChoice.compareTo(Selection.reference[37].toString()) ==
        0) {
      return half[8].toString();
    } else if (singleChoice.compareTo(Selection.reference[38].toString()) ==
        0) {
      return half[9].toString();
    } else if (singleChoice.compareTo(Selection.reference[39].toString()) ==
        0) {
      return half[10].toString();
    }
    // clean sheet odds display here
    else if (singleChoice.compareTo(Selection.reference[40].toString()) == 0) {
      return cleanSheet[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[41].toString()) ==
        0) {
      return cleanSheet[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[42].toString()) ==
        0) {
      return cleanSheet[2].toString();
    } else if (singleChoice.compareTo(Selection.reference[43].toString()) ==
        0) {
      return cleanSheet[3].toString();
    }
    // draw no bet odds display here
    else if (singleChoice.compareTo(Selection.reference[44].toString()) == 0) {
      return doubleChance[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[45].toString()) ==
        0) {
      return doubleChance[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[46].toString()) ==
        0) {
      return doubleChance[2].toString();
    }
    // other odds goes here [1x2 and both teams to score]
    else if (singleChoice.compareTo(Selection.reference[47].toString()) == 0) {
      return other[0].toString();
    } else if (singleChoice.compareTo(Selection.reference[48].toString()) ==
        0) {
      return other[1].toString();
    } else if (singleChoice.compareTo(Selection.reference[49].toString()) ==
        0) {
      return other[2].toString();
    } else if (singleChoice.compareTo(Selection.reference[50].toString()) ==
        0) {
      return other[3].toString();
    } else if (singleChoice.compareTo(Selection.reference[51].toString()) ==
        0) {
      return other[4].toString();
    } else if (singleChoice.compareTo(Selection.reference[52].toString()) ==
        0) {
      return other[5].toString();
    } else {
      return 'cancelled';
    }

    // return result;
  }

  Widget historyGamesList(int index) {
    return GestureDetector(
      onTap: () {
        if (mounted)
          setState(() {
            // print('Selection of : ${games[index].documentID}');
            // on click, set the detailed game to selected one
            initGame = index;
          });
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      games[index]['team1'] + ' vs ' + games[index]['team2'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                    ),
                    Text(
                      games[index]['championship'] +
                          ' - ' +
                          games[index]['country'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(height: 3.0),
            Divider(color: Colors.grey, thickness: 0.5),
            SizedBox(height: 3.0),
          ],
        ),
      ),
    );
  }

  loadGamesForScoreUpdate() {
    // print('load history');
    Firestore.instance
        .collection('GamesHistory')
        .where('status', isEqualTo: 'pending')
        .orderBy('sorter', descending: false)
        .limit(8)
        .getDocuments()
        .then((result) {
      if (mounted)
        setState(() {
          // remove everything before loading more
          games.clear();
          // var team1 = result.documents[0];
          games.addAll(result.documents);
        });
      // load all games found in History collection
      // print('the fetched result is: ${result.documents[0].documentID}');
      // return historyGamesList(result);
    }).catchError((e) {
      print('the error while fetching games is: $e');
    });
    // return historyGamesList();
  }

  Expanded addGameFieldNumber(String hint, int index) {
    // 1 to 6
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.0),
        height: 50.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              top: BorderSide(color: Colors.lightGreen[400], width: 3.0),
              bottom: BorderSide(color: Colors.lightGreen[400], width: 3.0),
              left: BorderSide(color: Colors.lightGreen[400], width: 3.0),
              right: BorderSide(color: Colors.lightGreen[400], width: 3.0),
            )),
        child: TextFormField(
          onChanged: (value) {
            if (mounted)
              setState(() {
                if (index == 1) {
                  check1 = value;
                } else if (index == 2) {
                  check2 = value;
                } else if (index == 3) {
                  check3 = value;
                } else if (index == 4) {
                  check4 = value;
                }
              });
          },
          cursorColor: Colors.lightGreen,
          maxLines: 1,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          style: TextStyle(
              color: Colors.black,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
          decoration: InputDecoration(
              border: InputBorder.none,
              // fillColor: Colors.deepOrange[400],
              // contentPadding: EdgeInsets.all(10.0),
              hintText: hint,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0)),
        ),
      ),
    );
  }

  showMessage(String message, Color color) {
    return Scaffold.of(context).showSnackBar(
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

  dynamic halfArray(
      int t1h1, int t2h1, int t1h2, int t2h2, int t1FT, int t2FT) {
    // get the halves sum
    int sum1Half = t1h1 + t2h1;
    int sum2Half = t1h2 + t2h2;
    // Do calculation here
    sum1Half > sum2Half ? half.insert(0, true) : half.insert(0, false);
    sum1Half < sum2Half ? half.insert(1, true) : half.insert(1, false);
    sum1Half == sum2Half ? half.insert(2, true) : half.insert(2, false);
    // Team 1 Win either half
    if ((t1h1 > t2h1) || (t1h2 > t2h2)) {
      half.insert(3, true);
      half.insert(4, false);
    } else {
      half.insert(3, false);
      half.insert(4, true);
    }
    // Team 2 Win either half
    if ((t2h1 > t2h1) || (t2h2 > t1h2)) {
      half.insert(5, true);
      half.insert(6, false);
    } else {
      half.insert(5, false);
      half.insert(6, true);
    }
    // Team 1 Win both halves
    if ((t1h1 > t2h1) && (t1h2 > t2h2)) {
      half.insert(7, true);
      half.insert(8, false);
    } else {
      half.insert(7, false);
      half.insert(8, true);
    }
    // Team 2 Win both halves
    if ((t2h1 > t2h1) && (t2h2 > t1h2)) {
      half.insert(9, true);
      half.insert(10, false);
    } else {
      half.insert(9, false);
      half.insert(10, true);
    }
    // do calculation here

    return half;
  }

  dynamic otherArray(int t1FT, int t2FT) {
    // Full Time Double Chance
    // do calculation here
    // 1 yes - No
    if ((t1FT > t2FT)) {
      if (t1FT > 0 && t2FT > 0) {
        other[0] = true;
        other[1] = false;
      } else {
        other[0] = false;
        other[1] = true;
      }
    }
    // 2 yes - No
    if ((t2FT > t1FT)) {
      if (t1FT > 0 && t2FT > 0) {
        other[2] = true;
        other[3] = false;
      } else {
        other[2] = false;
        other[3] = true;
      }
    }
    // x yes - x No
    if ((t2FT == t1FT)) {
      if (t1FT > 0 && t2FT > 0) {
        other[4] = true;
        other[5] = false;
      } else {
        other[4] = false;
        other[5] = true;
      }
    }

    return other;
  }

  dynamic cleanSheetArray(int t1FT, int t2FT) {
    // Full Time Double Chance
    // do calculation here
    // clean sheet for team1 if team 2 score is 0
    if (t2FT > 0) {
      cleanSheet.insert(0, false);
      cleanSheet.insert(1, true);
    } else {
      cleanSheet.insert(0, true);
      cleanSheet.insert(1, false);
    }
    // clean sheet for team2 if team 1 score is 0
    if (t1FT > 0) {
      cleanSheet.insert(2, false);
      cleanSheet.insert(3, true);
    } else {
      cleanSheet.insert(2, true);
      cleanSheet.insert(3, false);
    }

    return cleanSheet;
  }

  dynamic doubleChanceArray(int t1FT, int t2FT) {
    // Full Time Double Chance
    // do calculation here
    // if team 1 and Draw
    if (t1FT > t2FT || t1FT == t2FT) {
      doubleChance.insert(0, true);
    } else {
      doubleChance.insert(0, false);
    }
    // if team 2 and Draw
    if (t2FT > t1FT || t1FT == t2FT) {
      doubleChance.insert(1, true);
    } else {
      doubleChance.insert(1, false);
    }
    // if team 1 or Team 2
    if (t1FT > t2FT || t1FT < t2FT) {
      doubleChance.insert(2, true);
    } else {
      doubleChance.insert(2, false);
    }

    return doubleChance;
  }

  dynamic overUnderArray(int t1FT, int t2FT) {
    // Full Time Over Under
    // sum the two score values
    int lastScore = t1FT + t2FT;
    // do calculation here
    lastScore > 0.5 ? overUnder.insert(0, true) : overUnder.insert(0, false);
    lastScore < 0.5 ? overUnder.insert(1, true) : overUnder.insert(1, false);
    lastScore > 1.5 ? overUnder.insert(2, true) : overUnder.insert(2, false);
    lastScore < 1.5 ? overUnder.insert(3, true) : overUnder.insert(3, false);
    lastScore > 2.5 ? overUnder.insert(4, true) : overUnder.insert(4, false);
    lastScore < 2.5 ? overUnder.insert(5, true) : overUnder.insert(5, false);
    lastScore > 3.5 ? overUnder.insert(6, true) : overUnder.insert(6, false);
    lastScore < 3.5 ? overUnder.insert(7, true) : overUnder.insert(7, false);
    lastScore > 4.5 ? overUnder.insert(8, true) : overUnder.insert(8, false);
    lastScore < 4.5 ? overUnder.insert(9, true) : overUnder.insert(9, false);
    lastScore > 5.5 ? overUnder.insert(10, true) : overUnder.insert(10, false);
    lastScore < 5.5 ? overUnder.insert(11, true) : overUnder.insert(11, false);

    return overUnder;
  }

  dynamic oddEvenArray(int t1FT, int t2FT) {
    // Full Time Odds for odd and Even / Impair et Pair
    if ((t1FT + t2FT) % 2 == 0) {
      oddEven.insert(0, false); // odd
      oddEven.insert(1, true); // Even
    } else {
      oddEven.insert(0, true); // odd
      oddEven.insert(1, false); // Even
    }
    // team 1 full time
    if (t1FT % 2 == 0) {
      oddEven.insert(2, false); // odd
      oddEven.insert(3, true); // Even
    } else {
      oddEven.insert(2, true); // odd
      oddEven.insert(3, false); // Even
    }
    // team 2 full time
    if (t2FT % 2 == 0) {
      oddEven.insert(4, false); // odd
      oddEven.insert(5, true); // Even
    } else {
      oddEven.insert(4, true); // odd
      oddEven.insert(5, false); // Even
    }

    return oddEven;
  }

  dynamic bothTeamsToScoreArray(int t1FT, int t2FT) {
    if (t1FT > 0 && t2FT > 0) {
      bothTeamsToScore.insert(0, true);
      bothTeamsToScore.insert(1, false);
    } else {
      bothTeamsToScore.insert(0, false);
      bothTeamsToScore.insert(1, true);
    }
    return bothTeamsToScore;
  }

  dynamic oneTimesTwoArray(
      int t1h1, int t2h1, int t1h2, int t2h2, int t1FT, int t2FT) {
    // 1x2 ==> Full Time [ Team1 - Draw - Team2 ]
    // team 1 update
    if (t1FT > t2FT) {
      oneTimesTwo.insert(0, true);
    } else {
      oneTimesTwo.insert(0, false);
    }
    // draw update
    if (t1FT == t2FT) {
      oneTimesTwo.insert(1, true);
    } else {
      oneTimesTwo.insert(1, false);
    }
    // team 2 update
    if (t1FT < t2FT) {
      oneTimesTwo.insert(2, true);
    } else {
      oneTimesTwo.insert(2, false);
    }
    // Half 1 team 1 update
    if (t1h1 > t2h1) {
      oneTimesTwo.insert(3, true);
    } else {
      oneTimesTwo.insert(3, false);
    }
    // draw update
    if (t1h1 == t2h1) {
      oneTimesTwo.insert(4, true);
    } else {
      oneTimesTwo.insert(4, false);
    }
    // team 2 update
    if (t1h1 < t2h1) {
      oneTimesTwo.insert(5, true);
    } else {
      oneTimesTwo.insert(5, false);
    }
    // Half 2 team 1 update
    if (t1h2 > t2h2) {
      oneTimesTwo.insert(6, true);
    } else {
      oneTimesTwo.insert(6, false);
    }
    // draw update
    if (t1h2 == t2h2) {
      oneTimesTwo.insert(7, true);
    } else {
      oneTimesTwo.insert(7, false);
    }
    // team 2 update
    if (t1h2 < t2h2) {
      oneTimesTwo.insert(8, true);
    } else {
      oneTimesTwo.insert(8, false);
    }

    return oneTimesTwo;
  }
}
