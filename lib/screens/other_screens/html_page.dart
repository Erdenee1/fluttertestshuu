import 'dart:developer';
import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config.dart';
import '../../widgets/ad_common_layout.dart';

class HtmlPage extends StatefulWidget {
  const HtmlPage({super.key});

  @override
  State<HtmlPage> createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  String name = "", code = "";

  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;

  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;
  Map<String, dynamic>? firebase;
  NativeAd? nativeAd;
  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  bool nativeAdIsLoaded = false, isAddVisible = false;

  @override
  void initState() {
    addCtrl.onInterstitialAdShow();
    dynamic data = Get.arguments ?? "";
    name = data['title'] ?? "";
    code = data['code'] ?? "";
    getBanner();
    setState(() {});

    super.initState();
  }

  getBanner() async {
    await FirebaseFirestore.instance
        .collection("adsConfiguration")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        firebase = value.docs[0].data();
        isAddVisible = value.docs[0].data()['isAdVisible'];
        setState(() {
          log("isAdVisible :$isAddVisible");
          log("isAdVisible :${value.docs[0].data()}");
        });
        if (value.docs[0].data()['isAdVisible']) {
          if (bannerAd == null) {
            bannerAd = BannerAd(
                size: AdSize.banner,
                adUnitId: Platform.isAndroid
                    ? value.docs[0].data()['adMobBannerAndroid']
                    : value.docs[0].data()['adMobBanneriOS'],
                listener: BannerAdListener(
                  onAdLoaded: (Ad ad) {
                    log('$BannerAd loaded.');
                    bannerAdIsLoaded = true;
                    setState(() {});
                  },
                  onAdFailedToLoad: (Ad ad, LoadAdError error) {
                    log('$BannerAd failedToLoad: $error');
                    ad.dispose();
                  },
                  onAdOpened: (Ad ad) => log('$BannerAd onAdOpened.'),
                  onAdClosed: (Ad ad) => log('$BannerAd onAdClosed.'),
                ),
                request: const AdRequest())
              ..load();
            log("Home Banner : $bannerAd");
          } else {
            bannerAd!.dispose();
            buildBanner();
          }

          FacebookAudienceNetwork.init(
            testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6",
            iOSAdvertiserTrackingEnabled: true,
          );
          _showBannerAd();
        }
      }
    });
  }

  _showBannerAd() {
    log("SHOW BANNER222");
    currentAd = FacebookBannerAd(
      placementId: "YOUR_PLACEMENT_ID",
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        log("Banner Ad: $result -->  $value");
      },
    );
    setState(() {});
    log("_currentAd : $currentAd");
  }

  buildBanner() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? firebase!['adMobBannerAndroid']
            : firebase!['adMobBanneriOS'],
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            log('$BannerAd loaded.');
            bannerAdIsLoaded = true;
            setState(() {});
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            log('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => log('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => log('$BannerAd onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();
    log("Home Banner AGAIn: $bannerAd");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCtrl.appTheme.backgroudColor,
      appBar: name == ""
          ? null
          : AppBar(
              iconTheme: IconThemeData(color: appCtrl.appTheme.black),
              backgroundColor: appCtrl.appTheme.backgroudColor,
              title: Text(
                name.tr,
                style: AppCss.outfitMedium18.textColor(appCtrl.appTheme.black),
              ),
            ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Text(
              code.tr,
              style: AppCss.outfitMedium14
                  .textColor(appCtrl.appTheme.black)
                  .letterSpace(1),
            ).paddingAll(Insets.i20),
          ),
          if (isAddVisible)
            Align(
                alignment: Alignment.bottomCenter,
                child: AdCommonLayout(
                    bannerAdIsLoaded: bannerAdIsLoaded,
                    bannerAd: bannerAd,
                    currentAd: currentAd)),
        ],
      ),
    );
  }
}
