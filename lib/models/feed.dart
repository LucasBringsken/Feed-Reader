import 'package:hive/hive.dart';

part 'feed.g.dart';

@HiveType(typeId: 0)
class Feed {
  Feed({
    required this.title,
    this.description,
    required this.link,
    required this.latestEntryId,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final String link;
  @HiveField(3)
  String latestEntryId;
  @HiveField(4)
  bool unreadUpdates = false;
}
