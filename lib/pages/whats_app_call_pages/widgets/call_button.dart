
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/video_call_page/video_call_page.dart';
import 'package:sirenhead_test/pages/voice_call_page/voice_call_page.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';

class WhatsAppCallButton extends StatefulWidget {
  const WhatsAppCallButton({Key? key, required this.callType})
      : super(key: key);
  final CallType callType;

  @override
  State<WhatsAppCallButton> createState() => _WhatsAppCallButtonState();
}

class _WhatsAppCallButtonState extends State<WhatsAppCallButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _horizontalOffset = 0.0; // Added to track horizontal offset value
  double _verticalOffset = 0.0; // Added to track horizontal offset value

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the animation using a TweenSequence
    _animation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -20, end: -20)
            .chain(CurveTween(curve: Curves.easeOut)),
        // stay at the top position
        weight: 4,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -20, end: -100)
            .chain(CurveTween(curve: Curves.easeOut)), // jump up
        weight: 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -100, end: -100)
            .chain(CurveTween(curve: Curves.easeOut)),
        // stay at the top position
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -5, end: 0)
            .chain(CurveTween(curve: Curves.easeInOut)), // shake to the left
        weight: 0.3,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 5)
            .chain(CurveTween(curve: Curves.easeInOut)), // shake to the right
        weight: 0.3,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -100, end: -100)
            .chain(CurveTween(curve: Curves.easeIn)),
        // return to the top position
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -100, end: -20)
            .chain(CurveTween(curve: Curves.easeIn)), // return down
        weight: 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -20, end: -20)
            .chain(CurveTween(curve: Curves.easeOut)),
        // stay at the top position
        weight: 4,
      ),
    ]).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      })
      ..addListener(() {
        if (_animation.value >= -10) {
          _horizontalOffset = _animation.value;
        } else {
          _horizontalOffset = 0.0;
          if (_animation.value > -100) {
            _verticalOffset = _animation.value;
          }
        }
      });

    _controller.forward();
  }

  final double _minVerticalOffset = -150.0;
  final double _maxVerticalOffset = 0.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    _controller.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    // _controller.stop();
    setState(() {
      _verticalOffset += details.delta.dy;
      // Clamp the vertical offset within the desired range
      _verticalOffset =
          _verticalOffset.clamp(_minVerticalOffset, _maxVerticalOffset);
    });
  }

  void _onDragEnd(DragEndDetails details) async {
    _controller.forward();
    // Check if the vertical offset is less than or equal to -150 pixels to trigger action
    if (_verticalOffset <= _minVerticalOffset) {
      switch (widget.callType) {
        case CallType.voice:
          Navigator.of(context)
              .pushReplacementNamed(VoiceCallPage.routeName, arguments: CallApp.whatsApp);
          break;
        case CallType.video:
          await availableCameras().then((value) {
            return Navigator.of(context).pushReplacementNamed(
                VideoCallPage.routeName,
                arguments: value);
          });
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _horizontalOffset, // Use updated horizontal offset value
            _verticalOffset,
          ),
          child: GestureDetector(
            onVerticalDragStart: _onDragStart,
            onVerticalDragUpdate: _onDragUpdate,
            onVerticalDragEnd: _onDragEnd,
            child: CircleAvatar(
              radius: 36,
              backgroundColor: widget.callType == CallType.voice
                  ? AppColors.whatsAppGreen
                  : AppColors.whatsAppBlue,
              child: widget.callType == CallType.voice
                  ? const Icon(
                      Icons.call,
                      size: 32.0,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.videocam_rounded,
                      size: 48.0,
                      color: Colors.white,
                    ),
            ),
          ),
        );
      },
    );
  }
}
