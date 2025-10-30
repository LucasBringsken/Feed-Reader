import 'package:feedreader/services/feed_store.dart';
import 'package:flutter/material.dart';
import 'package:feedreader/models/entry.dart';
import 'package:feedreader/models/feed.dart';
import 'package:feedreader/screens/feed_details/entry_card.dart';
import 'package:feedreader/shared/custom_divider.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:feedreader/services/feed_service.dart' as feed_service;
import 'package:provider/provider.dart';

class FeedDetailsScreen extends StatefulWidget {
  const FeedDetailsScreen({super.key, required this.feed});

  final Feed feed;

  @override
  State<FeedDetailsScreen> createState() => _FeedDetailsScreenState();
}

class _FeedDetailsScreenState extends State<FeedDetailsScreen> {
  Future<void> _reload() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomTitle(widget.feed.title)),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Entry>>(
                future: feed_service.loadFeedEntries(widget.feed.link),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: CustomHeadline("Fehler beim Laden des Feeds"),
                    );
                  } else {
                    final items = snapshot.data ?? [];

                    widget.feed.latestEntryId = items[0].id;
                    widget.feed.unreadUpdates = false;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Provider.of<FeedStore>(
                        context,
                        listen: false,
                      ).updateFeed(widget.feed);
                    });
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
      ),
    );
  }
}
