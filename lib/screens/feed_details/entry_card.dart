import 'package:flutter/material.dart';
import 'package:feedreader/models/entry.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class EntryCard extends StatelessWidget {
  const EntryCard(this.entry, {super.key});

  final Entry entry;

  Future<void> _launchURL(String url) async {
    final Uri parsedUrl = Uri.parse(url);
    if (!await launchUrl(parsedUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $parsedUrl');
    }
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
                CustomHeadline(entry.title),
                const SizedBox(height: 5),
                if (entry.pubDate != null)
                  CustomText(entry.pubDate.toString(), small: true),
                const SizedBox(height: 5),
                CustomText(entry.description, limitText: true),
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
