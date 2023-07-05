import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/services/db.dart';
import 'package:football_universe/res/constants.dart';

class MatchesLocalImpl implements DataSource{
  @override
  Future getData(data) async{
    return await DB.get(ConstantStrings.matches);
  }
  @override
  Future<void> add(match)async{
    return await DB.set(ConstantStrings.matches, match);
  }
  @override
  Future<void> remove(id)async{
    return await DB.set(ConstantStrings.matches, id);
  }
}