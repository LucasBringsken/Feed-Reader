import 'package:flutter/material.dart';
import 'package:newsletter/models/newsletter.dart';
import 'package:newsletter/services/newsletter_store.dart';
import 'package:newsletter/services/rss-service.dart' as rss_service;
import 'package:newsletter/shared/custom_button.dart';
import 'package:newsletter/shared/custom_text.dart';
import 'package:newsletter/theme.dart';
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

  void saveNewsletter() async {
    try {
      Newsletter newsletter = await rss_service.loadNewsletter(
        _urlController.text.trim(),
      );

      if (!mounted) return;

      if (Provider.of<NewsletterStore>(
        context,
        listen: false,
      ).containsNewsletter(_urlController.text.trim())) {
        showErrorSnackbar("⚠️ Diesen Newsletter hast du bereits abonniert.");
        return;
      }

      Provider.of<NewsletterStore>(context, listen: false).addNewsletter(
        Newsletter(
          title: newsletter.title,
          description: newsletter.description,
          link: _urlController.text.trim(),
        ),
      );
      Navigator.pop(context);
    } catch (_) {
      showErrorSnackbar(
        "⚠️ Du hast keine gültige RSS-Feed-URL eingegeben!\n\nBitte korrigiere deine Eingabe und versuche es erneut!",
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitle("Newsletter hinzufügen")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),

        child: Column(
          children: [
            const CustomHeadline(
              "Hier kannst du einen neuen Newsletter hinzufügen. Gib hierzu einfach die RSS-Feed-URL unten ein.",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.link),
                label: CustomText("Link zum Newsletter"),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  "Speichern",
                  onPressed: () {
                    saveNewsletter();
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
