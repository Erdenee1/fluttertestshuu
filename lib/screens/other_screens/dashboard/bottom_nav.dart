import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/cupertino.dart';
import '../../../config.dart';


class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DashboardController>(
        builder: (dashboardCtrl) {
        return BottomBarInspiredOutside(
          items: items,

          backgroundColor: appCtrl.appTheme.white,
          color: appCtrl.appTheme.lightGray,
          colorSelected: appCtrl.appTheme.white,titleStyle: AppCss.outfitMedium14,
          indexSelected: dashboardCtrl.maxCount,
          onTap: (int index) {
            dashboardCtrl.maxCount = index;
            dashboardCtrl.update();
            Get.forceAppUpdate();
          },
          top: -25,
          animated: true,
          itemStyle: ItemStyle.hexagon,
          chipStyle: ChipStyle(drawHexagon: true,background: appCtrl.appTheme.primary),
        );
      }
    );
  }

}

 List<TabItem> items = [
  TabItem(

    icon: CupertinoIcons.search,

     title: appFonts.search.tr,
  ),
  TabItem(
    icon: Icons.home_rounded,
    title: appFonts.home.tr,
  ),
  TabItem(
    icon: Icons.settings_rounded,
    title: appFonts.settings.tr,
  ),

];
