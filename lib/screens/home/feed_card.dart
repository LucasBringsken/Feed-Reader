import 'package:flutter/material.dart';
import 'package:feedreader/models/feed.dart';
import 'package:feedreader/screens/feed_details/feed_details.dart';
import 'package:feedreader/services/feed_store.dart';
import 'package:feedreader/shared/custom_button.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:provider/provider.dart';

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
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const CustomHeadline("Wirklich löschen?"),
                      content: const CustomText(
                        "Möchtest du diesen Feed wirklich löschen?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const CustomHeadline("Abbrechen"),
                        ),
                        CustomButton(
                          "Bestätigen",
                          onPressed: () {
                            Provider.of<FeedStore>(
                              context,
                              listen: false,
                            ).removeFeed(feed);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
