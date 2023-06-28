import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/accept_pages/accept_page.dart';
import 'package:sirenhead_test/pages/accept_pages/more_option_page.dart';
import 'package:sirenhead_test/pages/chat_page/chat_page.dart';
import 'package:sirenhead_test/pages/messenger_call_page/messenger_incoming_call_page.dart';
import 'package:sirenhead_test/pages/home_page/home_page.dart';
import 'package:sirenhead_test/pages/select_type_call_page/select_type_call_page.dart';
import 'package:sirenhead_test/pages/splash_screen/splash_screen.dart';
import 'package:sirenhead_test/pages/telegram_call_page/telegram_incoming_call_page.dart';
import 'package:sirenhead_test/pages/video_call_page/video_call_page.dart';
import 'package:sirenhead_test/pages/voice_call_page/voice_call_page.dart';
import 'package:sirenhead_test/pages/whats_app_call_pages/whats_app_incoming_call_page.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;

    WidgetBuilder builder;

    switch (settings.name) {
      case AcceptPage.routeName:
        builder = (_) => const AcceptPage();
        break;
      case MoreOptionPage.routeName:
        builder = (_) => const MoreOptionPage();
        break;
      case SplashScreen.routeName:
        builder = (_) => const SplashScreen();
        break;
      case HomePage.routeName:
        builder = (_) => const HomePage();
        break;
      case WhatsAppIncomingCallPage.routeName:
        builder = (_) => WhatsAppIncomingCallPage(
              callType: arguments as CallType,
            );
        break;
      case VoiceCallPage.routeName:
        builder = (_) => VoiceCallPage(
              callApp: arguments as CallApp,
            );
        break;
      case VideoCallPage.routeName:
        builder = (_) => VideoCallPage(
              cameras: arguments as List<CameraDescription>?,
            );
        break;
      case MessengerIncomingCallPage.routeName:
        builder = (_) => MessengerIncomingCallPage(
              callType: arguments as CallType,
            );
        break;
      case TelegramIncomingCallPage.routeName:
        builder = (_) => TelegramIncomingCallPage(
          callType: arguments as CallType,
        );
        break;
      case SelectTypeCallPage.routeName:
        builder = (_) => SelectTypeCallPage(
          callType: arguments as CallType,
        );
        break;
      case ChatPage.routeName:
        builder = (_) => const ChatPage();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
