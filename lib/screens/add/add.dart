import 'package:flutter/material.dart';
import 'package:feedreader/models/feed.dart';
import 'package:feedreader/services/feed_store.dart';
import 'package:feedreader/services/feed-service.dart' as feed_service;
import 'package:feedreader/shared/custom_button.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:feedreader/theme.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _urlController = TextEditingController();

  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _urlController.addListener(() {
      final isEmpty = _urlController.text.trim().isEmpty;
      if (isEmpty != _isButtonDisabled) {
        setState(() {
          _isButtonDisabled = isEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void showErrorSnackbar(String message) {
    final snackBar = SnackBar(
      content: CustomHeadline(message, textColor: AppColors.secondaryAccent),
      action: SnackBarAction(label: "X", onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void saveFeed() async {
    try {
      Feed feed = await feed_service.loadFeed(_urlController.text.trim());

      if (!mounted) return;

      if (Provider.of<FeedStore>(
        context,
        listen: false,
      ).containsFeedLink(_urlController.text.trim())) {
        showErrorSnackbar("⚠️ Diesen Feed hast du bereits abonniert.");
        return;
      }

      Provider.of<FeedStore>(context, listen: false).addFeed(
        Feed(
          title: feed.title,
          description: feed.description,
          link: _urlController.text.trim(),
        ),
      );
      Navigator.pop(context);
    } catch (_) {
      showErrorSnackbar(
        "⚠️ Du hast keine gültige Feed-URL eingegeben!\n\nBitte korrigiere deine Eingabe und versuche es erneut!",
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitle("Feed hinzufügen")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),

        child: Column(
          children: [
            const CustomHeadline(
              "Hier kannst du einen neuen Feed hinzufügen. Gib hierzu einfach die Feed-URL unten ein.",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.link),
                label: CustomText("Link zum Feed"),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  "Speichern",
                  onPressed: () {
                    saveFeed();
                  },
                  disabled: _isButtonDisabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
