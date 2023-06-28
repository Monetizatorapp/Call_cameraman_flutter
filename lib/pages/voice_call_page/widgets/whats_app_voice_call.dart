import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/widgets/call_avatar.dart';
import 'package:sirenhead_test/pages/widgets/call_timer.dart';
import 'package:sirenhead_test/pages/widgets/end_call_button.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';

class WhatsAppVoiceCall extends StatelessWidget {
  const WhatsAppVoiceCall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.incomingCallBackgroundBlack,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          Text(
            'Character'.tr(),
            style: AppTextStyles.incoming24w600,
          ),
          const SizedBox(
            height: 8,
          ),
          const CallTimer(
            callApp: CallApp.whatsApp,
          ),
          const Spacer(
            flex: 1,
          ),
          const CallAvatar(
            radius: 96,
          ),
          const Spacer(
            flex: 8,
          ),
          const EndCallButton(),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
