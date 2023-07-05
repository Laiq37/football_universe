import 'package:flutter/foundation.dart';
import 'package:football_universe/controllers/app_controller.dart';
import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/services/network.dart';
import 'package:get/get.dart';

class NewsNetworkImpl implements DataSource {
  @override
  Future getData(newsListType)async {
    final String newsType = newsListType == NewsListType.daily ? "news" : "mainnews";
    List dataList = [];
    final AppController appController = Get.find<AppController>();
    for (var filter in appController.activeFilters) {
      if(filter == 'All')continue;
    var data = await compute(NetWork.fetchData,"${ConstantStrings.newsBaseUrl}/$newsType.json?category_id=${ConstantStrings.categoriesAndId[filter]["id"]}&from=0&api_version=2");
    dataList.addAll(data[newsType]);
  }
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
