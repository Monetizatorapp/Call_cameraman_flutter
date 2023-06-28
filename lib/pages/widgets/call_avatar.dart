import 'package:flutter/material.dart';

class CallAvatar extends StatelessWidget {
  const CallAvatar({
    super.key, required this.radius,
  });
final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage(
        'assets/images/siren_man.png',
      ),
    );
  }
}
