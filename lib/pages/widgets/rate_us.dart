import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_constants_string.dart';
import 'package:sirenhead_test/resources/app_icons.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/services/toggle_review.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _currentRating = 0;
  String rateButtonText = 'Rate';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  LocalStorageService.toggle();
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  AppIcons.closeButton,
                ),
              ),
            ),
            Text('Please'.tr(),
                textAlign: TextAlign.center, style: AppTextStyles.rateUs16w600),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentRating = index + 1;
                      if (_currentRating >= 4) {
                        rateButtonText = 'Rate2'.tr();
                      } else {
                        rateButtonText = 'Rate'.tr();
                      }
                    });
                  },
                  child: _currentRating > index
                      ? SvgPicture.asset(AppIcons.starFill,color: Colors.orange,)
                      : SvgPicture.asset(AppIcons.starClear),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.appPurple),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  if (_currentRating >= 4) {
                    final url = Uri.parse(AppConstants.linkToPlayMarket);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => const FeedbackAlert(),
                    );
                  }
                  LocalStorageService.setRating(_currentRating);
                },
                child: Text(
                  rateButtonText,
                  style: AppTextStyles.rateUs18w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedbackAlert extends StatelessWidget {
  const FeedbackAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    AppIcons.closeButton,
                  ),
                ),
              ),
              Text(
                'Spasibo'.tr(),
                style: AppTextStyles.rateUs24w800,
                textAlign: TextAlign.center,
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
