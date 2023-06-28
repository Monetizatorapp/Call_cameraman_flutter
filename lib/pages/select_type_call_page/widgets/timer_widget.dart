import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    required this.duration,
    required this.onTimerEnd,
  }) : super(key: key);

  final Duration duration;
  final VoidCallback onTimerEnd;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds == 0) {
          _timer.cancel();
          widget.onTimerEnd();
        } else {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        }
      });
    });
  }

  String get _formattedTime {
    int minutes = _remainingTime.inMinutes.remainder(60);
    int seconds = _remainingTime.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 50),
                      Text(
                        'Dont_close'.tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: -30,
            child: Image.asset(
              'assets/images/clock.png',
            ),
          ),
          Positioned(
            left: 50,
            top: 0,
            child: Container(
              height: 42,
              width: 107,
              decoration: BoxDecoration(
                color: AppColors.appPurple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  _formattedTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
