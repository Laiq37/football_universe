import 'package:flutter/material.dart';
import 'package:football_universe/res/constants.dart';
import 'package:football_universe/res/helper_functions.dart';
import 'package:football_universe/res/theme_manager.dart';
import 'package:football_universe/screens/calenders.dart';
import 'package:football_universe/screens/favorites.dart';
import 'package:football_universe/screens/matches.dart';
import 'package:football_universe/screens/news.dart';
import 'package:football_universe/models/news.dart' as news_model;
import 'package:football_universe/screens/news_detail.dart';
import 'package:football_universe/services/db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  DB.init();
  runApp(const MyApp());
}

final GoRoute newsDetailRoute = GoRoute(
  name: ConstantStrings.newsDetail,
  path: "/news_detail",
  builder: (context, state) {
    final data = state.extra as Map<String, news_model.News>;
    return NewsDetail(news: data["news"]!);
  },
);

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        name: ConstantStrings.news,
        path: "/",
        builder: (context, state) => const News(
              newsTitle: ConstantStrings.mainNews,
            ),
            redirect: newsDetailRoute.redirect,
       ),
    GoRoute(
      name: ConstantStrings.dailyNews,
      path: "/daily_news/:news_title",
      builder: (context, state) => News(
        newsTitle: state.params["news_title"]!,
      ),
      redirect: newsDetailRoute.redirect,
    ),
    newsDetailRoute,
    GoRoute(
        name: ConstantStrings.matches,
        path: "/matches",
        builder: (context, state) => const Matches(),
        routes: [
          GoRoute(
            name: ConstantStrings.calender,
            path: "calender",
            builder: (context, state) => const Calender(),
          ),
        ],),
    GoRoute(
      name: ConstantStrings.favorites,
      path: "/favorites",
      builder: (context, state) => const Favorites(),
      redirect: newsDetailRoute.redirect,
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HelpersFunctions.initControllers();
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.deleteAll();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Football Universe',
      theme: getAppTheme(),
      routerConfig: _router,
    );
  }
}
