import 'package:skiiya_admin/admin/addGame/const/const.dart';

class URL {
  // INITIALIZATION OF INSTANCE
  Const c = new Const();

  Uri urlFetchMatchByDate(String date) {
    // THIS URL FETCH MATCHES BY TODAY DATE
    var url = Uri.parse(
        '${c.header}/api/v2.0/fixtures/date/$date?api_token=${c.apiToken}&include=${c.include}');
    // RETURN THE FETCH MATCH BY DATETIME URL
    return url;
  }

  Uri urlFetchMatchByIdAndBookmakerId(int matchID, String bookMakerID) {
    var url = Uri.parse(
        '${c.header}/api/v2.0/odds/fixture/$matchID/bookmaker/$bookMakerID?api_token=${c.apiToken}');
    // RETURN THE FETCH MATCH BY DATETIME URL
    return url;
  }

  Uri urlFetchLeagues() {
    var url = Uri.parse('${c.header}/api/v2.0/leagues?api_token=${c.apiToken}');
    // RETURN THE FETCH LEAGUES BY DATETIME URL
    return url;
  }

  Uri urlFetchCountries() {
    var url =
        Uri.parse('${c.header}/api/v2.0/countries?api_token=${c.apiToken}');
    // RETURN THE FETCH COUNTRIES BY DATETIME URL
    return url;
  }
}
