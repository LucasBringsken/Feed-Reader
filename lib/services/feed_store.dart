import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:feedreader/models/feed.dart';

class FeedStore extends ChangeNotifier {
  final Box<Feed> _box = Hive.box<Feed>('feeds');

  get feeds => _box.values.toList();

  void addFeed(Feed feed) {
    _box.add(feed);
    notifyListeners();
  }

  void removeFeed(Feed feed) {
    final index = _box.values.toList().indexOf(feed);
    if (index != -1) {
      _box.deleteAt(index);
      notifyListeners();
    }
  }

  bool containsFeedLink(String link) {
    return _box.values.any((item) => item.link == link);
  }
}
