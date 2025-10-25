import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    this.limitText = false,
    this.small = false,
  });

  final String text;
  final bool limitText;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: small
          ? Theme.of(context).textTheme.bodySmall
          : Theme.of(context).textTheme.bodyMedium,
      maxLines: limitText ? 7 : null,
      overflow: limitText ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}

class CustomHeadline extends StatelessWidget {
  const CustomHeadline(this.text, {super.key, this.textColor});

  final String text;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.headlineMedium;

    return Text(
      text,
      style: baseStyle?.copyWith(color: textColor ?? baseStyle.color),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle(this.text, {super.key, this.small = false});

  final String text;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: small
          ? Theme.of(context).textTheme.titleSmall
          : Theme.of(context).textTheme.titleMedium,
    );
  }
}
