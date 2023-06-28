
import 'package:clever_ads_solutions/public/AdPosition.dart';
import 'package:clever_ads_solutions/public/AdSize.dart';
import 'package:clever_ads_solutions/public/CASBannerView.dart';
import 'package:clever_ads_solutions/public/MediationManager.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/services/admob_service.dart';
import 'package:sirenhead_test/services/cas.dart';

class BottomAdsBanner extends StatefulWidget {
  const BottomAdsBanner({
    super.key,
  });

  @override
  State<BottomAdsBanner> createState() => _BottomAdsBannerState();
}

class _BottomAdsBannerState extends State<BottomAdsBanner> {
  @override
  void initState() {
    createAdaptiveBanner();
    super.initState();
  }

  MediationManager? manager;
  CASBannerView? view;

  Future<void> createAdaptiveBanner() async {
    view = manager?.getAdView(AdSize.Adaptive);
    view?.setAdListener(BannerListener());
    view?.setBannerPosition(AdPosition.TopCenter);
    view?.showBanner();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
    );
  }
}