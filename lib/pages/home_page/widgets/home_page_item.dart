import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_icons.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class HomePageItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const HomePageItem({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 36, right: 24, top: 22, bottom: 22),
        decoration: BoxDecoration(
          color: AppColors.appPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.home20w600,
            ),
            SvgPicture.asset(AppIcons.arrow),
          ],
        ),
      ),
    );
  }
}