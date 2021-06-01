const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const database = admin.firestore();

exports.timerUpdateGames = functions.pubsub.schedule('* * * * *').onRun((context) => {
    database.collection('Games').get().then((result) => {
        // print('The result is: ' + result);
        for (var i = 0; i < result.docs.length; i++) {
            // get the seconds remaining of a certain games before starting
            var _thisSeconds = (result[i]['sorter'].seconds - admin.firestore.Timestamp.now().seconds);
            // get the admin firestore current timestamp
            // Timestamp currentTime = Timestamp.fromDate(new DateTime.now());
            // remove the game if it is less than 150 or 0 or less than 0
            if (_thisSeconds <= 150) {
                // this game needs to be removed
                database.collection('Games').document(result[i].documentID).delete();
                // .then((value) => {
                // print('Game ' + result[i].documentID + ' successfully deleted');
                //     return null;
                // }).catch((e) => {
                //     print('the error is ' + e);
                // });
            }
            // else leave the game in the COLLECTION
            // loop through all games and remove older ones based on sorter timestamp and current datetime timestamp
            // if the difference of seconds is equal or less than 150, delete the game else leave it in collection
            // print(result[i]['status']);
            // print(result[i]['championship']);
            // print(result[i]['sorter']);
            // print(result[i]['team1'] + ' - ' + result[i]['team2']);
        }
        return null;
    }).catch((e) => {
        // print('the error is : ' + e);
    });
    // console.log('Time update for Games success');
    return null;
});

// CURRENT DATETIME IS ALWAYS BIGGER THAN THE PAST SO WE WILL CONSIDER USING ABSOLUTE VALUES

// Timestamp customTimeStamp = Timestamp.fromDate(
//     new DateTime(
//         int.parse('2020'),
//         int.parse('9'),
//         int.parse('27'),
//         int.parse('22'),
//         int.parse('10'))); //To TimeStamp

// Timestamp currentTime =
//     Timestamp.fromDate(new DateTime.now());

// int diff =
//     (currentTime.seconds - customTimeStamp.seconds).abs();

// if (diff <= 150) {
//   // there is only 2 minutes remaining before the game start
//   // so, delete the game from the collection games
//   print(
//       'The diff is : $diff ,that means the games will be removed from the collection');
// } else {
//   print(
//       'The diff is : $diff ,that means the games will remain in the collection');
//   // if not, leave the game alone
// }

// print('SECONDS SUSTOM: ${customTimeStamp.seconds}');
// print('CURRENT SUSTOM: ${currentTime.seconds}');
// print(
//     'DIFF SECONDS: ${currentTime.seconds - customTimeStamp.seconds}');
// print(
//     'DIFF MINUTES: ${(currentTime.seconds - customTimeStamp.seconds) / 60}');
// var thishour =
//     (currentTime.seconds - customTimeStamp.seconds) /
//         3600;
// var thismin = thishour / 60;
// var thissec = thismin / 60;
// print('Hour: $thishour - Min: $thismin - Sec: $thissec');
// print(
//     'DIFF HOUR: ${(currentTime.seconds - customTimeStamp.seconds) / 3600}');

// print('CUSTOM TIMESTAMP: $customTimeStamp');
// print('CURRENT TIMESTAMP: $currentTime');
// print('DIFF: ${currentTime - customTimeStamp}');
// DateTime myDateTime =
//     gamesSorter.toDate(); // TimeStamp to DateTime
// print('Timestamp: $gamesSorter');
// print('DateTime: $myDateTime');