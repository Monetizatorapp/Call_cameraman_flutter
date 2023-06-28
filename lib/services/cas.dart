import 'dart:ui';

import 'package:clever_ads_solutions/CAS.dart';
import 'package:clever_ads_solutions/public/AdCallback.dart';
import 'package:clever_ads_solutions/public/AdImpression.dart';
import 'package:clever_ads_solutions/public/AdLoadCallback.dart';
import 'package:clever_ads_solutions/public/AdType.dart';
import 'package:clever_ads_solutions/public/AdViewListener.dart';
import 'package:clever_ads_solutions/public/CASBannerView.dart';
import 'package:clever_ads_solutions/public/InitializationListener.dart';
import 'package:clever_ads_solutions/public/MediationManager.dart';
import 'package:clever_ads_solutions/public/UserConsent.dart';

class CASAd {
  CASAd._();

  static MediationManager? manager;
  static CASBannerView? view;
  static bool whenClose = false;
  static bool timer = false;
}

class InitializationListenerWrapper extends InitializationListener {
  @override
  void onCASInitialized(bool success, String error) async {
    UserConsent status = await CAS.getUserConsentStatus();
  }
}

class InterstitialListenerWrapper extends AdCallback {
  final VoidCallback? callback;
  final VoidCallback? errorCallBack;

  InterstitialListenerWrapper({
    this.callback,
    this.errorCallBack,
  });

  @override
  void onClicked() {}

  @override
  void onClosed() {
    callback!();
  }

  @override
  void onComplete() {}

  @override
  void onImpression(AdImpression? adImpression) {}

  @override
  void onShowFailed(String? message) {
    errorCallBack!();
  }

  @override
  void onShown() {}
}

class BannerListener extends AdViewListener {
  @override
  void onAdViewPresented() {}

  @override
  void onClicked() {}

  @override
  void onFailed(String? message) {}

  @override
  void onImpression(AdImpression? adImpression) {}

  @override
  void onLoaded() {}
}

class LoadCallback extends AdLoadCallback {
  @override
  void onAdFailedToLoad(AdType adType, String? error) {}

  @override
  void onAdLoaded(AdType adType) {}
}
