import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';

class AcceptCallButton extends StatelessWidget {
  const AcceptCallButton({
    super.key,
    required this.onAccept,
  });

  final VoidCallback onAccept;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.appAcceptCall,
          radius: 36,
          child: IconButton(
            iconSize: 32,
            onPressed: onAccept,
            icon: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Accept',
          style: AppTextStyles.incoming14w600,
        )
      ],
    );
  }
}