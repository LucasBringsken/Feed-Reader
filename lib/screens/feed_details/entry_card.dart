import 'package:flutter/material.dart';
import 'package:feedreader/models/entry.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class EntryCard extends StatelessWidget {
  const EntryCard(this.entry, {super.key});

  final Entry entry;

  Future<void> _launchURL(String url) async {
    final Uri parsedUrl = Uri.parse(url);
    if (!await launchUrl(parsedUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $parsedUrl');
    }
  }

  String datetimeToString(DateTime date) {
    final localDate = date.toLocal();

    final formatter = DateFormat("d. MMMM yyyy, HH:mm 'Uhr'", 'de_DE');
    return formatter.format(localDate);
  }

  String removeHtmlTags(String htmlText) {
    final RegExp exp = RegExp(
      r'<[^>]*>',
      multiLine: true,
      caseSensitive: false,
    );
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (entry.image != null)
            Image.network(
              entry.image!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
            ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeadline(removeHtmlTags(entry.title)),
                const SizedBox(height: 5),
                if (entry.pubDate != null)
                  CustomText(datetimeToString(entry.pubDate!), small: true),
                const SizedBox(height: 5),
                CustomText(removeHtmlTags(entry.description), lineLimit: 7),
                const SizedBox(height: 5),
                if (entry.author != null)
                  CustomText(removeHtmlTags(entry.author!), small: true),
                const SizedBox(height: 10),
                GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [CustomHeadline("Mehr lesen ➜")],
                  ),
                  onTap: () => _launchURL(entry.link),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
