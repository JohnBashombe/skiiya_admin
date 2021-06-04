import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:skiiya_admin/admin/addGame/const/url.dart';
import 'package:skiiya_admin/admin/addGame/entities/match.dart';

class FetchMatch {
  // This initializes the URL Class
  URL _url = new URL();

  // Fetchning Methods
  Future fetchMatches(String _todayDate) async {
    // THE GET RESPONSE FOR TODAY MATCHES
    var matchResponse =
        await http.get(_url.urlFetchMatchByDate(_todayDate)).catchError((e) {
      print('The error while loading matches: $e');
    });

    // ignore: deprecated_member_use
    // var matches = List<Match>(); // Match Instance
    var matches = []; // Match Instance

    if (matchResponse.statusCode == 200) {
      // DECODE THE JSON FILE CONTAINING MATCHES
      var matchesJson = json.decode(matchResponse.body);
      // LET US LOOP THROUGH THE DATA TO UPLOAD THEM INSIDE DART INSTANCE
      for (int _data = 0; _data < matchesJson['data'].length; _data++) {
        // WE CREATE _data MATCH INSTANCE OF MATCH CLASS
        matches.add(Match.fromJson(matchesJson['data'][_data]));
        // PRINTING NOTES OR GAMES ID
        addSearchKey(matches[_data]);
        // LET US FETCH THE ODDS NOW
        // print("Match: ${matches[_data]}");
        // WE WILL BE LOOPING HERE TO ADD ODDS TO EVERY SINGLE MATCH
        fetchOdds(matches[_data]);
      }
    }
    return matches;
  }

  addSearchKey(Match match) {
    // LET US ADD THE SEARCH KEYS FOR EVERY SINGLE MATCH HERE
    // WE GET THE FIRST LETTER OF SHORT_CODE FOR THE LOCAL TEAM MATCH
    String searchKey1;
    String searchKey2;
    // CHECK IF THE SHORTNAME IS NULL TO TAKE THE REAL TEAM NAME
    if (match.localTeam['data']['short_code'] == null) {
      searchKey1 = match.localTeam['data']['name']
          .toString()
          .substring(0, 1)
          .toLowerCase();
    } else {
      // IF NOT NULL USE THE SHORT_NAME VALUE
      searchKey1 = match.localTeam['data']['short_code']
          .toString()
          .substring(0, 1)
          .toLowerCase();
    }
    // WE ADD IT TO THE ARRAY SEARCH KEY
    match.searchKey.add(searchKey1);

    // WE GET THE FIRST LETTER OF SHORT_CODE FOR THE VISITOR TEAM MATCH
    if (match.visitorTeam['data']['short_code'] == null) {
      searchKey2 = match.visitorTeam['data']['name']
          .toString()
          .substring(0, 1)
          .toLowerCase();
    } else {
      // IF NOT NULL USE THE SHORT_NAME VALUE
      searchKey2 = match.visitorTeam['data']['short_code']
          .toString()
          .substring(0, 1)
          .toLowerCase();
    }
    // WE ADD IT TO THE ARRAY SEARCH KEY
    match.searchKey.add(searchKey2);

    // PRINTING SHORT_NAME FOR DEBUGGING PURPOSES
    // print('name Local: ${match.localTeam['data']['name']}');
    // print('Short name Local: ${match.localTeam['data']['short_code']}');
    // print('Key Local: $searchKey1');
    // print('name Visitor: ${match.visitorTeam['data']['name']}');
    // print('Short name Visitor: ${match.visitorTeam['data']['short_code']}');
    // print('Key Visitor: $searchKey2');
  }

