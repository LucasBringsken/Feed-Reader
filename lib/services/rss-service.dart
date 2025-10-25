import 'package:http/http.dart' as http;
import 'package:newsletter/models/entry.dart';
import 'package:newsletter/models/newsletter.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

String formatRssDate(String rawDate) {
  DateTime date;
  try {
    date = DateTime.parse(rawDate);
  } catch (_) {
    date = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z", 'en_US').parseUtc(rawDate);
  }

  final localDate = date.toLocal();

  final formatter = DateFormat("d. MMMM yyyy, HH:mm 'Uhr'", 'de_DE');
  return formatter.format(localDate);
}

Future<String> fetchRssFeed(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception(response.statusCode);
  }
}

Newsletter parseNewsletterRss(String xmlString) {
  final document = XmlDocument.parse(xmlString);
  final newsletterInfo = document.findAllElements('channel').first;

  final title = newsletterInfo.getElement('title')?.innerText;

  if (title == null) {
    throw Exception();
  }

  final link = newsletterInfo.getElement('link')?.innerText ?? '';
  final description = newsletterInfo.getElement('description')?.innerText ?? '';

  return Newsletter(title: title, description: description, link: link);
}

List<Entry> parseEntryRss(String xmlString) {
  final document = XmlDocument.parse(xmlString);
  final items = document.findAllElements('item');

  return items.map((element) {
    final title = element.getElement('title')?.innerText ?? 'Kein Titel';
    final link = element.getElement('link')?.innerText ?? '';
    final description = element.getElement('description')?.innerText ?? '';
    final author = element.getElement('link')?.innerText ?? '';
    final category = element.getElement('category')?.innerText ?? '';
    final pubDateText = element.getElement('pubDate')?.innerText;
    final image = element.getElement('enclosure')?.getAttribute('url');

    String pubDate = "";
    if (pubDateText != null) {
      pubDate = formatRssDate(pubDateText);
    }

    return Entry(
      title: title,
      link: link,
      description: description,
      author: author,
      category: category,
      pubDate: pubDate,
      image: image,
    );
  }).toList();
}

Future<List<Entry>> loadRssFeed(String url) async {
  final xmlString = await fetchRssFeed(url);
  final items = parseEntryRss(xmlString);
  return items;
}

Future<Newsletter> loadNewsletter(String url) async {
  final xmlString = await fetchRssFeed(url);
  final newsletter = parseNewsletterRss(xmlString);
  return newsletter;
}
