import 'package:feedreader/models/feed.dart';
import 'package:feedreader/screens/edit/edit.dart';
import 'package:feedreader/shared/custom_button.dart';
import 'package:feedreader/theme.dart';
import 'package:flutter/material.dart';
import 'package:feedreader/screens/add/add.dart';
import 'package:feedreader/screens/home/feed_card.dart';
import 'package:feedreader/services/feed_store.dart';
import 'package:feedreader/shared/custom_divider.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void deleteFeed(Feed feed) {
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
                Provider.of<FeedStore>(context, listen: false).removeFeed(feed);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
                    itemBuilder: (_, index) => Slidable(
                      key: ValueKey(value.feeds[index].title),

                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) =>
                                      EditScreen(value.feeds[index]),
                                ),
                              );
                            },
                            backgroundColor: AppColors.editColor,
                            icon: Icons.edit,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              deleteFeed(value.feeds[index]);
                            },
                            backgroundColor: AppColors.deleteColor,
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                      child: FeedCard(value.feeds[index]),
                    ),
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
