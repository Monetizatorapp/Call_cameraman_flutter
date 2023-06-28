import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class BottomItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;

  const BottomItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.appPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(500)),
            child: CircleAvatar(
              radius: 27,
              backgroundColor: AppColors.appPurple,
              child: SvgPicture.asset(icon),
            ),
          ),
        ),
        Text(
          title,
          style: AppTextStyles.home14w600,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
