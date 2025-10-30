import 'package:feedreader/shared/custom_text.dart';
import 'package:feedreader/theme.dart';
import 'package:flutter/material.dart';

void showErrorSnackbar(String message, context) {
  final snackBar = SnackBar(
    content: CustomHeadline(
      "⚠️ $message",
      textColor: AppColors.secondaryAccent,
    ),
    action: SnackBarAction(label: "X", onPressed: () {}),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
