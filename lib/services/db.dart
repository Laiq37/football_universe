import 'package:football_universe/models/news.dart';
import 'package:football_universe/models/sport_match.dart';
import 'package:football_universe/res/constants.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class DB {
  static void init() async {
    final document = await getApplicationDocumentsDirectory();
    Hive.initFlutter(document.path);
    Hive.registerAdapter<News>(NewsAdapter());
    Hive.registerAdapter<SportMatch>(SportMatchAdapter());
  }

  static dynamic get<String>(String key) async {
    final Box box = await Hive.openBox(ConstantStrings.footballUniverse);
    return box.get(key);
  }

  static dynamic set(key, data) async {
    final Box box = await Hive.openBox(ConstantStrings.footballUniverse);
    var collection = await DB.get(key);
    if(collection == null){
      collection = [data];
    }else{
      final index = collection.indexWhere((news) => news.id == data);
      if(index == -1){
        collection.add(data);
      }
      else{
        collection.removeAt(index);
      }
    }
    box.put(key, collection);
  }
}
