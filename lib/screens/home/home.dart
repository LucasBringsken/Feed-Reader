import 'package:flutter/material.dart';
import 'package:newsletter/screens/add/add.dart';
import 'package:newsletter/screens/home/newsletter_card.dart';
import 'package:newsletter/services/newsletter_store.dart';
import 'package:newsletter/shared/custom_divider.dart';
import 'package:newsletter/shared/custom_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitle("Newsletter-Übersicht")),
      body: Column(
        children: [
          Expanded(
            child: Consumer<NewsletterStore>(
              builder: (context, value, child) {
                if (value.newsletters.length > 0) {
                  return ListView.separated(
                    itemCount: value.newsletters.length,
                    itemBuilder: (_, index) =>
                        NewsletterCard(value.newsletters[index]),
                    separatorBuilder: (_, __) => const CustomDivider(),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("Du hast noch keine Newsletter abonniert."),
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
