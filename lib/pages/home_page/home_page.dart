import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sirenhead_test/pages/home_page/widgets/bottom_item.dart';
import 'package:sirenhead_test/pages/home_page/widgets/home_page_item.dart';
import 'package:sirenhead_test/pages/select_type_call_page/select_type_call_page.dart';
import 'package:sirenhead_test/pages/chat_page/chat_page.dart';
import 'package:sirenhead_test/pages/widgets/rate_us.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
import 'package:sirenhead_test/resources/app_constants_string.dart';
import 'package:sirenhead_test/resources/app_icons.dart';
import 'package:sirenhead_test/resources/app_images.dart';
import 'package:sirenhead_test/resources/app_text_styles.dart';
import 'package:sirenhead_test/services/cas.dart';
import 'package:sirenhead_test/services/toggle_review.dart';
import 'package:sirenhead_test/utils/enums/call_type.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = 'main-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    CASAd.view?.hideBanner();

    setAd();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }
  Future<void> setAd() async {
    await LocalStorageService.setStatusAD('yes');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: gradientBackground,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(width: 8, color: Colors.white)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Image.asset(
                        AppImages.sirenMan,
                        fit: BoxFit.cover,
                        height: 200,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 36, bottom: 18),
                    decoration: BoxDecoration(
                      color: AppColors.appBackGroundWhite,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.11),
                          offset: Offset(0, 4),
                          blurRadius: 17,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomePageItem(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                SelectTypeCallPage.routeName,
                                arguments: CallType.voice);
                          },
                          title: 'Audio_call'.tr(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        HomePageItem(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                SelectTypeCallPage.routeName,
                                arguments: CallType.video);
                          },
                          title: 'Video_call'.tr(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        HomePageItem(
                          onTap: () {
                            Navigator.of(context).pushNamed(ChatPage.routeName);
                          },
                          title: 'Messenger'.tr(),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: BottomItem(
                                
                                icon: AppIcons.stars,
                                title: 'Rate_us'.tr(),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const RatingDialog(),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: BottomItem(
                                icon: AppIcons.privacy,
                                title: 'Privacy_policy'.tr(),
                                onTap: () async {
                                  final url =
                                      Uri.parse(AppConstants.privacyPolicy);
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
