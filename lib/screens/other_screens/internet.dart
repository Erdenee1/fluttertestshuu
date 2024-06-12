

import '../../config.dart';

class NoInternet extends StatelessWidget {
  final Widget? child;
  final DocumentSnapshot<Map<String, dynamic>> rm,uc;

  const NoInternet({Key? key, this.child, required this.rm, required this.uc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          if (snapshot.data != null ||
              snapshot.data != ConnectivityResult.none) {
            final splashCtrl = Get.isRegistered<SplashController>()? Get.find<SplashController>():Get.put(SplashController());
            splashCtrl.onReady();
          }
          return snapshot.data == ConnectivityResult.none ||
                  snapshot.data == null
              ? Scaffold(
                  backgroundColor: appCtrl.appTheme.white,
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(eImageAssets.noInternet),
                      const VSpace(Sizes.s30),
                      Text(
                        appFonts.oops.tr,
                        style: AppCss.outfitBold16
                            .textColor(appCtrl.appTheme.black),
                      ),
                      const VSpace(Sizes.s6),
                      Text(
                        appFonts.noInternet.tr,
                        textAlign: TextAlign.center,
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.darkGray),
                      )
                    ],
                  ).marginSymmetric(horizontal: Insets.i30)),
                )
              : SplashScreen(rm: rm, uc: uc,);
        });
  }
}
