import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sirenhead_test/pages/home_page/home_page.dart';
import 'package:sirenhead_test/pages/select_type_call_page/select_type_call_page.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_icons.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed(HomePage.routeName);
        },
        icon: SvgPicture.asset(AppIcons.back),
      ),
      title: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/siren_man.png'),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Character'.tr(),
                style: AppTextStyles.chat16w700,
              ),
              Row(
                children: [
                  Text(
                    'Online'.tr(),
                    style: AppTextStyles.incoming14w400.copyWith(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.appAcceptCall.withOpacity(0.9)),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          iconSize: 54,
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pushNamed(SelectTypeCallPage.routeName,
                arguments: CallType.voice);
          },
          icon: const CircleAvatar(
            backgroundColor: AppColors.appPurple,
            child: Icon(
              Icons.call_end,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          iconSize: 54,
          padding: EdgeInsets.zero,
          onPressed: () async {
            await availableCameras().then((value) {
              if (value.isNotEmpty) {
                return Navigator.of(context).pushNamed(
                    SelectTypeCallPage.routeName,
                    arguments: CallType.video);
              }
            });
          },
          icon: const CircleAvatar(
            backgroundColor: AppColors.appPurple,
            child: Icon(
              Icons.videocam_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
