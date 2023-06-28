import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/video_call_page/video_call_page.dart';
import 'package:sirenhead_test/pages/voice_call_page/voice_call_page.dart';
import 'package:sirenhead_test/pages/widgets/accept_call_button.dart';
import 'package:sirenhead_test/pages/widgets/decline_call_button.dart';
import 'package:sirenhead_test/pages/widgets/telegram_background.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/services/cas.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';
import 'package:video_player/video_player.dart';

class TelegramIncomingCallPage extends StatefulWidget {
  const TelegramIncomingCallPage({
    Key? key,
    required this.callType,
  }) : super(key: key);
  static const routeName = 'telegram-incoming-call-page';
  final CallType callType;

  @override
  State<TelegramIncomingCallPage> createState() =>
      _TelegramIncomingCallPageState();
}

class _TelegramIncomingCallPageState extends State<TelegramIncomingCallPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    CASAd.view?.hideBanner();
    _controller = VideoPlayerController.asset('assets/audio/call.mp3');
    _controller.setLooping(true);
    _controller.initialize().then((value) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1F6094),
      child: TelegramBackground(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            const SizedBox(
              height: 28,
            ),
            Text(
              'Character'.tr(),
              style: AppTextStyles.incoming24w600,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.callType == CallType.voice
                  ? 'Tg_call'.tr()
                  : 'Tgv_call'.tr(),
              style: AppTextStyles.incoming14w400,
            ),
            const Spacer(
              flex: 9,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AcceptCallButton(onAccept: () async {
                  switch (widget.callType) {
                    case CallType.voice:
                      Navigator.of(context).pushReplacementNamed(
                          VoiceCallPage.routeName,
                          arguments: CallApp.telegram);
                      break;
                    case CallType.video:
                      await availableCameras().then((value) {
                        return Navigator.of(context).pushReplacementNamed(
                            VideoCallPage.routeName,
                            arguments: value);
                      });
                      break;
                  }
                }),
                // const HorizontalArrowAnimation(axisDirection: AxisDirection.left,),
                // const HorizontalArrowAnimation(axisDirection: AxisDirection.right,),
                DeclineCallButton(onDecline: () {
                  Navigator.pop(context);
                }),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
