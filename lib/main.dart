import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:feedreader/models/feed.dart';
import 'package:feedreader/screens/home/home.dart';
import 'package:feedreader/services/feed_store.dart';
import 'package:feedreader/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FeedAdapter());

  await Hive.openBox<Feed>('feeds');

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de_DE', null);
  runApp(
    ChangeNotifierProvider(
      create: (context) => FeedStore(),
      child: MaterialApp(home: const HomeScreen(), theme: primaryTheme),
    ),
  );
}
