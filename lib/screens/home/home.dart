import 'package:flutter/material.dart';
import 'package:feedreader/screens/add/add.dart';
import 'package:feedreader/screens/home/feed_card.dart';
import 'package:feedreader/services/feed_store.dart';
import 'package:feedreader/shared/custom_divider.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitle("Feed-Übersicht")),
      body: Column(
        children: [
          Expanded(
            child: Consumer<FeedStore>(
              builder: (context, value, child) {
                if (value.feeds.length > 0) {
                  return ListView.separated(
                    itemCount: value.feeds.length,
                    itemBuilder: (_, index) => FeedCard(value.feeds[index]),
                    separatorBuilder: (_, __) => const CustomDivider(),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("Du hast noch keine Feeds abonniert."),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => const AddScreen()),
          ),
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
