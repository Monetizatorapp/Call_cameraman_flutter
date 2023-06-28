import 'package:clever_ads_solutions/public/AdPosition.dart';
import 'package:clever_ads_solutions/public/AdSize.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sirenhead_test/pages/messenger_call_page/messenger_incoming_call_page.dart';
import 'package:sirenhead_test/pages/select_type_call_page/widgets/call_button.dart';
import 'package:sirenhead_test/pages/select_type_call_page/widgets/select_type_social.dart';
import 'package:sirenhead_test/pages/select_type_call_page/widgets/time_option.dart';
import 'package:sirenhead_test/pages/select_type_call_page/widgets/timer_widget.dart';
import 'package:sirenhead_test/pages/telegram_call_page/telegram_incoming_call_page.dart';
import 'package:sirenhead_test/pages/whats_app_call_pages/whats_app_incoming_call_page.dart';
import 'package:sirenhead_test/pages/widgets/ads/bottom_ads_banner.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_icons.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/services/analitics_service.dart';
import 'package:sirenhead_test/services/cas.dart';
import 'package:sirenhead_test/utils/enums/call_app.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';


class SelectTypeCallPage extends StatefulWidget {
  const SelectTypeCallPage({
    Key? key,
    required this.callType,
  }) : super(key: key);
  final CallType callType;
  static const routeName = 'select-type-call-page';

  @override
  State<SelectTypeCallPage> createState() => _SelectTypeCallPageState();
}

class _SelectTypeCallPageState extends State<SelectTypeCallPage> {
  final analyticsService = FirebaseAnalyticsService();
  CallApp _callApp = CallApp.whatsApp;
  String time = '0';
  bool isActive = false;

  @override
  void initState() {
    CASAd.manager?.showInterstitial(InterstitialListenerWrapper());
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


  Future<void> _permissionAsk() async {
    if (widget.callType == CallType.video) {
      final status = await Permission.camera.request();
      if (status.isDenied && mounted) {
        Navigator.pop(context);
      } else {
        await CASAd.manager?.showInterstitial(
          InterstitialListenerWrapper(
              callback: () {
                if (time == '0') {
                  _navigateToCall();
                } else {
                  setState(() {
                    isActive = true;
                  });
                }
              },
              errorCallBack: () {
                if (time == '0') {
                  _navigateToCall();
                } else {
                  setState(() {
                    isActive = true;
                  });
                }
              }),
        );
      }
    } else {
      await CASAd.manager
          ?.showInterstitial(InterstitialListenerWrapper(callback: () {
        if (time == '0') {
          _navigateToCall();
        } else {
          setState(() {
            isActive = true;
          });
        }
      }, errorCallBack: (){
        if (time == '0') {
          _navigateToCall();
        } else {
          setState(() {
            isActive = true;
          });
        }
      }));
    }
  }

  void _navigateToCall() {
    final String route = _selectType(callApp: _callApp);
    switch (widget.callType) {
      case CallType.voice:
        Navigator.of(context).pushReplacementNamed(
          route,
          arguments: widget.callType,
        );
        break;
      case CallType.video:
        Navigator.of(context).pushReplacementNamed(
          route,
          arguments: widget.callType,
        );

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Container(
        decoration: gradientBackground,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: const BottomAdsBanner(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 44),
                    decoration: BoxDecoration(
                      color: AppColors.appBackGroundWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectTypeSocial(
                          title: 'WhatsApp',
                          icon: AppIcons.whatsapp,
                          onTap: (type) {
                            setState(() {
                              _callApp = type;
                            });
                          },
                          selectedType: _callApp,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SelectTypeSocial(
                          title: 'Facebook',
                          icon: AppIcons.facebook,
                          onTap: (type) {
                            setState(() {
                              _callApp = type;
                            });
                          },
                          selectedType: _callApp,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SelectTypeSocial(
                          title: 'Telegram',
                          icon: AppIcons.telegram,
                          onTap: (type) {
                            setState(() {
                              _callApp = type;
                            });
                          },
                          selectedType: _callApp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36, horizontal: 44),
                    decoration: BoxDecoration(
                      color: AppColors.appBackGroundWhite,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delay'.tr(),
                          style: AppTextStyles.black14w600,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TimeOption(
                          value: '0',
                          label: '0s',
                          groupValue: time,
                          onChanged: (value) {
                            setState(() {
                              time = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TimeOption(
                          value: '10',
                          label: '10s',
                          groupValue: time,
                          onChanged: (value) {
                            setState(() {
                              time = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TimeOption(
                          value: '20',
                          label: '20s',
                          groupValue: time,
                          onChanged: (value) {
                            setState(() {
                              time = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height / 30),
                  isActive
                      ? TimerWidget(
                          duration: Duration(seconds: int.parse(time)),
                          onTimerEnd: () {
                            _navigateToCall();
                          },
                        )
                      : InkWell(
                          borderRadius: BorderRadius.circular(10),
                          highlightColor: Colors.white.withOpacity(0.5),
                          onLongPress: () async {
                            _permissionAsk();
                            await analyticsService.logCallButtonPressed();
                          },
                          onTap: () async {
                            _permissionAsk();
                            await analyticsService.logCallButtonPressed();
                          },
                          child: const CallButton(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _selectType({required CallApp callApp}) {
    switch (callApp) {
      case CallApp.whatsApp:
        return WhatsAppIncomingCallPage.routeName;
      case CallApp.telegram:
        return TelegramIncomingCallPage.routeName;
      case CallApp.messenger:
        return MessengerIncomingCallPage.routeName;
    }
  }
}
