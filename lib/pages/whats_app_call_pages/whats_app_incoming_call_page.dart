import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sirenhead_test/pages/whats_app_call_pages/widgets/arrow_animation.dart';
import 'package:sirenhead_test/pages/whats_app_call_pages/widgets/call_button.dart';
import 'package:sirenhead_test/pages/widgets/call_avatar.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_icons.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/services/cas.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';
import 'package:video_player/video_player.dart';

class WhatsAppIncomingCallPage extends StatefulWidget {
  const WhatsAppIncomingCallPage({
    Key? key,
    required this.callType,
  }) : super(key: key);
  static const routeName = 'whats-app-call-page';
  final CallType callType;

  @override
  State<WhatsAppIncomingCallPage> createState() =>
      _WhatsAppIncomingCallPageState();
}

class _WhatsAppIncomingCallPageState extends State<WhatsAppIncomingCallPage> {
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
      color: AppColors.incomingCallBackgroundBlack,
      child: Column(
        children: [
          const Spacer(
            flex: 2,
          ),
          const CallAvatar(
            radius: 77,
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
            tr('whatsapp_${widget.callType.name}_call'),
            style: AppTextStyles.incoming14w400,
          ),
          const Spacer(
            flex: 4,
          ),
          Expanded(
              flex: 5,
              child: ArrowAnimation(
                callType: widget.callType,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons.whatsAppMessage)),
              WhatsAppCallButton(
                callType: widget.callType,
              ),
              IconButton(
                iconSize: 32,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.call_end,
                  color: AppColors.whatsAppDecline,
                ),
              )
            ],
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
