import 'package:feedreader/theme.dart';
import 'package:flutter/material.dart';
import 'package:feedreader/models/feed.dart';
import 'package:feedreader/screens/feed_details/feed_details.dart';
import 'package:feedreader/shared/custom_text.dart';

class FeedCard extends StatelessWidget {
  const FeedCard(this.feed, {super.key});

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (ctx) => FeedDetailsScreen(feed: feed)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTitle(feed.title, small: true),
                  const SizedBox(height: 10),
                  CustomText(
                    feed.description ?? "Keine Beschreibung vorhanden",
                    italic: feed.description == null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
