import 'package:feedreader/models/feed.dart';
import 'package:feedreader/services/feed_store.dart';
import 'package:feedreader/shared/custom_button.dart';
import 'package:feedreader/shared/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(this.feed, {super.key});

  final Feed feed;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.feed.title;
    _descriptionController.text = widget.feed.description ?? "";

    _nameController.addListener(() {
      final isEmpty = _nameController.text.trim().isEmpty;
      if (isEmpty != _isButtonDisabled) {
        setState(() {
          _isButtonDisabled = isEmpty;
        });
      }
    });
  }

  updateFeed() {
    String description = _descriptionController.text.trim();

    Provider.of<FeedStore>(context, listen: false).updateFeed(
      Feed(
        title: _nameController.text.trim(),
        link: widget.feed.link,
        description: description != "" ? description : null,
        latestEntryId: widget.feed.latestEntryId,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CustomTitle("Feed bearbeiten")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),

        child: Column(
          children: [
            const CustomHeadline(
              "Hier kannst du einen vorhandenen Feed bearbeiten.",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.title),
                label: CustomText("Titel"),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.description),
                label: CustomText("Beschreibung (optional)"),
              ),
              minLines: 1,
              maxLines: 6,
              maxLength: 200,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  "Speichern",
                  onPressed: () {
                    updateFeed();
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
