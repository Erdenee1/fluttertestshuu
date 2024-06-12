import 'dart:developer';
import 'dart:io';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../config.dart';

class AdController extends GetxController {
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;
  dynamic data;
  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;
  bool isInterstitialAdLoaded = false;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  NativeAd? nativeAd;

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  bool nativeAdIsLoaded = false;

  onInterstitialAdShow() async {
    await FirebaseFirestore.instance
        .collection("adsConfiguration")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        data = value.docs[0].data();
        update();
        if (value.docs[0].data()['isAdVisible'] == true) {
          log("value.docs[0].data()['googleAdsVisible']  :${value.docs[0].data()['googleAdsVisible']}");
          if (value.docs[0].data()['googleAdsVisible'] == true) {
            showInterstitialAd();
          } else {
            loadInterstitialAd();
          }
        }
      }
      update();
    });
    update();
  }

  _showBannerAd() {
    log("SHOW BANNER111");
    currentAd = FacebookBannerAd(
      placementId: "YOUR_PLACEMENT_ID",
      placementId: Platform.isAndroid
          ? "#YOUR_PLACEMENT_ID"
          : data['facebookAdInterstitialiOS'],
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        log("Banner Ad: $result -->  $value");
      },
    );
    update();
    log("_currentAd : $currentAd");
  }

  buildBanner() async {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? data['adMobBannerAndroid']
            : data['adMobBanneriOS'],
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            log('$BannerAd loaded.sss');
            bannerAdIsLoaded = true;
            update();
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

  void loadInterstitialAd() {
    FacebookAudienceNetwork.init(
      testingId: "37b1fa9d-b48c-4103-e393-2u065e734bd6",
      iOSAdvertiserTrackingEnabled: true,
    );
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: "#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        log("resultAD : $result");
        log("result1AD : ${result.name}");
        log("resultAD2 : $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
        }
      },
    );
  }

  showFbInterstitialAd() {
    if (isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      log("Завсрын зар хараахан ачаалагдаагүй байна!");
    }
  }


  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? data['facebookAdBannerAndroid']
            : data['facebookAdBanneriOS'],
        request: appCtrl.request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            log('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('InterstitialAd-г ачаалж чадсангүй: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 3) {
              _createInterstitialAd();
            }
          },
        ));
    update();
  }

  void showInterstitialAd() {
    if (_interstitialAd == null) {
      log('Анхааруулга: Ачаалахаасаа өмнө завсрын хэсгийг харуулахыг оролдсон.');
      _createInterstitialAd();
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
    update();
  }

  onBannerAds() {
    if (data['isAdVisible'] == true) {
      if (bannerAd == null && bannerAdIsLoaded == false) {
        bannerAd = BannerAd(
            size: AdSize.banner,
            adUnitId: Platform.isAndroid
                ? data['adMobBannerAndroid']
                : data['adMobBanneriOS'],
            listener: BannerAdListener(
              onAdLoaded: (Ad ad) {
                log('$BannerAd loaded.');
                bannerAdIsLoaded = true;
                update();
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
        log("dfg Banner : $bannerAd");
      } else {
        bannerAd!.dispose();
        buildBanner();
      }
    }
  }

  @override
  void onInit() async {
    await FirebaseFirestore.instance
        .collection("adsConfiguration")
        .get()
        .then((value) {
      log("VALUE: ${value.docs.isNotEmpty}");
      if (value.docs.isNotEmpty) {
        data = value.docs[0].data();
        update();
      }
    }).then((value) => onBannerAds());

    FacebookAudienceNetwork.init(
      testingId: "37b8da9d-b48c-4103-a393-2e005e734bd6",
      iOSAdvertiserTrackingEnabled: true,
    );
    _showBannerAd();
    _createInterstitialAd();

    update();
    super.onInit();
  }

  @override
  void dispose() {
    
    bannerAd?.dispose();
    bannerAd = null;
    super.dispose();
  }
}
