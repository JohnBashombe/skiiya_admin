import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:skiiya_admin/admin/addGame/const/url.dart';

class Leagues {
  // This initializes the URL Class
  URL _url = new URL();
  // Fetchning Methods
  Future<List> fetchLeagues() async {
    // THE GET RESPONSE FOR TODAY MATCHES
    var response = await http.get(_url.urlFetchLeagues()).catchError((e) {
      print('The error while loading leagues: $e');
    });

    // Leagues array Instance
    var leagues = [];

    if (response.statusCode == 200) {
      // DECODE THE JSON FILE CONTAINING MATCHES
      var leaguesJson = json.decode(response.body);
      // LET US LOOP THROUGH THE DATA TO UPLOAD THEM INSIDE DART INSTANCE
      // for (int _data = 0; _data < matchesJson['data'].length; _data++) {
      // WE CREATE _data MATCH INSTANCE OF MATCH CLASS
      // WE ASSIGN ALL THE VALUES TO THE LEAGUE ARRAY
      leagues = leaguesJson['data'];
      // matches.add(Match.fromJson(matchesJson['data'][_data]));
      // PRINTING NOTES OR GAMES ID
      // }
      // STORE THE VALUE IN THE DATABASE
      if (leagues.length > 0) {
        Firestore.instance
            .collection('leagues')
            .document(
                'league') // WE SET A FIXED ID HERE TO AVOID MULTIPLE DATA WRITING
            .setData({'data': leagues}).then((_result) {
          print('Leagues added successfully');
        }).catchError((e) {
          print('adding leagues error: ${e.toString()}');
        });
      }
    }
    return leagues;
  }
}
