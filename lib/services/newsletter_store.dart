import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsletter/models/newsletter.dart';

class NewsletterStore extends ChangeNotifier {
  final Box<Newsletter> _box = Hive.box<Newsletter>('newsletters');

  get newsletters => _box.values.toList();

  void addNewsletter(Newsletter newsletter) {
    _box.add(newsletter);
    notifyListeners();
  }

  void removeNewsletter(Newsletter newsletter) {
    final index = _box.values.toList().indexOf(newsletter);
    if (index != -1) {
      _box.deleteAt(index);
      notifyListeners();
    }
  }

  bool containsNewsletter(String link) {
    return _box.values.any((item) => item.link == link);
  }
}
