import 'package:clever_ads_solutions/CAS.dart';
import 'package:clever_ads_solutions/public/MediationManager.dart';
import 'package:clever_ads_solutions/public/UserConsent.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/accept_pages/widgets/rounded_button.dart';
import 'package:sirenhead_test/pages/splash_screen/splash_screen.dart';
import 'package:sirenhead_test/resources/app_constants_string.dart';
import 'package:sirenhead_test/resources/app_images.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptionPage extends StatefulWidget {
  const MoreOptionPage({Key? key}) : super(key: key);
  static const routeName = 'more';

  @override
  State<MoreOptionPage> createState() => _MoreOptionPageState();
}

class _MoreOptionPageState extends State<MoreOptionPage> {
  final String readOur = 'read_our'.tr();
  final String privacyPolicy = 'privacy'.tr();
  final String accept = 'accept'.tr();
  final String doNot = 'do_not'.tr();

  @override
  void initState() {
    super.initState();
  }

  MediationManager? manager;

  @override
  void dispose() {
    super.dispose();
  }

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
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(AppConstants.privacyPolicy);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text.rich(
                    TextSpan(
                      text: '$readOur\n',
                      style: AppTextStyles.home20w600.copyWith(fontSize: 24),
                      children: <TextSpan>[
                        TextSpan(
                          text: privacyPolicy,
                          style: AppTextStyles.home20w600.copyWith(
                            fontSize: 24,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        // can add more TextSpans here...
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                RoundedButton(
                  label: accept,
                  onTap: () async {
                    await CAS.setUserConsentStatus(UserConsent.ACCEPTED);
                    await Navigator.of(context)
                        .pushReplacementNamed(SplashScreen.routeName);
                  },
                ),
                RoundedButton(
                  label: doNot,
                  onTap: () async {
                    await CAS.setUserConsentStatus(UserConsent.DENIED);
                    await Navigator.of(context)
                        .pushReplacementNamed(SplashScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}