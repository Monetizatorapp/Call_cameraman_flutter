import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sirenhead_test/pages/accept_pages/accept_page.dart';
import 'package:sirenhead_test/pages/splash_screen/splash_screen.dart';
import 'package:sirenhead_test/routes/app_router.dart';
import 'package:sirenhead_test/services/analitics_service.dart';
import 'package:sirenhead_test/services/toggle_review.dart';

class GlobalKeys {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}

Future<bool> isFirebaseInitialized() async {
  try {
    await Firebase.initializeApp();
    return true;
  } catch (e) {
    return false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  final analyticsService = FirebaseAnalyticsService();
  await analyticsService.initialize();
  await analyticsService.logAppOpen();
  bool isInitialized = await isFirebaseInitialized();
  if (isInitialized) {
    log('Firebase is initialized');
  } else {
    log('Firebase is not initialized');
  }
  final bool status = await LocalStorageService.ifAdAccepted;
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'MX'),
        Locale('id', 'ID'),
        Locale('pt', 'BR'),
        Locale('uk', 'UA'),
        Locale('ru', 'RU')
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: MyApp(status: status),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool status;

  const MyApp({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: GlobalKeys.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Skibidi Call',
      home: !status ? const AcceptPage() : const SplashScreen(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
