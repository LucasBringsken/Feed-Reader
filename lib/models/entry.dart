class Entry {
  Entry({
    required this.id,
    required this.title,
    required this.link,
    required this.description,
    this.author,
    this.category,
    this.pubDate,
    this.image,
  });

  final String id;
  final String title;
  final String link;
  final String description;
  final String? author;
  final String? category;
  final DateTime? pubDate;
  final String? image;
}
