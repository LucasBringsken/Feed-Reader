import 'package:flutter/material.dart';
import 'package:newsletter/shared/custom_text.dart';
import 'package:newsletter/theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
    this.text, {
    super.key,
    required this.onPressed,
    this.disabled = false,
  });

  final String text;
  final Function() onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: disabled ? null : onPressed,
      child: CustomHeadline(
        text,
        textColor: disabled ? null : AppColors.secondaryAccent,
      ),
    );
  }
}
