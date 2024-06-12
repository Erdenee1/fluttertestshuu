import 'package:app/widgets/common_button.dart';

import '../../../config.dart';
import 'app_bar_title.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("config").snapshots(),
        builder: (context, snap) {
          String? logo, dartThemeLogo, headerTitlePosition, appName;
          if (snap.hasData) {
            if (snap.data!.docs.isNotEmpty) {
              logo = snap.data!.docs[0].data()['logo'];
              dartThemeLogo = snap.data!.docs[0].data()['logoDark'] ?? "";
              appName = snap.data!.docs[0].data()['appName'];
              headerTitlePosition =
                  snap.data!.docs[0].data()['headerTitlePosition'];
            }
          }
          return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
            return AppBar(
                toolbarHeight: kToolbarHeight,
                flexibleSpace: isGradient
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                            appCtrl.appTheme.gradient1,
                            appCtrl.appTheme.gradient2
                          ])))
                    : Container(
                        decoration:
                            BoxDecoration(color: appCtrl.appTheme.white)),
                backgroundColor: appCtrl.appTheme.backgroudColor,
                leading: appCtrl.isTheme
                    ? dartThemeLogo != null && dartThemeLogo != ""
                        ? Image.network(dartThemeLogo, height: Sizes.s24)
                            .marginSymmetric(horizontal: Insets.i18)
                        : Container()
                    : logo != null
                        ? Image.network(logo, height: Sizes.s24)
                            .marginSymmetric(horizontal: Insets.i18)
                        : Container(),
                elevation: 0,
                leadingWidth: Sizes.s100,
                title: headerTitlePosition == "center" ||
                        headerTitlePosition == "start"
                    ? AppBarTitle(
                        logo: logo,
                        appName: appName,
                        index: dashboardCtrl.maxCount)
                    : Container(),
                centerTitle: headerTitlePosition == "start" ? false : true,
                actions: [
                  Row(children: [
                    if (headerTitlePosition == "end")
                      AppBarTitle(
                          logo: logo,
                          appName: appName,
                          index: dashboardCtrl.maxCount),
                    dashboardCtrl.maxCount == 1
                        ? CommonButton(
                            title: "Худалдаж авах",
                            width: 90,
                            style: TextStyle(color: appCtrl.appTheme.white),
                            onTap: () =>
                                Get.toNamed(routeName.webView, arguments: {
                              "URL":
                                  "https://localhost/item/app-admin-panel/51666687"
                            }),
                          )
                        : Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Insets.i30),
                                    color: appCtrl.appTheme.primary),
                                child: Image.network(appCtrl.rightIcon['Image'],
                                        height: Sizes.s22)
                                    .paddingAll(Insets.i4))
                            .marginSymmetric(horizontal: Insets.i20)
                            .inkWell(
                                onTap: () => dashboardCtrl
                                    .onRightTap(appCtrl.rightIcon['title']))
                  ])
                ]);
          });
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}