  Future<List> fetchOdds(Match match) async {
    // CHECK IF THE GAME HAS ALREADY STATED
    // TO CHANGE THE STATUS OF THE GAME BEFORE UPLOADING IT TO THE DATABASE
    // CHECK THE GEM STATUS BUT DO CHECK OUR CUSTOM VERIFICATION TOO
    // THIS METHOD CHECKS WEITHER A MATCH HAS STARTED
    // OR IT'S ABOUT TO START IN 1MIN OR LESS
    updateMatchStatus(match);

    // SET ALL THE FIREBASE CONFIGURATION TO THE APP AND UPLOAD DATA INTO THE DATABASE
    // ignore: deprecated_member_use
    var odds; // Odds instance of a single Match

    // FETCH THE ODDS OF EVERY SINGLE MATCH
    // THE GET RESPONSE FOR TODAY MATCHES
    var oddResponse = await http
        .get(_url.urlFetchMatchByIdAndBookmakerId(match.id, '70'))
        .catchError((e) {
      print('The error while loading odds: $e');
    });

    // CHECKING THE RESULT
    if (oddResponse.statusCode == 200) {
      // DECODE THE JSON FILE
      var oddsJson = json.decode(oddResponse.body);

      // THIS CONTAIN ALL ODDS FOR THIS PARTICULAR GAME
      // This varaibles hold all the odds data for this particular Match
      odds = oddsJson['data'];

      // WILL CONFIRM IF WE HAVE THAT 3WAY ODDS OR NOT
      bool isThere3WayResult = false;

      // WE NEED TO STORE APART THE 3WAY ODDS FOR USER DISPLAY
      // WE NEED TO GET IT FROM THE NEWLY FETCHED ARRAY OF ODDS
      for (int _index = 0; _index < odds.length; _index++) {
        // CHECK FOR THE ODD WITH ID=1 [THAT'S 3WAY Result]
        if (odds[_index]['id'] == 1) {
          // ADD THE 3WAY DATA ODD TO THE NEW ARRAY AND UPDATE THE MATCH INSTANCE
          match.threeWayOdds = odds[_index];
          // update the boolean
          isThere3WayResult = true;
          // break the loop
          break;
        }
      }

      // This game will be added only if we have that value
      // Otherwise the game and the odds will be discarded from being added to the system
      // IF A GAME HAS 3WAY RESULT, ADD IT TO THE COLLECTION [football(basic details), matches(odds)]
      if (isThere3WayResult) {
        // INSERT THE GAME INTO THE COLLECTIONS NOW
        // Printing the userId out
        // print('Adding the new matches to the database');
        // // print(match);
        // print(match.id);
        // print(match.status);
        // print(match.scores['ft_score']);
        bool _isScoreUpdated = false;
        // THIS WILL HELP US LATER TO UPDATE BETSLIP WITH GAMES THAT HAVE RESULTS ALREADY
        if (match.scores['ft_score'] != null) {
          _isScoreUpdated = true; // SET TO TRUE IF WE HAVE SCORES ALREADY
          // print('score detected');
        }
        // print(match.visitorTeam['data']['name']);
        // print(match.localTeam['data']['name']);
        // print(odds);
        // print('The UserID: ${_user.user.uid} has logged in');
        // IF LOGGED IN, ADD THE GAMES NOW
        // ADD FIRST THE GAMES DETAILS TO football Collection
        // if (App.user == null) {
        //   print('No user detected');
        // } else {
        // print('welcome : ${user.uid}');
        Firestore.instance
            .collection('football')
            .document(match.id.toString())
            .setData({
          'id': match.id,
          'league_id': match.league_id,
          'season_id': match.season_id,
          'stage_id': match.stage_id,
          'round_id': match.round_id,
          'group_id': match.group_id,
          'aggregate_id': match.aggregate_id,
          'venue_id': match.venue_id,
          'referee_id': match.referee_id,
          'localteam_id': match.localteam_id,
          'visitorteam_id': match.visitorteam_id,
          'winner_team_id': match.winner_team_id,
          'scores': match.scores,
          'time': match.time,
          'deleted': match.deleted,
          'localTeam': match.localTeam,
          'visitorTeam': match.visitorTeam,
          'threeWayOdds': match.threeWayOdds,
          'searchKey': match.searchKey,
          'status': match.status,
          'betslip_updated': false, // INDICATES UPDATE OF BETSLIPS STATUS
          'score_updated': _isScoreUpdated, // INDICATES SCORES RESULTS STATUS
        }).then((_result) {
          // print('Match of ID: ${match.id} added successfully');
        }).catchError((e) {
          print('adding football error: ${e.toString()}');
        });
        // THEN ADD THE ODDS DETAILS TO odds Collection
        Firestore.instance
            .collection('odds')
            .document(match.id.toString())
            .setData({'matchId': match.id, 'odds': odds}).then((value) {
          // print('Odds of ID: ${match.id} added successfully');
        }).catchError((e) {
          print('adding odds error: ${e.toString()}');
        });
        // }
      }
    }
    return odds;
  }

  void updateMatchStatus(Match match) {
    // THIS METHOD CHECKS WEITHER A MATCH HAS STARTED OR NOT
    // AND IF A MATCH IS ABOUT TO START IN 1MIN OR LESS
    // IF SO, WE UPDATE THE MATCH STATUS TO START
    int currentTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    // THE MATCH STARTING TIME IN UTC FORMAT
    int loadedTime = match.time['starting_at']['timestamp'];
    // THIS MATCH WILL TELL US IF A GAME IS STILL NOT STARTED OR STARTED
    // THAT IS 60000 = 1 MIN
    int timeMatchLimit = 60000; // 1 minute
    int _dateDiff = (loadedTime - currentTime);
    // IF THE CURRENT TIME IS GREATER THAN THE MATCH TIME
    // SET THE STATUS TO
    if (currentTime >= loadedTime) {
      // IF A MATCH IS FINISHED OR STARTED, UPDATE THE MATCH STATUS ACCORDINGLY
      if (match.time['status'].toString().compareTo('FT') == 0) {
        // IF A MATCH HAS BEEN DONE
        match.status = 'END';
      } else {
        // ELSE SET THE STATUS TO STATUS
        match.status = match.time['status'];
      }
    } else {
      // IF THE STARTED TIME IS GREATER THAN THE CURRENT TIME
      // IF A MATCH HAS NOT BEEN STARTED YET DONE
      // IF THE REMAINING TIME IS 1MIN OR LESS SET THE MATCH AS STARTED
      if (_dateDiff <= timeMatchLimit) {
        match.status = 'STARTED';
      } else {
        // ELSE SET THE STATUS TO STATUS
        match.status = match.time['status'];
      }
    }
  }
}
