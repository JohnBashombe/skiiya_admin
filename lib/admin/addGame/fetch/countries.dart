import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:skiiya_admin/admin/addGame/const/url.dart';

class Countries {
  // This initializes the URL Class
  URL _url = new URL();
  // Fetchning Methods
  Future<List> fetchCountries() async {
    // THE GET RESPONSE FOR TODAY MATCHES
    var response = await http.get(_url.urlFetchCountries()).catchError((e) {
      print('The error while loading countries: $e');
    });

    // countries array Instance
    // ignore: deprecated_member_use
    var countries = List<Country>();

    if (response.statusCode == 200) {
      // DECODE THE JSON FILE CONTAINING MATCHES
      var countriesJson = json.decode(response.body);
      // LET US LOOP THROUGH THE DATA TO UPLOAD THEM INSIDE DART INSTANCE
      for (int _data = 0; _data < countriesJson['data'].length; _data++) {
        // // WE CREATE _data MATCH INSTANCE OF MATCH CLASS
        // // WE ASSIGN ALL THE VALUES TO THE LEAGUE ARRAY
        // countries[_data] = 'Item Data $_data';
        // matches.add(Match.fromJson(matchesJson['data'][_data]));
        // PRINTING NOTES OR GAMES ID
        // print(countriesJson['data'].length);
        if (countriesJson['data'][_data]['extra'] != null) {
          // ADD DETAILS TO ARRAY IF WE HAVE NO-NULL DATA
          countries.add(Country.fromJson(countriesJson['data'][_data]));
        }
      }

      // LOOP THROUGH THE CURRENT RESULTS AND ADD THEM TO THE DATABASE
      for (int _loop = 0; _loop < countries.length; _loop++) {
        // STORE THE VALUE IN THE DATABASE
        // if (countries.length > 0) {
        // WE SET A FIXED ID HERE TO ADD A UNIQUE COUNTRY TO THE DATABASE
        Firestore.instance
            .collection('countries')
            .document(countries[_loop].id.toString())
            .setData({
          'id': countries[_loop].id,
          'name': countries[_loop].name,
          'image_path': countries[_loop].image_path,
          'continent': countries[_loop].continent,
          'sub_region': countries[_loop].sub_region,
          'fifa': countries[_loop].fifa,
        }).then((_result) {
          // print('country ${countries[_loop].id} added successfully');
        }).catchError((e) {
          print('adding countries error: ${e.toString()}');
        });
      }
    }
    // print('countries added successfully');
    return countries;
  }
}

class Country {
  // VARIABLE DECLARATION
  int id;
  String name;
  String image_path;
  String continent;
  String sub_region;
  String fifa;

  // CONSTRUCTOR
  Country(
      {this.id,
      this.name,
      this.image_path,
      this.continent,
      this.sub_region,
      this.fifa});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      image_path: json['image_path'],
      continent: json['extra']['continent'],
      sub_region: json['extra']['sub_region'],
      fifa: json['extra']['fifa'],
    );
  }
}
