import 'package:clever_ads_solutions/public/AdPosition.dart';
import 'package:clever_ads_solutions/public/AdSize.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/chat_page/widgets/chat.dart';
import 'package:sirenhead_test/pages/chat_page/widgets/chat_app_bar.dart';
import 'package:sirenhead_test/pages/widgets/ads/bottom_ads_banner.dart';
import 'package:sirenhead_test/services/cas.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static const routeName = 'chat-page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    createStandartBanner();
    changeBannerBottom();
    super.initState();
  }

  void changeBannerBottom() {
    CASAd.view?.setBannerAdRefreshRate(30);
    CASAd.view?.setBannerPosition(AdPosition.BottomCenter);
  }

  Future<void> createStandartBanner() async {
    CASAd.view?.setBannerAdRefreshRate(30);
    CASAd.view = CASAd.manager?.getAdView(AdSize.Banner);
    CASAd.view?.setAdListener(BannerListener());
    CASAd.view?.showBanner();

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffeaeaea),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(68),
        child: ChatAppBar(),
      ),
      body: Chat(),
      bottomNavigationBar: BottomAdsBanner(),
    );
  }
}
