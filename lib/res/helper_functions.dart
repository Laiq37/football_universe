import 'package:football_universe/controllers/app_controller.dart';
import 'package:football_universe/controllers/matches_controller.dart';
import 'package:football_universe/controllers/news_controller.dart';
import 'package:football_universe/models/news.dart';
import 'package:football_universe/models/sport_match.dart';
import 'package:football_universe/res/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelpersFunctions {
  static String enumToString(Enum enumItem) {
    String str = enumItem.toString();
    return str.substring(str.indexOf('.') + 1);
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String getResultType(selectedDate) {
    final DateTime today = DateTime.parse(formatDate(DateTime.now()));
    final DateTime userDate = DateTime.parse(selectedDate);
    if (userDate.isBefore(today)) {
      return enumToString(MatchDataType.enddata);
    } else if (userDate.isAfter(today)) {
      return enumToString(MatchDataType.predata);
    }
    return enumToString(MatchDataType.livedata);
  }

  static List getDateAndType() {
    final MatchesController controller = Get.find<MatchesController>();
    final DateTime date =
        controller.selectedDates[controller.selectedTab.value];
    final selectedDate = formatDate(date);
    return [selectedDate.replaceAll("-", ""), getResultType(selectedDate)];
  }

  static void initControllers() {
    Get.put(AppController()).getFilters("filter");
    Get.lazyPut(() => NewsController());
    Get.lazyPut(() => MatchesController());
  }

  static List<News> sortNews(dynamic newsList) {
    return List<News>.from(newsList.map((match) => News.fromJson(match)))
      ..sort(
        (a, b) => b.postTime.compareTo(a.postTime),
      );
  }

  static List<SportMatch> sortMatches(dynamic matchList) {
    return List<SportMatch>.from(
        matchList.map((match) => SportMatch.fromJson(match)))
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}
