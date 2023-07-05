import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
part 'sport_match.g.dart';

@HiveType(typeId: 2)
class SportMatch extends Equatable{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String home;
  @HiveField(2)
  final String away;
  @HiveField(3)
  final DateTime date;
  const SportMatch({required this.id, required this.home, required this.away, required this.date});
  factory SportMatch.fromJson(match){
    return SportMatch(id: match["game_id"], home: match["home"]["name"], away: match["away"]["name"], date:DateTime.fromMillisecondsSinceEpoch(int.parse(match["time"]??"0")* 1000));
  }
  
  @override
  List<Object> get props => [id, home, away,date,];

  @override
  bool get stringify => false;

}