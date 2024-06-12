import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config.dart';
import '../../widgets/ad_common_layout.dart';
import '../../widgets/common_loader.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  String? name;
  dynamic data;
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
  bool nativeAdIsLoaded = false, isAdVisible = false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  PullToRefreshController? pullToRefreshController;

  ContextMenu? contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  initState() {
    onReady();
    getBanner();
    super.initState();
  }

  onReady() async {
    data = Get.arguments ?? "";
    name = data['Title'] ?? "";
    await Future.delayed(DurationsClass.s1);
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              id: 1,
              title: "Special",
              action: () async {
                await webViewController?.clearFocus();
              })
        ],
        settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {},
        onHideContextMenu: () {},
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {});

    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );

    setState(() {
      isLoading = false;
    });
  }

  getBanner() async {
    await FirebaseFirestore.instance
        .collection("adsConfiguration")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        firebase = value.docs[0].data();
        isAdVisible = value.docs[0].data()['isAdVisible'];
        setState(() {

        });

        if (isAdVisible) {
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
            testingId: "87b1da9d-b48c-4103-a393-2e095e734bd6",
            iOSAdvertiserTrackingEnabled: true,
          );
          _showBannerAd();
        }
      }
    });
  }

  _showBannerAd() {
    log("SHOW BANNER333");
    currentAd = FacebookBannerAd(
      placementId: "PLACEMENT_ID",
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.backgroudColor,
            body: Stack(children: [
              if (contextMenu != null || webViewController != null)
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: WebUri(data["URL"])),
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialSettings: settings,
                  contextMenu: contextMenu,
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                    setState(() {});
                  },
                  onLoadStart: (controller, url) async {},
                  onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                        );
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    pullToRefreshController?.endRefreshing();
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onReceivedError: (controller, request, error) {
                    pullToRefreshController?.endRefreshing();
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController?.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = url;
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {},
                ).height(MediaQuery.of(context).size.height),
              if (isLoading) const CommonLoader(),
              Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(6)),
                          child: const Icon(Icons.arrow_back_outlined,
                                  color: Colors.white)
                              .inkWell(onTap: () => Get.back())))
                  .padding(bottom: 80, horizontal: Sizes.s20),
              if (isAdVisible)
                Align(
                  alignment: Alignment.topCenter,
                  child: AdCommonLayout(
                      bannerAdIsLoaded: bannerAdIsLoaded,
                      bannerAd: bannerAd,
                      currentAd: currentAd),
                )
            ])));
  }
}

Widget parseWidget(data) {
  switch (data) {
    case 'Container':
      return Container(
        child: parseWidget(data['child']),
      );
    case 'Text':
      return Text(data['value']);
  }
  return const CircularProgressIndicator();
}
