import 'dart:async';
import 'package:clever_ads_solutions/CAS.dart';
import 'package:clever_ads_solutions/public/ConsentFlow.dart';
import 'package:clever_ads_solutions/public/ManagerBuilder.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/home_page/home_page.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_constants_string.dart';
import 'package:sirenhead_test/resources/app_images.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:clever_ads_solutions/public/AdTypes.dart';
import 'package:sirenhead_test/services/cas.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  bool _appOpenAdShown = false;

  Future<void> _showAppOpenAd() async {
    CASAd.manager?.showInterstitial(InterstitialListenerWrapper());
    _navigateToHomePage();
  }

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  void initialize() {
    CAS.setFlutterVersion(AppConstants.setFlutterVersion);
    CAS.setAnalyticsCollectionEnabled(true);
    CAS.setDebugMode(AppConstants.setDebugMode);
    CAS.setInterstitialInterval(30);
    ManagerBuilder builder = CAS
        .buildManager()
        .withTestMode(AppConstants.withTestMode)
        .withConsentFlow(ConsentFlow(isEnabled: false))
        .withCasId(AppConstants.withCasId)
        .withAdTypes(AdTypeFlags.Banner |
            AdTypeFlags.Rewarded |
            AdTypeFlags.Interstitial)
        .withInitializationListener(InitializationListenerWrapper());

    CASAd.manager = builder.initialize();
  }

  void _startSplashTimer() {
    Timer(const Duration(seconds: 4), () {
      if (!_appOpenAdShown) {
        _showAppOpenAd();
      }
    });
  }

  @override
  void initState() {
    initialize();
    _startSplashTimer();

    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: gradientBackground,
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(500)),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Transform.scale(
                scale: 1.3,
                child: const CircularProgressIndicator(
                  strokeWidth: 5,
                  color: AppColors.appPurple,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
