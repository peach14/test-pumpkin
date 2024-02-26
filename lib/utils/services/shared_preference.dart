import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constant.dart';

class Preference {
  final sessionKey = 'SESSION_KEY';
  final databaseUserKey = 'DatabaseUser_KEY';
  final databaseProductKey = 'DatabaseUser_KEY';
  Preference._();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  static final instance = Preference._();
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future<String> loadSession() async {
  //   final pref = await Preference.instance.prefs;
  //   String? encodedMap = pref.getString(sessionKey);
  //   Map<String, dynamic> decodedMap = json.decode(encodedMap ?? 'getNoData');
  //   return decodedMap['username'];
  // }

  // Future<String?> loadDatabase() async {
  //   final pref = await _prefs;
  //   String? encodedMapSession = pref.getString(sessionKey);
  //   Map<String, dynamic> decodedMap =
  //       json.decode(encodedMapSession ?? 'getNoData');
  //
  //   List<String>? encodedMapListSession = pref.getStringList(databaseUserKey);
  //   print(">>>>>>>>$encodedMapListSession");
  //   List<Map<String, dynamic>> result = [];
  //
  //   for (String jsonString in encodedMapListSession!) {
  //     try {
  //       Map<String, dynamic> parsedMap = json.decode(jsonString);
  //       result.add(parsedMap);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //   List<String> listUsername = [];
  //   for (Map<String, dynamic> element in result) {
  //     print(element['saveData']);
  //     listUsername.add(element['username']);
  //   }
  //
  //   if (listUsername.contains(decodedMap['username'])) {
  //     String? bValue = listUsername.firstWhere(
  //         (element) => element == decodedMap['username'],
  //         orElse: () => 'LoadData: noData');
  //
  //     return bValue;
  //   } else {
  //     String? bValue = pref.getStringList(databaseUserKey)!.last;
  //     return bValue;
  //   }
  // }
  //
  // Future<dynamic> loadData(
  //     {String? required, String? p, String? a, String? s}) async {
  //   final pref = await _prefs;
  //   String? encodedMapSession = pref.getString(sessionKey);
  //   Map<String, dynamic> decodedMap =
  //       json.decode(encodedMapSession ?? 'getNoData');
  //
  //   List<String>? encodedMapListSession = pref.getStringList(databaseUserKey);
  //
  //   List<Map<String, dynamic>> users = [];
  //
  //   for (String jsonString in encodedMapListSession!) {
  //     try {
  //       Map<String, dynamic> parsedMap = json.decode(jsonString);
  //       users.add(parsedMap);
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //
  //   for (var user in users) {
  //     if (user["username"] == decodedMap['username']) {
  //       // Display all information associated with the user
  //       print('Username: ${user}');
  //       return user;
  //       print('Save Data:');
  //
  //       break; // Stop searching once the user is found
  //     }
  //   }
  //   // List e = decodedMap["RestingTime"];
  //   // switch (required) {
  //   //   case 'map':
  //   //     return decodedMap;
  //   //
  //   //   case 'oneValueP':
  //   //     // p = '777';
  //   //     var convertP = int.parse(p ?? '');
  //   //
  //   //     for (var element in e) {
  //   //       print(element);
  //   //       if (element['a'] == convertP) {
  //   //         print(element['a']);
  //   //         return element['a'];
  //   //       }
  //   //     }
  //   // }
  //   print('------------------------------------------');
  // }

  cansel() async {
    final pref = await prefs;
    pref.remove(sessionKey);
    pref.remove(databaseUserKey);
    pref.remove(checkCompleteProductKey);
    pref.remove(checkProductKey);
  }
}
