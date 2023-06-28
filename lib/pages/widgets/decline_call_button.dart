import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class DeclineCallButton extends StatelessWidget {
  const DeclineCallButton({
    super.key,
    required this.onDecline,
  });

  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.declineRed,
          radius: 36,
          child: IconButton(
            iconSize: 32,
            onPressed: onDecline,
            icon: const Icon(
              Icons.call_end,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Decline',
          style: AppTextStyles.incoming14w600,
        )
      ],
    );
  }
}
