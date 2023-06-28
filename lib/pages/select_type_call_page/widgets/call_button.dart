import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class CallButton extends StatelessWidget {
  const CallButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 232,
      decoration: BoxDecoration(
        color: AppColors.appPurple,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.appBackGroundWhite,
          width: 3,
        ),
      ),
      child: Center(
          child: Text(
        'Call'.tr(),
        style: AppTextStyles.home20w600,
      )),
    );
  }
}
