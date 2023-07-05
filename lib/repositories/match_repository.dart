import 'package:flutter/foundation.dart';
import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/data/local/matches_local_impl.dart';
import 'package:football_universe/data/network/matches_network_impl.dart';
import 'package:football_universe/models/sport_match.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/helper_functions.dart';

class MatchRepository{
  Future<dynamic> get(DataSourceType dst) async {
    final DataSource ds =
        dst == DataSourceType.local ? MatchesLocalImpl() : MatchesNetworkImpl();
    final matchesData = await ds.getData('');
    if(dst == DataSourceType.local)return List<SportMatch>.from( matchesData);
    final List<SportMatch> matchesList = await compute<dynamic,List<SportMatch>>(HelpersFunctions.sortMatches,matchesData);
    
    // throw Exception("error");
    return matchesList.toSet().toList();
  }
  
  Future<void> add(SportMatch sportMatch) async {
    await MatchesLocalImpl().add(sportMatch);
  }

  Future<void> remove(String id) async {
    await MatchesLocalImpl().remove(id);
  }
}