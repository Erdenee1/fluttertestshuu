import 'dart:developer';

import 'package:app/config.dart';

import '../../utils/extensions.dart';

class OnBoardingController extends GetxController {
  PageController pageCtrl = PageController();
  List onBoardingLists = [];
  bool isLastPage = false;
  int selectIndex = 0;
  Locale? locale = const Locale("en", "US");

  @override
  void onInit() async {
    await FirebaseFirestore.instance
        .collection("onBoardScreenConfiguration")
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        onBoardingLists =  value.docs;
        selectIndex = 0;
      }
    });
    update();

    await FirebaseFirestore.instance.collection("themeColor").get().then((value) {
      if(value.docs.isNotEmpty){

        appCtrl.appTheme.primary = hexStringToColor(value.docs[0].data()["selectedThemeColor"]);
      }
      log("appCtrl.appTheme.primary :${appCtrl.appTheme.primary}");
      appCtrl.update();
      Get.forceAppUpdate();
    });



    appCtrl.isTheme = appCtrl.storage.read("isDark") ?? false;

    appCtrl.update();
    ThemeService().switchTheme(appCtrl.isTheme);
    Get.forceAppUpdate();



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


    super.onInit();
  }

  @override
  void onReady() async {}
}
