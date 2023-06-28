import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/widgets/telegram_background.dart';
import 'package:sirenhead_test/pages/widgets/call_timer.dart';
import 'package:sirenhead_test/pages/widgets/end_call_button.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';

class TelegramVoiceCall extends StatelessWidget {
  const TelegramVoiceCall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1F6094),
      child: TelegramBackground(
        child: Column(
          children:  [
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
            const CallTimer(callApp: CallApp.telegram,),
            const Spacer(
              flex: 9,
            ),
            const EndCallButton(),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}


