import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsletter/models/newsletter.dart';
import 'package:newsletter/screens/home/home.dart';
import 'package:newsletter/services/newsletter_store.dart';
import 'package:newsletter/theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NewsletterAdapter());

  await Hive.openBox<Newsletter>('newsletters');

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('de_DE', null);
  runApp(
    ChangeNotifierProvider(
      create: (context) => NewsletterStore(),
      child: MaterialApp(home: const HomeScreen(), theme: primaryTheme),
    ),
  );
}
