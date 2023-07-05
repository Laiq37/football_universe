import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'news.g.dart';

@HiveType(typeId: 1)
class News extends 

Equatable{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final DateTime postTime;
    // bool favorite;

  const News({
    required this.id,
    required this.content,
    required this.title,
    required this.image,
    required this.postTime,
    // this.favorite = false,
  });

  factory News.fromJson(Map<String, dynamic> newsData) {
    return News(
        id: newsData["id"].toString(),
        title: newsData["title"] ?? "",
        content: newsData["content"] ?? "",
        image: newsData["social_image"] ?? newsData["image_social"] ?? "",
        postTime: DateTime.fromMillisecondsSinceEpoch(newsData["posted_time"]* 1000),
        );
  }

  @override
  List<Object> get props => [id, content, title,image, postTime];

  @override
  bool get stringify => false;
}
