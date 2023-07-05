import 'dart:convert';

import 'package:football_universe/repositories/app_repository.dart';
import 'package:football_universe/res/constants.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  final RxList<String> activeFilters = ["Football"].obs;
  final AppRepository _appRepository = AppRepository();
  RxBool showPopupMenu = false.obs;

  togglePopupMenu(){
    showPopupMenu.value = !showPopupMenu.value;
  }

  void getFilters(String key) async {
    try {
      final data = await _appRepository.get(key);
      final decodedData = jsonDecode(data!);
      activeFilters.clear();
      activeFilters.addAll(List<String>.from(decodedData));
    } catch (err) {
      print(err);
    }
  }

  void setFilters(String filter) async {
    final lastFilterList = activeFilters;
    try {
      //check if filter already enabled list
      if (activeFilters.contains(filter)) {
        if (filter == 'All') {
          //remove all filters and add one to atleadst get data
          activeFilters.clear();
          activeFilters.add(ConstantStrings.sportList[0]);
          await _appRepository.remove('filter');
          return;
        } else {
          //remove specific filter
          activeFilters.remove(filter);
          if(activeFilters.length == ConstantStrings.sportList.length-1)activeFilters.remove("All");
          if(activeFilters.isEmpty)activeFilters.add(ConstantStrings.sportList[0]);
          await _appRepository.add("filter", jsonEncode(activeFilters));
        }
        return;
      }
      if (filter == 'All') {
        //add all filter
        activeFilters.clear();
        activeFilters.addAll(ConstantStrings.sportList);
        await _appRepository.add("filter", jsonEncode(activeFilters));
        return;
      } else {
        //add specific filter
        activeFilters.add(filter);
        if(activeFilters.length==ConstantStrings.sportList.length-1)activeFilters.add("All");
        await _appRepository.add("filter", jsonEncode(activeFilters));
      }
    } catch (e) {
      print(e);
      activeFilters.clear();
      activeFilters.addAll(lastFilterList);
    }
  }
}
