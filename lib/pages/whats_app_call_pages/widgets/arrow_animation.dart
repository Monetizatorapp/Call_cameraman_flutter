import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';

class ArrowAnimation extends StatefulWidget {
  const ArrowAnimation({super.key, required this.callType});
  final CallType callType;
  @override
  State<ArrowAnimation> createState() => _ArrowAnimationState();
}

class _ArrowAnimationState extends State<ArrowAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    // Create a list of controllers and animations for each element
    _controllers = List.generate(
      4,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500), // Updated duration to 250 ms
      ),
    );
    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Start the staggered animations
    _startStaggeredAnimations();
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _startStaggeredAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      // Wait for 125 milliseconds before starting the next animation
      await Future.delayed(const Duration(milliseconds: 100));
      // Forward the animation for the current element
      _controllers[i].forward();
      // Add a listener to reverse the animation when it completes
      _controllers[i].addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          _controllers[i].reverse();
        } if (status == AnimationStatus.dismissed) {
          // Add a delay before starting the reverse animation
          await  Future.delayed(const Duration(milliseconds: 25),);
          _controllers[i].forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(4, (index) {
          return FadeTransition(
            opacity: _fadeAnimations[3-index],
            child: Icon(
              Icons.keyboard_arrow_up_sharp,
              color: widget.callType == CallType.voice? AppColors.whatsAppGreen :  AppColors.whatsAppBlue,
            ),
          );
        })
    );
  }
}
