
import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.appPurple,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.home20w600.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
