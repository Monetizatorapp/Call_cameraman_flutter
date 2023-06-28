import 'package:flutter/material.dart';

class TelegramBackground extends StatelessWidget {
  const TelegramBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(17, 40, 55, 0.2),
              Color.fromRGBO(17, 50, 75, 0.1),
              Color.fromRGBO(14, 39, 55, 0)
            ],
            stops: [0, 0.4844, 1],
          ),
        ),
        child: child);
  }
}