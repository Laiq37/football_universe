abstract class DataSource{
  Future<dynamic> getData(dynamic);

  Future<void> add(dynamic dynamic);

  Future<void> remove(dynamic dynamic);
}