import 'package:app/widgets/common_button.dart';
import 'package:app/widgets/directionality_rtl.dart';

import '../../config.dart';
import '../../controllers/other_controller/language_controller.dart';
import 'language/radio_layout.dart';

class SelectLanguageScreen extends StatelessWidget {
  final languageCtrl = Get.put(SelectLanguageController());

  SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectLanguageController>(builder: (_) {
      return DirectionalityRtl(
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.white,
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  leading: Icon(Icons.arrow_back, color: appCtrl.appTheme.black)
                      .inkWell(onTap: () => Get.back()),
                  backgroundColor: appCtrl.appTheme.white,
                  title: Text(appFonts.selectLanguage.tr,
                      style: AppCss.outfitMedium18
                          .textColor(appCtrl.appTheme.black))),
              body: ListView(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(appFonts.selectLanguage.tr,
                      style: AppCss.outfitSemiBold22
                          .textColor(appCtrl.appTheme.black)),
                  const VSpace(Sizes.s10),
                  Text(appFonts.youCanChangeIt.tr,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightGray)),
                  ...languageCtrl.selectLanguageLists
                      .asMap()
                      .entries
                      .map((e) => RadioButtonLayout(
                          data: e.value,
                          selectIndex: languageCtrl.selectIndex,
                          index: e.key,
                          onTap: () =>
                              languageCtrl.onLanguageSelectTap(e.key, e.value)))
                      .toList()
                ])
                    .paddingSymmetric(
                        horizontal: Insets.i20, vertical: Insets.i25)
                    .decorated(
                        color: appCtrl.appTheme.white,
                        boxShadow: [
                          BoxShadow(
                              color: appCtrl.isTheme
                                  ? appCtrl.appTheme.primary.withOpacity(0.2)
                                  : Colors.transparent,
                              spreadRadius: 1,
                              blurRadius: 4)
                        ],
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r10)),
                        border: Border.all(
                            color: appCtrl.isTheme
                                ? appCtrl.appTheme.primary.withOpacity(0.2)
                                : appCtrl.appTheme.primary.withOpacity(0.1),
                            width: 2)),
                CommonButton(
                        title: appFonts.selectLanguage.tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.white),
                        onTap: () => languageCtrl.onContinue())
                    .paddingSymmetric(vertical: Insets.i20)
              ]).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i15)));
    });
  }
}
