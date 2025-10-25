import 'package:flutter/material.dart';
import 'package:newsletter/models/entry.dart';
import 'package:newsletter/models/newsletter.dart';
import 'package:newsletter/screens/newsletter_details/entry_card.dart';
import 'package:newsletter/shared/custom_divider.dart';
import 'package:newsletter/shared/custom_text.dart';
import 'package:newsletter/services/rss-service.dart' as rss_service;

class NewsletterDetailsScreen extends StatelessWidget {
  const NewsletterDetailsScreen({super.key, required this.newsletter});

  final Newsletter newsletter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomTitle(newsletter.title)),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Entry>>(
              future: rss_service.loadRssFeed(newsletter.link),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: CustomHeadline("Fehler beim Laden des RSS-Feeds"),
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
