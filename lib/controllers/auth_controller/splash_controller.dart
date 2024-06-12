import 'dart:developer';
import 'dart:math' as math;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app/config.dart';

import '../../screens/other_screens/dashboard/dashboard.dart';
import '../../screens/other_screens/internet.dart';
import '../../utils/extensions.dart';

class SplashController extends GetxController {
  String randomNumber = ""; Locale? locale = const Locale("en", "US");
   DocumentSnapshot<Map<String, dynamic>>? rm,uc;

  void generateRandom() async {
    math.Random random = math.Random();
    randomNumber = random.nextInt(1000).toString();
  }

  @override
  void onReady() async {
    generateRandom();
    bool isAvailable = await isNetworkConnection();

    if (isAvailable) {
      await FirebaseFirestore.instance
          .collection("themeColor")
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          log("THEME :${value.docs.length}");
          appCtrl.appTheme.primary =
              hexStringToColor(value.docs[0].data()["selectedThemeColor"]);
          if (value.docs[0]
              .data()['customGradientColorVisible'] ||
              value.docs[0].data()['gradientColorVisible']) {
            isGradient = true;
          }
        }

        appCtrl.update();
        Get.forceAppUpdate();
      });


      await FirebaseFirestore.instance.collection("config").get().then((value) {
        if(value.docs.isNotEmpty){
          appCtrl.isBottomNav = value.docs[0].data()['footerVisible'];
          appCtrl.isAppBar = value.docs[0].data()['headerVisible'];

          appCtrl.headerTitlePosition =
          value.docs[0].data()['headerTitlePosition'];
          appCtrl.shareContentTitle =
          value.docs[0].data()['shareContentTitle'] ?? "";
          appCtrl.baseUrl =
          value.docs[0].data()['baseUrl'] ?? "";
          appCtrl.loaderStyle = value.docs[0].data()['loaderStyle'] ??"";
          appCtrl.isLoading = value.docs[0].data()['showLoader'] ??true;
          appCtrl.color =hexStringToColor(value.docs[0].data()['loaderColor']);
          appCtrl.update();

        }
      });

      String token = appCtrl.storage.read("accessToken") ?? "";
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      if (token == "") {
        firebaseMessaging.getToken().then((token) async {

          await FirebaseFirestore.instance
              .collection("users")
              .doc(randomNumber)
              .set({'id': randomNumber, "pushToken": token});
          appCtrl.storage.write("accessToken", token);
        });
      }
      appCtrl.isTheme = appCtrl.storage.read("isDark") ?? false;
      appCtrl.isOnboard = appCtrl.storage.read(session.isIntro) ?? false;
      appCtrl.isRTL = appCtrl.storage.read(session.isRTL) ?? false;


      FirebaseFirestore.instance
          .collection("headerRightIconConfig")
          .where("Action", isEqualTo: true).get().then((value) {
            if(value.docs.isNotEmpty){
              appCtrl.rightIcon = value.docs[0].data();
            }
      });
      FirebaseFirestore.instance
          .collection("headerConfig")
          .where("Action", isEqualTo: true).get().then((value) {
        if(value.docs.isNotEmpty){
          appCtrl.leftIcon = value.docs[0].data();
        }
      });
      appCtrl.update();
      final dash = Get.isRegistered<DashboardController>()
          ? Get.find<DashboardController>()
          : Get.put(DashboardController());
      dash.getCheckoutList();
    dash.update();
      final home = Get.isRegistered<HomeScreenController>()
          ? Get.find<HomeScreenController>()
          : Get.put(HomeScreenController());
      home.getRefresh();



      var language = await appCtrl.storage.read("locale") ?? "en";

      if (language != null) {
        appCtrl.languageVal = language;
        if (language == "en") {
          locale = const Locale("en", "US");
        } else if (language == "mn") {
          locale = const Locale("mn", "MN");
        } 
      } else {
        locale = const Locale("en", "US");
      }
      update();
      log("SSSSSSSSS");
      Future.delayed(const Duration(seconds: 3), () {
        if (!appCtrl.isOnboard) {
          Get.to(() =>uc!['isOnboardingVisible']
              ? OnBoardingScreen(uc: uc!)
              : Dashboard());

        } else {
          Get.offAllNamed(routeName.dashboard);
        }
      });
    } else {
      return Get.to(NoInternet(rm: rm!,uc: uc!), transition: Transition.downToUp);
    }
  }
}
