import 'dart:async';

import 'package:football_universe/models/news.dart';
import 'package:football_universe/repositories/news_repository.dart';
import 'package:football_universe/res/constants.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final RxList<News> mainNews = <News>[].obs;
  final RxList<News> dailyNews = <News>[].obs;
  final RxList<News> favoriteNews = <News>[].obs;
  final RxList<String> favoriteNewsId = <String>[].obs;
  final NewsRepository newsRepository = NewsRepository();

  RxBool isLoading = false.obs;

  Future<void> get(DataSourceType dataSourceType, NewsListType newsListType,
      [bool refresh = false]) async {
    try {
      //not to fetch data again when revisit the screen
      if (!refresh) {
        switch (newsListType) {
          case NewsListType.daily:
            if (dailyNews.isNotEmpty) return;
            break;
          case NewsListType.main:
            if (mainNews.isNotEmpty) return;
            break;
          default:
        }
      }
      Future.delayed(Duration.zero, () => isLoading.value = true);

      final newsData = await newsRepository.get(dataSourceType, newsListType);
      if (newsListType == NewsListType.daily) {
        dailyNews.clear();
        dailyNews.addAll(newsData);
      } else if (newsListType == NewsListType.main) {
        mainNews.clear();
        mainNews.addAll(newsData);
      }
      isLoading.value = false;
    }on TimeoutException{
      isLoading.value = false;
      rethrow;
    } 
    
    catch (err) {
      isLoading.value = false;
      print(err);
    }finally{
      isLoading.value = false;
    }
  }

  void getFavorites(DataSourceType dst, NewsListType newsListType) async {
    if (favoriteNews.isNotEmpty) return;
    try{
      final List<News> newsData = await newsRepository.get(dst, newsListType);
      favoriteNews.addAll(newsData);
      favoriteNewsId.addAll([...favoriteNews.map((news) =>news.id).toList()]);
    }catch(err){
      print(err);
    }
  }

  bool isInFavorite(String id){
    return favoriteNewsId.contains(id);
  }

  void add(News news) async {
    try {
      favoriteNews.insert(0, news);
      favoriteNewsId.add(news.id);
      await NewsRepository().add(news);
    } catch (err) {
      favoriteNews.removeWhere((eachNews)=>eachNews.id == news.id);
      favoriteNewsId.remove(news.id);
      print(err);
    }
  }

  void remove(String id) async {
      final index =favoriteNews.indexWhere((news) => news.id == id);
      final removedNews = favoriteNews.removeAt(index);
      favoriteNewsId.remove(id);
    try {
      await NewsRepository().remove(id);
    } catch (err) {
      favoriteNews.insert(index, removedNews);
      favoriteNewsId.add(removedNews.id);
      print(err);
    }
  }
}
