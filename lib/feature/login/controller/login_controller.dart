import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_pumpkin/utils/services/shared_preference.dart';

import '../../../constants/constant.dart';
import '../../../shared_component/dialog_alert.dart';

class LoginAsyncNotifier extends AsyncNotifier<dynamic> {
  void saveSession({String? username}) async {
    final prefs = await Preference.instance.prefs;
    //***setDatabaseUser***
    Map<String, dynamic> userDataBase = {"username": username, "saveData": []};

    //*** save session
    String encodedMapUser = json.encode(userDataBase);
    prefs.setString(sessionKey, encodedMapUser);

    //*** save Database_User
    saveDBUser();

    final newSession = await loadDataUser();
    state = AsyncData(newSession);
  }

  void saveDBUser() async {
    final prefs = await Preference.instance.prefs;
    //*** save Database_User
    List<String>? databaseUsername = prefs.getStringList(
        databaseUserKey); //get (ListString) เพื่อให้ได้ข้อมูลปัจจุบัน
    String session = prefs.getString(sessionKey) ??
        'Save: No getdata'; // get (String) เพื่อให้ได้ข้อมูลปัจจุบัน
    if (databaseUsername != null) {
      Map<String, dynamic> decodedMapSession =
          json.decode(session); //convert String to Map<String, dynamic>

      //convert List<String> to List<Map<String, dynamic>>
      List<Map<String, dynamic>> users = [];
      for (String jsonString in databaseUsername) {
        try {
          Map<String, dynamic> decodeDBUserMap = json.decode(jsonString);
          users.add(decodeDBUserMap);
        } catch (e) {
          log(e.toString());
        }
      }
      List<String> usernameList = [];
      for (var user in users) {
        usernameList.add(user['username']);
      }
      if (!usernameList.contains(decodedMapSession['username'])) {
        log("yesData111111111111111111111111111111111111");

        databaseUsername.add(session);
        prefs.setStringList(databaseUserKey, databaseUsername);
      }
    } else {
      log("nodata5555555555555555555555555555555555555555");
      prefs.setStringList(databaseUserKey, [session]);
    }
  }

  List<Map<String, dynamic>> loadDBProduct() {
    List<Map<String, dynamic>> dbMainProduct = [
      {
        "area": "A001",
        "product": "P001",
      },
      {
        "area": "A001",
        "product": "P002",
      },
      {
        "area": "A001",
        "product": "P003",
      },
      {
        "area": "A001",
        "product": "P004",
      },
      {
        "area": "A002",
        "product": "P001",
      },
      {
        "area": "A002",
        "product": "P002",
      },
      {
        "area": "A002",
        "product": "P003",
      },
      {
        "area": "A002",
        "product": "P004",
      },
      {
        "area": "A003",
        "product": "P001",
      },
      {
        "area": "A004",
        "product": "P001",
      },
      {
        "area": "A004",
        "product": "P002",
      },
    ];
    return dbMainProduct;
  }

  Future<dynamic> loadDataUser() async {
    final pref = await Preference.instance.prefs;
    String? encodedMapSession = pref.getString(sessionKey);
    Map<String, dynamic> decodedMap =
        json.decode(encodedMapSession ?? 'getNoData');

    List<String>? encodedMapListSession = pref.getStringList(databaseUserKey);

    List<Map<String, dynamic>> users = [];

    for (String jsonString in encodedMapListSession!) {
      try {
        Map<String, dynamic> parsedMap = json.decode(jsonString);
        users.add(parsedMap);
      } catch (e) {
        log(e.toString());
      }
    }

    for (var user in users) {
      if (user["username"] == decodedMap['username']) {
        // Display all information associated with the user
        //  print('Username: ${user}');
        return user;
      }
    }
  }

  void saveProduct(
      {String? area,
      String? product,
      String? quantity,
      BuildContext? context}) async {
    final pref = await Preference.instance.prefs;

    Map<String, dynamic> newData = {
      "area": area,
      "product": product,
      "quantity": quantity,
    };
    final userSuccessLogin = await loadDataUser();
    List<String>? getDatabaseUser = pref.getStringList(databaseUserKey);

    List<Map<String, dynamic>> dataBaseUser = [];
    for (String jsonString in getDatabaseUser!) {
      try {
        Map<String, dynamic> parsedMap = json.decode(jsonString);
        dataBaseUser.add(parsedMap);
      } catch (e) {
        log(e.toString());
      }
    }
    bool matchDBP = false;
    for (var element in loadDBProduct()) {
      if (element['area'] == newData['area'] &&
          element['product'] == newData['product']) {
        matchDBP = true;
        break;
      }
    }

    if (matchDBP) {
      // Find the index of the entry with username 'g'
      int indexUsername = dataBaseUser.indexWhere(
          (entry) => entry['username'] == userSuccessLogin['username']);
      if (indexUsername != -1) {
        // Access the saveData list of the 'g' entry
        List<dynamic> saveData =
            List.from(dataBaseUser[indexUsername]['saveData']);

        //check area product
        bool matchFound = false;
        for (var data in saveData) {
          if (data['area'] == newData['area'] &&
              data['product'] == newData['product']) {
            matchFound = true;
            break;
          }
        }

        if (matchFound) {
          for (var a in loadDBProduct()) {
            print(a);
          }
          dialogAlert(
              context: context!,
              content: Text("! คุณเคยบันทึกสินค้านี้ไปแล้ว"),
              onTap: () {
                Navigator.pop(context);
              });
          log("nooooooooo");
        } else {
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: const Text('บันทึกสำเร็จ'),
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: 'ปิด',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context!).showSnackBar(snackBar);

          log("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
          // Add the new data to the saveData list
          saveData.add(newData);

          // Update the 'saveData' field of the 'g' entry
          dataBaseUser[indexUsername]['saveData'] = saveData;
          List<String> updateDBUser = [];
          for (var element in dataBaseUser) {
            String encodedMapUser = json.encode(element);
            updateDBUser.add(encodedMapUser);
          }
          pref.setStringList(databaseUserKey, updateDBUser);
        }
      }
    } else {
      dialogAlert(
          context: context!,
          content: Text("! ไม่มีข้อมูลนี้ในฐานข้อมูล"),
          onTap: () {
            Navigator.pop(context);
          });
      debugPrint(">>>>>>>>>>>fffffffffffffffffffffffffffff<<<<<<<<");
    }

    final newSession = await loadDataUser();
    state = AsyncData(newSession);
  }

  @override
  build() async {
    return loadDataUser();
  }
}

//final testNotifyProvider = NotifierProvider<TestNotify, String>(TestNotify.new);
