import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_pumpkin/feature/form_input/controller/provider.dart';

import '../../../constants/constant.dart';
import '../../../shared_component/dialog_alert.dart';
import '../../../utils/services/shared_preference.dart';

class ChStockAsyncNotifier extends AsyncNotifier<dynamic> {
  @override
  build() async {
    return loadCheckCompleteP();
  }

  Future<List<Map<String, dynamic>>> loadCheckCompleteP() async {
    final pref = await Preference.instance.prefs;

    List<String>? getSaveDataComplete =
        pref.getStringList(checkCompleteProductKey);

    List<Map<String, dynamic>> saveData = [];
    if (getSaveDataComplete != null) {
      for (String jsonString in getSaveDataComplete) {
        try {
          Map<String, dynamic> decode = json.decode(jsonString);
          saveData.add(decode);
        } catch (e) {
          log(e.toString());
        }
      }
    }
    return saveData;
  }

  Future<List<Map<String, dynamic>>> loadWaitCheckProduct() async {
    final pref = await Preference.instance.prefs;
    List<String>? getSaveDataComplete = pref.getStringList(checkProductKey);
    List<Map<String, dynamic>> saveData = [];
    if (getSaveDataComplete != null) {
      for (String jsonString in getSaveDataComplete) {
        try {
          Map<String, dynamic> decode = json.decode(jsonString);
          saveData.add(decode);
        } catch (e) {
          log(e.toString());
        }
      }
    }
    //  print(saveData);
    return saveData;
  }

  void addStock(
      {String? area,
      String? product,
      String? quantity,
      BuildContext? context}) async {
    final prefs = await Preference.instance.prefs;
    List<Map<String, dynamic>> verified = []; // ผลลัพสุดท้าย
    Map<String, dynamic> newQuantity = {
      "area": area,
      "product": product,
      "quantity": quantity
    };
    List<Map<String, dynamic>> getWaitCheckMap = await loadWaitCheckProduct();
    List<Map<String, dynamic>> getCheckComplete = await loadCheckCompleteP();
    bool foundMatch = false;
    for (var element in getCheckComplete) {
      if (element['area'] == newQuantity['area'] &&
          element['product'] == newQuantity['product']) {
        foundMatch = true;
        dialogAlert(
            context: context!,
            content: Text("สินค้านี้ตรวจเสร็จไปแล้ว"),
            onTap: () {
              Navigator.pop(context);
            });
        print("ค่าตรงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงงง");
        break; // Break the loop if an exact match is found
      }
    }

// If the loop finished without finding an exact match, add newQuantity to getWaitCheckMap

    if (!foundMatch) {
      getWaitCheckMap.add(newQuantity);
      List<String> setWaitCheckMap = [];
      for (var element in getWaitCheckMap) {
        String encode = json.encode(element);
        setWaitCheckMap.add(encode);
      }

      prefs.setStringList(checkProductKey, setWaitCheckMap);
    }

    //**** 2 vale
    Map<String, List<int>> group2value = {};

    for (int i = 0; i < getWaitCheckMap.length; i++) {
      String key =
          '${getWaitCheckMap[i]["area"]}-${getWaitCheckMap[i]["product"]}-${getWaitCheckMap[i]["quantity"]}';
      if (group2value.containsKey(key)) {
        group2value[key]?.add(i);
      } else {
        group2value[key] = [i];
      }
    }

    Map<String, int> finalIndexes2value = {};
    group2value.forEach((key, value) {
      if (value.length == 2) {
        finalIndexes2value[key] = value.last;
      }
    });
    // print(finalIndexes2value);
    // print("---------------------------------------------------------");
    finalIndexes2value.forEach((key, value) {
      //  print("Group $key is index $value = ${getWaitCheckMap[value]}");
      verified.add(getWaitCheckMap[value]);
    });
    //   print("---------------------------------------------------------");

    //**** 3 vale
    Map<String, List<int>> groupIndices = {};

// Group indices by area and product
    for (int i = 0; i < getWaitCheckMap.length; i++) {
      String key =
          '${getWaitCheckMap[i]["area"]}-${getWaitCheckMap[i]["product"]}';
      if (groupIndices.containsKey(key)) {
        groupIndices[key]?.add(i);
      } else {
        groupIndices[key] = [i];
      }
    }
// Filter out groups with three indexes

    Map<String, int> finalIndexes3value = {};
    groupIndices.forEach((key, value) {
      if (value.length == 3) {
        finalIndexes3value[key] = value.last;
      }
    });

    //   print(finalIndexes3value);
//    print("---------------------------------------------------------");

// Print final index values
    finalIndexes3value.forEach((key, value) {
      verified.add(getWaitCheckMap[value]);
      // print("Group $key is index $value = ${waitCheckMap[value]}");
    });
    List<String> setVerified = [];
    for (var element in verified) {
      String encode = json.encode(element);
      setVerified.add(encode);
    }

    prefs.setStringList(checkCompleteProductKey, setVerified);

    int beforeIndex = ref.read(defolIndex.notifier).state;
    int updateIndexs = ref.read(updateIndex.notifier).state = verified.length;

    if (beforeIndex != updateIndexs) {
      dialogAlert(
          context: context!,
          content: Text("ตรวจนำสำเร็จ"),
          onTap: () {
            Navigator.pop(context);
          });
      ref.read(defolIndex.notifier).state = updateIndexs;
    }

    final saveData = await loadCheckCompleteP();
    state = AsyncData(saveData);
  }
}
