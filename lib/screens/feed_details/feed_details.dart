import 'package:flutter/material.dart';
import 'package:feedreader/models/entry.dart';
import 'package:feedreader/models/feed.dart';
import 'package:feedreader/screens/feed_details/entry_card.dart';
import 'package:feedreader/shared/custom_divider.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:feedreader/services/feed-service.dart' as feed_service;

class FeedDetailsScreen extends StatelessWidget {
  const FeedDetailsScreen({super.key, required this.feed});

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomTitle(feed.title)),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Entry>>(
              future: feed_service.loadFeedEntries(feed.link),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: CustomHeadline("Fehler beim Laden des Feeds"),
                  );
                } else {
                  final items = snapshot.data ?? [];
                  return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (_, index) => EntryCard(items[index]),
                    separatorBuilder: (_, __) => const CustomDivider(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
