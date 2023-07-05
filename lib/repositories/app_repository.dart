import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/data/local/app_local_impl.dart';

class AppRepository{
  final DataSource ds = AppLocalImpl();
  Future<String?> get(key)async{
    return await ds.getData(key);
  }

  Future<void> add(key,value)async{
    await ds.add([key,value]);
  }

  Future<void> remove(key)async{
    await ds.remove(key);
  }
}