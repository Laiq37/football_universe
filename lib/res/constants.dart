import 'dart:convert';

enum DataSourceType {
  local,
  network
}

enum NewsListType{
  daily,
  main,
  favorite,
}

enum MatchDataType{
  predata,
  livedata,
  enddata,
}

enum SportType{
  soccer,
  basketball,
  icehockey,
  tennis,
  esport,
  boxing,
}

class SVG {
  static const String calender = "assets/images/calender.svg";
  static const String filter = "assets/images/filter.svg";
  static const String menu = "assets/images/menu.svg";
  static const String cancel = "assets/images/cancel.svg";
  static const String switchEnable = "assets/images/switch_enable.svg";
  static const String switchDisable = "assets/images/switch_disable.svg";
}

class Images{
  static const String mainNews = "assets/images/main_news.png";
  static const String dailyNews = "assets/images/daily_news.png";
  static const String favorite = "assets/images/favorite.png";
  static const String notFavorite = "assets/images/not_favorite.png";
  static const String calender = "assets/images/calender.png";
  static const String matches = "assets/images/matches.png";
  static const String settings = "assets/images/settings.png";
  static const String favorites = "assets/images/favorites.png";
  static const String imagePlaceHolder = "assets/images/image_place_holder.png";
}

class ConstantStrings{
  static const String footballUniverse =  "football";
  static const String calender= "Calendar";
  static const String newsDetail = "News Details";
  static const String news = "News";
  static const String mainNews = "Main News";
  static const String dailyNews = "Daily News";
  static const String matches= "Matches";
  static const String favorites = "Favorites";
  static const String settings = "Settings";
  static const String privacy_policy = "Privacy Policy";

  static const List<String> sportList = [
      "Football",
      "Basketball",
      "Tennis",
      "MMA",
      "Cybersport",
      "Hockey",
      "All"
    ];

  //url
  static const String newsBaseUrl = "https://www.sports.ru/stat/export/iphone/";
  static const String matchesBaseUrl = "https://spoyer.com/api/en/get.php";
  static const String privacyPolicyUrl = "https://doc-hosting.flycricket.io/football-universe-privacy-policy/ab270162-c1f5-4149-ae58-44ca42a98769/privacy";

  //categories
  static const Map<String, dynamic> categoriesAndId = {
    "Football":{
      "name": SportType.soccer,
      "id": '208',
    },
    "Basketball":{
      "name": SportType.basketball,
      "id": '210',
    },
    "Tennis":{
      "name": SportType.tennis,
      "id": '212',
    },
    "MMA":{
      "name": SportType.boxing,
      "id":'213',
    },
    "Cybersport":{
      "name": SportType.esport,
      "id":"35519361",
    },
    "Hockey":{
      "name": SportType.icehockey,
      "id":'209',
    }
  };

}

