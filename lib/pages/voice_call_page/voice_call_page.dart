import 'package:flutter/material.dart';
import 'package:sirenhead_test/main.dart';
import 'package:sirenhead_test/pages/home_page/home_page.dart';
import 'package:sirenhead_test/pages/voice_call_page/widgets/telegram_voice_call.dart';
import 'package:sirenhead_test/pages/voice_call_page/widgets/whats_app_voice_call.dart';
import 'package:sirenhead_test/pages/widgets/rate_us.dart';
import 'package:sirenhead_test/services/cas.dart';
import 'package:sirenhead_test/services/toggle_review.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';
import 'package:video_player/video_player.dart';

import 'widgets/messenger_voice_call.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({Key? key, required this.callApp}) : super(key: key);
  static const routeName = 'voice-call-page';
  final CallApp callApp;

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  late VideoPlayerController _controller;
  bool _ratingCalled = false;

  void _checkIfFinish() {
    if (_controller.value.duration == _controller.value.position &&
        !_controller.value.isPlaying &&
        !_ratingCalled) {
      _ratingCalled = true;
      _callRating();
      Navigator.pushNamedAndRemoveUntil(
          context, HomePage.routeName, (route) => false);
    }
  }

  Future<void> _callRating() async {
    final ifReviewed = await LocalStorageService.ifReviewed;
    if (!ifReviewed) {
      await Future.delayed(const Duration(milliseconds: 700));
      showDialog(
          context: GlobalKeys.navigatorKey.currentState!.context,
          builder: (_) {
            return const RatingDialog();
          });
    }
  }

  @override
  void initState() {
    super.initState();
    CASAd.view?.hideBanner();
    _controller = VideoPlayerController.asset('assets/audio/audio.mp3');
    _controller.initialize().then((value) {
      setState(() {});
      _controller.play();
    });
    _controller.addListener(_checkIfFinish);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.callApp) {
      case CallApp.telegram:
        return const TelegramVoiceCall();
      case CallApp.whatsApp:
        return const WhatsAppVoiceCall();
      case CallApp.messenger:
        return const MessengerVoiceCall();
    }
  }
}
