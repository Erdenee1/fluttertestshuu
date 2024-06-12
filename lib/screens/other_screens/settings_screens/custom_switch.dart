import 'package:app/controllers/other_controller/setting_controller.dart';

import '../../../config.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (settingCtrl) {
      return Stack(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            onTap: () => settingCtrl.onStatusChange(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: settingCtrl.isOn
                      ? appCtrl.appTheme.primary
                      : appCtrl.appTheme.gray.withOpacity(.35),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
            ),
          ),
          AnimatedPositioned(
            top: 6.5,
            left: settingCtrl.isOn ? 10 : 5,
            duration: const Duration(milliseconds: 300),
            child: InkWell(
              onTap: () => settingCtrl.onStatusChange(),
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(AppRadius.r5),
                  color: settingCtrl.isOn
                      ? appCtrl.appTheme.white
                      : appCtrl.appTheme.white,
                ),
              ),
            ),
          )
        ],
      ).marginSymmetric(horizontal: Insets.i25);
    });
  }
}

class CustomRtlSwitch extends StatelessWidget {
  const CustomRtlSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (settingCtrl) {
      return Stack(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            onTap: () => settingCtrl.onRtlChange(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: settingCtrl.isRtl
                      ? appCtrl.appTheme.primary
                      : appCtrl.appTheme.gray.withOpacity(.35),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
            ),
          ),
          AnimatedPositioned(
              top: 6.5,
              left: settingCtrl.isRtl ? 10 : 5,
              duration: const Duration(milliseconds: 300),
              child: InkWell(
                  onTap: () => settingCtrl.onRtlChange(),
                  child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(AppRadius.r5),
                        color: settingCtrl.isRtl
                            ? appCtrl.appTheme.white
                            : appCtrl.appTheme.white,
                      ))))
        ],
      ).marginSymmetric(horizontal: Insets.i25);
    });
  }
}
