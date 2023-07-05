import 'package:shared_preferences/shared_preferences.dart';
class SharedPref{
  static SharedPreferences? prefs;

  static Future<String?> get(key)async{
    prefs ??= await SharedPreferences.getInstance();
    return prefs!.getString(key);
  }
  static Future<void> add(key, value) async {
    await prefs!.setString(key, value);
  }
  static Future<void> remove(key) async {
    await prefs!.remove(key);
  }
}