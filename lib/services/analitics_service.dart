import 'package:firebase_analytics/firebase_analytics.dart';
class FirebaseAnalyticsService {
  FirebaseAnalytics? _analytics;

  Future<void> initialize() async {
    _analytics = FirebaseAnalytics.instance;
  }

  Future<void> logAppOpen() async {
    await _analytics?.logAppOpen();
  }

  Future<void> logCallButtonPressed() async {
    await _analytics?.logEvent(name: 'call_button_pressed');
  }
}
