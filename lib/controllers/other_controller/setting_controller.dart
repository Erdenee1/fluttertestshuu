import 'dart:developer';
import 'dart:io';

import 'package:in_app_review/in_app_review.dart';

import '../../config.dart';
import 'package:share_plus/share_plus.dart';

enum Availability { loading, available, unavailable }


class SettingController extends GetxController {

  late AnimationController controller,controller1;
  late Animation<Offset> offset,offset1;
  final InAppReview _inAppReview = InAppReview.instance;
  bool isOn = false,isRtl = false;
  Availability availability = Availability.loading;

  @override
  void onReady() {

    isOn = appCtrl.isTheme;
    isRtl = appCtrl.isRTL;
    update();
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        availability = isAvailable && !Platform.isAndroid
            ? Availability.available
            : Availability.unavailable;
      } catch (_) {
        availability = Availability.unavailable;
        update();
      }
    });
    super.onReady();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    isOn = appCtrl.isTheme;
    update();
  }

  void onStatusChange() {
    isOn = !isOn;
    update();
    switch (controller.status) {
      case AnimationStatus.dismissed:
        controller.forward();
        break;
      case AnimationStatus.completed:
        controller.reverse();
        break;
      default:
    }
    update();

    appCtrl.isTheme = isOn;
    appCtrl.update();
    ThemeService().switchTheme(appCtrl.isTheme);
    Get.forceAppUpdate();
    log("appCtrl.isTheme :${controller.status}");
    appCtrl.storage.write("isDark", isOn);
  }

  void onRtlChange() {
    isRtl = !isRtl;
    update();
    switch (controller1.status) {
      case AnimationStatus.dismissed:
        controller1.forward();
        break;
      case AnimationStatus.completed:
        controller1.reverse();
        break;
      default:
    }
    update();

    appCtrl.isRTL = isRtl;

    appCtrl.storage.write(session.isRTL, isRtl);
    appCtrl.update();
  }

  onTap(title) async {
    if (title == "aboutUs") {
      Get.toNamed(
        routeName.aboutUs,
      );
    } else if (title == "privacy") {
      Get.toNamed(routeName.htmlPage,
          arguments: {"title": title, "code": appFonts.privacyDesc});
    } else if (title == "terms") {
      Get.toNamed(routeName.htmlPage,
          arguments: {"title": title, "code": appFonts.termsDesc});
    } else if (title == "language") {
      Get.toNamed(
        routeName.languageScreen,
      );
    } else if (title == "share") {
      if(appCtrl.shareContentTitle != ""){
        Share.share(appCtrl.shareContentTitle);
      }else{
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(appFonts.pleaseAdd.tr)));
      }
    }else if (title == "rate") {
      _inAppReview.openStoreListing();

    }
  }
}
