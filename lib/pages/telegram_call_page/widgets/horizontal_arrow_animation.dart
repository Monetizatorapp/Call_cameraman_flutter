import 'dart:async';

import 'package:flutter/material.dart';



class HorizontalArrowAnimation extends StatefulWidget {
  const HorizontalArrowAnimation({
    super.key,
    required this.axisDirection,
  });

  final AxisDirection axisDirection;

  @override
  State<HorizontalArrowAnimation> createState() =>
      _HorizontalArrowAnimationState();
}

class _HorizontalArrowAnimationState extends State<HorizontalArrowAnimation>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    // Create a list of controllers and animations for each element
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        vsync: this,
        duration:
            const Duration(milliseconds: 500),
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

      _controllers[i].forward();

      // Add a listener to reverse the animation when it completes
      _controllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllers[i].reverse();
        } else if (status == AnimationStatus.dismissed) {
          Future.delayed(const Duration(milliseconds: 50), () {
            _controllers[i].forward();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.axisDirection) {
      case AxisDirection.up:
        return const SizedBox.shrink();
      case AxisDirection.right:
        return Row(
          children: List.generate(3, (index) {
            return FadeTransition(
              opacity: _fadeAnimations[2 - index],
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            );
          }),
        );
      case AxisDirection.down:
        return const SizedBox.shrink();
      case AxisDirection.left:
        return Row(
          children: List.generate(3, (index) {
            return FadeTransition(
              opacity: _fadeAnimations[index],
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            );
          }),
        );
    }
  }
}
