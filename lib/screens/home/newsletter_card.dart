import 'package:flutter/material.dart';
import 'package:newsletter/models/newsletter.dart';
import 'package:newsletter/screens/newsletter_details/newsletter_details.dart';
import 'package:newsletter/services/newsletter_store.dart';
import 'package:newsletter/shared/custom_button.dart';
import 'package:newsletter/shared/custom_text.dart';
import 'package:provider/provider.dart';

class NewsletterCard extends StatelessWidget {
  const NewsletterCard(this.newsletter, {super.key});

  final Newsletter newsletter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => NewsletterDetailsScreen(newsletter: newsletter),
          ),
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
                  CustomTitle(newsletter.title, small: true),
                  const SizedBox(height: 10),
                  CustomText(newsletter.description),
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
                        "Möchtest du diesen Newsletter wirklich löschen?",
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
                            Provider.of<NewsletterStore>(
                              context,
                              listen: false,
                            ).removeNewsletter(newsletter);
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
