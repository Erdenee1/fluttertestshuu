import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app/controllers/other_controller/setting_controller.dart';
import 'package:app/screens/other_screens/settings_screens/custom_switch.dart';
import 'package:app/widgets/directionality_rtl.dart';

import '../../../config.dart';
import '../../../widgets/common_loader.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  final settingCtrl = Get.put(SettingController());

  @override
  void initState() {
    settingCtrl.isOn = appCtrl.isTheme;
    settingCtrl.controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    settingCtrl.offset = (settingCtrl.isOn
            ? Tween<Offset>(
                begin: const Offset(1.15, 0),
                end: Offset.zero,
              )
            : Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(1, 0),
              ))
        .animate(settingCtrl.controller);

    settingCtrl.isRtl = appCtrl.isRTL;
    settingCtrl.controller1 = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    settingCtrl.offset1 = (settingCtrl.isRtl
            ? Tween<Offset>(
                begin: const Offset(1.15, 0),
                end: Offset.zero,
              )
            : Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(1, 0),
              ))
        .animate(settingCtrl.controller1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
          backgroundColor: appCtrl.appTheme.backgroudColor,
          body: CustomMaterialIndicator(
            withRotation: false,
            onRefresh: () {
              return settingCtrl.onRefresh();
            },
            indicatorBuilder:
                (BuildContext context, IndicatorController controller) {
              return const CommonLoader();
            },
            child: ListView(
              children: [
                ...appArray.settingList.asMap().entries.map((e) =>
                    Transform.flip(
                      flipX: appCtrl.isRTL ? true : false,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Stack(
                            children: [
                              Stack(alignment: Alignment.centerLeft, children: [
                                SvgPicture.asset(appCtrl.isTheme
                                    ? svgAssets.darkRect1
                                    : svgAssets.halfRect),
                                Transform.flip(
                                    flipX: appCtrl.isRTL ? true : false,
                                    child: Row(children: [
                                      Container(
                                          height: Sizes.s20,
                                          width: Sizes.s2,
                                          color: appCtrl.appTheme.primary),
                                      const HSpace(Sizes.s12),
                                      SvgPicture.asset(
                                          e.value['icon'].toString(),
                                          colorFilter: ColorFilter.mode(
                                              appCtrl.appTheme.primary,
                                              BlendMode.srcIn))
                                    ]))
                              ]),
                              Align(
                                  alignment: Alignment.center,
                                  child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        SvgPicture.asset(
                                          appCtrl.isTheme
                                              ? svgAssets.darkRect2
                                              : svgAssets.halfRect2,
                                        ).marginOnly(
                                            left: appCtrl.isTheme ? 3 : 0),
                                        Transform.flip(
                                          flipX: appCtrl.isRTL ? true : false,
                                          child: Text(
                                                  e.value['title']
                                                      .toString()
                                                      .tr,
                                                  style: GoogleFonts.readexPro(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: appCtrl.isTheme
                                                          ? appCtrl
                                                              .appTheme.black
                                                          : appCtrl.appTheme
                                                              .darkGray,
                                                      fontSize: FontSizes.f16))
                                              .marginSymmetric(
                                                  horizontal: Insets.i35),
                                        )
                                      ]).marginOnly(left: 50)),
                            ],
                          ).width(MediaQuery.of(context).size.width),
                          SvgPicture.asset(appCtrl.isTheme
                                  ? svgAssets.darkDotLine
                                  : svgAssets.dotLine)
                              .marginSymmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 7.2),
                          Align(
                              alignment: Alignment.centerRight,
                              child: e.key == 0
                                  ? const CustomSwitch()
                                  : e.key == 1
                                      ? const CustomRtlSwitch()
                                      : SvgPicture.asset(svgAssets.arrowRight)
                                          .inkWell(
                                              onTap: () => settingCtrl
                                                  .onTap(e.value['title']))
                                          .marginSymmetric(
                                              horizontal: Insets.i20)),
                        ],
                      )
                          .marginOnly(
                              bottom: Insets.i20,
                              left: Insets.i20,
                              right: Insets.i20)
                          .inkWell(
                              onTap: () => settingCtrl.onTap(e.value['title'])),
                    ))
              ],
            ).paddingSymmetric(vertical: Insets.i20),
          ),
        ),
      );
    });
  }
}
