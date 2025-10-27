import 'package:feedreader/models/feed.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(this.feed, {super.key});

  final Feed feed;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitle("Feed bearbeiten")),
    );
  }
}
