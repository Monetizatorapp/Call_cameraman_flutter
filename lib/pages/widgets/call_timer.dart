import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';

class CallTimer extends StatefulWidget {
  const CallTimer({Key? key, required this.callApp}) : super(key: key);
  final CallApp callApp;

  @override
  State<CallTimer> createState() => _CallTimerState();
}

class _CallTimerState extends State<CallTimer> {
  late final Timer _timerPeriodic;

  @override
  void initState() {
    super.initState();
    _timerPeriodic = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _changeTimer(Duration(seconds: timer.tick));
      },
    );
  }

  void _changeTimer(Duration duration) {
    setState(() {
      _timer =
          '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    });
  }

  String _timer = '00:00';

  @override
  void dispose() {
    _timerPeriodic.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.callApp) {
      case CallApp.telegram:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_cellular_alt_outlined, color: AppColors.callScreenWhite),
            Text(
              _timer,
              style: AppTextStyles.incoming16w400.copyWith(color: AppColors.callScreenWhite),
            ),
          ],
        );
      case CallApp.whatsApp:
        return Text(
          _timer,
          style: AppTextStyles.incoming16w400,
        );
      case CallApp.messenger:
        return Text(
          _timer,
          style: AppTextStyles.incoming16w400,
        );
    }
  }
}
