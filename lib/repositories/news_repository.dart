import 'package:flutter/foundation.dart';
import 'package:football_universe/data/data_source.dart';
import 'package:football_universe/data/local/news_local_impl.dart';
import 'package:football_universe/data/network/news_network_impl.dart';
import 'package:football_universe/models/news.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/helper_functions.dart';

class NewsRepository {
  Future<dynamic> get(DataSourceType dst, NewsListType newsListType) async {
    final DataSource ds =
        dst == DataSourceType.local ? NewsLocalImpl() : NewsNetworkImpl();
    final newsData = await ds.getData(newsListType);
    if(dst == DataSourceType.local)return List<News>.from( newsData);
    final List<News> newsList = await compute<dynamic, List<News>>(HelpersFunctions.sortNews,newsData);
    // throw Exception("error");
    return newsList.toSet().toList();
  }

  Future<void> add(News news) async {
    await NewsLocalImpl().add(news);
  }

  Future<void> remove(String id) async {
    await NewsLocalImpl().remove(id);
  }
}
