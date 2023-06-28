import 'package:flutter/material.dart';
import 'package:sirenhead_test/main.dart';
import 'package:sirenhead_test/pages/widgets/rate_us.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/services/toggle_review.dart';

class EndCallButton extends StatelessWidget {
  const EndCallButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.pop(context);
        final ifReviewed = await LocalStorageService.ifReviewed;
        if(!ifReviewed) {
          Future.delayed(const Duration(seconds: 1), () {
            showDialog(
                context: GlobalKeys.navigatorKey.currentState!.context,
                builder: (_) {
                  return const RatingDialog();
                });
          });
        }
      },
      child: const CircleAvatar(
        radius: 36,
        backgroundColor: AppColors.declineRed,
        child: Icon(
          Icons.call_end,
          size: 32.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
