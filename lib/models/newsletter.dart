import 'package:hive/hive.dart';

part 'newsletter.g.dart';

@HiveType(typeId: 0)
class Newsletter {
  Newsletter({
    required this.title,
    required this.description,
    required this.link,
  });

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String link;
}
