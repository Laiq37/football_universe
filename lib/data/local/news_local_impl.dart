import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/services/db.dart';
import 'package:football_universe/res/constants.dart';

class NewsLocalImpl implements DataSource{
  @override
  Future getData(data) async{
    return await DB.get(ConstantStrings.news);
  }
  @override
  Future<void> add(news)async{
    return await DB.set(ConstantStrings.news, news);
  }
  @override
  Future<void> remove(id)async{
    return await DB.set(ConstantStrings.news, id);
  }
}