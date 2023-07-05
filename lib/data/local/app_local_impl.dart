import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/services/shared_preferences.dart';

class AppLocalImpl extends DataSource {
  @override
  Future getData(dynamic) async {
    return await SharedPref.get(dynamic);
  }

  @override
  Future<void> add(dynamic) async {
    await SharedPref.add(dynamic[0], dynamic[1]);
  }

  @override
  Future<void> remove(dynamic) async {
    await SharedPref.remove(dynamic);
  }
}
