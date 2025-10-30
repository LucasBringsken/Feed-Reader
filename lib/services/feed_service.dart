import 'package:http/http.dart' as http;
import 'package:feedreader/models/entry.dart';
import 'package:feedreader/models/feed.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

DateTime formatFeedDate(String rawDate) {
  DateTime date;
  try {
    date = DateTime.parse(rawDate);
  } catch (_) {
    date = DateFormat("EEE, dd MMM yyyy HH:mm:ss Z", 'en_US').parseUtc(rawDate);
  }

  return date;
}

Future<String> fetchFeedBody(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;
    final utf8String = utf8.decode(bytes, allowMalformed: true);
    return utf8String;
  } else {
    throw Exception(response.statusCode);
  }
}

Feed parseFeed(String xmlString) {
  final document = XmlDocument.parse(xmlString);
  final rssChannel = document.findAllElements('channel');

  final feedInfo = rssChannel.isNotEmpty
      ? rssChannel.first
      : document.findAllElements('feed').first;

  final title = feedInfo.getElement('title')?.innerText;
  if (title == null) {
    throw Exception();
  }

  final link = feedInfo.getElement('link')?.innerText ?? '';
  final description =
      feedInfo.getElement('description')?.innerText ??
      feedInfo.getElement('subtitle')?.innerText;

  List<Entry> feedEntries = parseEntryContent(xmlString);

  return Feed(
    title: title,
    description: description,
    link: link,
    latestEntryId: feedEntries[0].id,
  );
}

List<Entry> parseEntryContent(String xmlString) {
  final document = XmlDocument.parse(xmlString);
  final items = document.findAllElements('item');

  final entries = items.isNotEmpty ? items : document.findAllElements('entry');
  return entries.map((element) {
    final id =
        element.getElement('id')?.innerText ??
        element.getElement('guid')?.innerText ??
        '';

    final title = element.getElement('title')?.innerText ?? 'Kein Titel';

    final linkElement = element.findElements('link').firstOrNull;
    final link =
        linkElement?.getAttribute('href') ?? linkElement?.innerText ?? '';

    final description =
        element.getElement('description')?.innerText ??
        element.getElement('summary')?.innerText ??
        '';
    final author =
        element.getElement('author')?.getElement('name')?.innerText ??
        element.getElement('author')?.innerText ??
        element.getElement('dc:creator')?.innerText;
    final category =
        element.getElement('category')?.innerText ??
        element.getElement('category')?.getAttribute('label') ??
        element.getElement('category')?.getAttribute('term') ??
        '';
    final pubDateText =
        element.getElement('pubDate')?.innerText ??
        element.getElement('published')?.innerText;
    final image =
        element.getElement('image')?.getAttribute('url') ??
        element.getElement('media:content')?.getAttribute('url') ??
        element.getElement('enclosure')?.getAttribute('url') ??
        element.getElement('logo')?.innerText;

    DateTime? pubDate;
    if (pubDateText != null) {
      pubDate = formatFeedDate(pubDateText);
    }

    return Entry(
      id: id,
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

Future<List<Entry>> loadFeedEntries(String url) async {
  final xmlString = await fetchFeedBody(url);
  final items = parseEntryContent(xmlString);
  return items;
}

Future<Feed> loadFeed(String url) async {
  final xmlString = await fetchFeedBody(url);
  final feed = parseFeed(xmlString);
  return feed;
}
