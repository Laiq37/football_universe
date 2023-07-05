import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_universe/controllers/app_controller.dart';
import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/helper_functions.dart';
import 'package:football_universe/services/network.dart';
import 'package:get/get.dart';

class MatchesNetworkImpl implements DataSource {
  // dynamic _processData
  @override
  Future getData(data) async {
    // final String matchDataType = ;
    final dateAndType = HelpersFunctions.getDateAndType();
    List dataList = [];
    final AppController appController = Get.find<AppController>();
    for (var filter in appController.activeFilters) {
      if (filter == 'All') continue;
      var login = dotenv.env["LOGIN"];
      var token = dotenv.env["TOKEN"];
      var data = await compute(NetWork.fetchData,
          '${ConstantStrings.matchesBaseUrl}?login=$login&token=$token&task=${dateAndType[1]}&sport=${HelpersFunctions.enumToString(ConstantStrings.categoriesAndId[filter]["name"])}&day=${dateAndType[0]}');
      dataList.addAll(data[dateAndType[1] == HelpersFunctions.enumToString(MatchDataType.predata)
          ? "games_pre"
          : dateAndType[1] == HelpersFunctions.enumToString(MatchDataType.enddata)
              ? "games_end"
              : "games_live"]);
    }
    //  NetWork.fetchMatches(
    //     enumToString(SportType.soccer), dateAndType[0], dateAndType[1]);

    return dataList;
  }

  @override
  Future<void> add(dynamic) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> remove(dynamic) {
    // TODO: implement remove
    throw UnimplementedError();
  }
}
