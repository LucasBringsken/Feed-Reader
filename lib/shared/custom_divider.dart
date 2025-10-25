import 'package:flutter/material.dart';
import 'package:newsletter/theme.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.dividerColor, thickness: 1.5);
  }
}
