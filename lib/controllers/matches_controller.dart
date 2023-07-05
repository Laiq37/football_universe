import 'dart:async';

import 'package:football_universe/models/sport_match.dart';
import 'package:football_universe/repositories/match_repository.dart';
import 'package:football_universe/res/constants.dart';
import 'package:get/get.dart';

class MatchesController extends GetxController {
  final RxList<SportMatch> matchesList = <SportMatch>[].obs;
  final RxList<DateTime> selectedDates = <DateTime>[DateTime.now(),
    DateTime.now().add(
     const Duration(days: 1),
    ),
    DateTime.now().add(
      const Duration(days: 2),
    ),
    DateTime.now().add(
     const Duration(days: 3),
    )].obs;
  final RxList<SportMatch> favoriteMatches = <SportMatch>[].obs;
  final RxList<String> favoriteMatchesId = <String>[].obs;
  final MatchRepository matchRepository = MatchRepository();
  RxInt selectedTab = 0.obs;
  RxBool isLoading = false.obs;

  Future<void> get(DataSourceType dataSourceType,{bool init= false}) async {
    try {
      if ((dataSourceType == DataSourceType.local && favoriteMatches.isNotEmpty) || (dataSourceType == DataSourceType.network && matchesList.isNotEmpty && !init))return;
      if(dataSourceType == DataSourceType.network)Future.delayed(Duration.zero,()=>isLoading.value = true);
      final List<SportMatch> matches =
          await matchRepository.get(dataSourceType);
      if (dataSourceType == DataSourceType.local) {
        favoriteMatches..clear()..addAll(matches);
        favoriteMatchesId..clear()..addAll(favoriteMatches.map((match) => match.id));
      } else {
        matchesList.clear();
        matchesList.addAll(matches);
      }
    } 
    on TimeoutException{
      isLoading.value = false;
      rethrow;
    } 
    catch (err) {
      print(err);
    }finally{
      isLoading.value = false;
    }
  }

  bool isInFavorite(String id){
    return favoriteMatchesId.contains(id);
  }

  void add(SportMatch match) async {
    try {
      favoriteMatches.insert(0, match);
      favoriteMatchesId.add(match.id);
      await MatchRepository().add(match);
    } catch (err) {
      favoriteMatches.removeWhere((eachmatch)=>eachmatch.id == match.id);
      favoriteMatchesId.remove(match.id);
      print(err);
    }
  }

  void remove(String id) async {
      final index =favoriteMatches.indexWhere((match) => match.id == id);
      final removedMatches = favoriteMatches.removeAt(index);
      favoriteMatchesId.remove(id);
    try {
      await MatchRepository().remove(id);
    } catch (err) {
      favoriteMatches.insert(index, removedMatches);
      favoriteMatchesId.add(removedMatches.id);
      print(err);
    }
  }
}
