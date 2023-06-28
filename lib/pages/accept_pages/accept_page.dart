import 'package:clever_ads_solutions/CAS.dart';
import 'package:clever_ads_solutions/public/UserConsent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/accept_pages/more_option_page.dart';
import 'package:sirenhead_test/pages/accept_pages/widgets/rounded_button.dart';
import 'package:sirenhead_test/resources/app_constants_string.dart';
import 'package:sirenhead_test/resources/app_images.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../splash_screen/splash_screen.dart';

class AcceptPage extends StatefulWidget {
  const AcceptPage({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<AcceptPage> createState() => _AcceptPageState();
}

class _AcceptPageState extends State<AcceptPage> {
  final String longStart =
  'long_text'.tr();
  final String labelButton = 'accept'.tr();
  final String moreOption = 'more_option'.tr();
  final String privacyPolicy = 'privacy'.tr();
  final String welcome = 'Welcome'.tr();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: gradientBackground,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 263,
                  width: 263,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.asset(AppImages.sirenCircular),
                ),
                Text(
                  welcome,
                  style: AppTextStyles.home20w600.copyWith(fontSize: 24),
                ),
                Text(
                  longStart,
                  style: AppTextStyles.chat14w400White,
                  textAlign: TextAlign.center,
                ),
                RoundedButton(
                  label: labelButton,
                  onTap: () async {
                    await CAS.setUserConsentStatus(UserConsent.ACCEPTED);
                    await Navigator.of(context)
                        .pushReplacementNamed(SplashScreen.routeName);
                  },
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context)
                        .pushReplacementNamed(MoreOptionPage.routeName);
                  },
                  child: Text(
                    moreOption,
                    style: AppTextStyles.option,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url =
                    Uri.parse(AppConstants.privacyPolicy);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    privacyPolicy,
                    style: AppTextStyles.option,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
