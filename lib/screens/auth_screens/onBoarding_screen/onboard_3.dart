import 'dart:developer';

import '../../../config.dart';

class OnBoardingVariant3 extends StatelessWidget {
  final onBoardingCtrl = Get.put(OnBoardingController());

  OnBoardingVariant3({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      log("ssss${appCtrl.appTheme.primary}");
      return PopScope(
          canPop:true,
          onPopInvoked: (didPop){
            if(didPop) return;
            SystemNavigator.pop();
          },
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.white,
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("onBoardScreenConfiguration")
                      .snapshots(),
                  builder: (context, snapShot) {

                    if (snapShot.hasData) {
                      var totalCount = snapShot.data!.docs.length;
                      return Column(children: [
                        const VSpace(Sizes.s30),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: PageView(
                              onPageChanged: (index) {
                                appCtrl.isOnboard = true;
                                appCtrl.storage
                                    .write("isOnboard", appCtrl.isOnboard);
                                onBoardingCtrl.selectIndex = index;
                                onBoardingCtrl.update();
                              },
                              controller: onBoardingCtrl.pageCtrl,
                              children: snapShot.data!.docs
                                  .asMap()
                                  .entries
                                  .map((e) => Stack(
                                children: [
                                  Image.asset(eImageAssets.onBoarding3Bg),
                                  PageViewCommon(
                                    image: snapShot.data!
                                        .docs[onBoardingCtrl.selectIndex]
                                        .data()["logo"],
                                  ),
                                ],
                              ).marginAll(Insets.i30))
                                  .toList()),
                        ),
                        Expanded(
                          child: OnBoardBottomLayout3(
                            totalCount: totalCount,
                              title: snapShot.data!
                                  .docs[onBoardingCtrl.selectIndex]['title'],
                              description: snapShot
                                      .data!.docs[onBoardingCtrl.selectIndex]
                                  ['description'],
                              onPrevTap: () => {
                                    onBoardingCtrl.selectIndex != 0
                                        ? {
                                            appCtrl.isOnboard = true,
                                            appCtrl.storage.write(
                                                session.isIntro, true),
                                            onBoardingCtrl.selectIndex =
                                                onBoardingCtrl.selectIndex - 1,
                                            onBoardingCtrl.update()
                                          }
                                        : {onBoardingCtrl.update(),}
                                  },
                              onTap: () => {
                                    totalCount - 1 != onBoardingCtrl.selectIndex
                                        ? {
                                            appCtrl.isOnboard = true,
                                            appCtrl.storage.write(
                                                session.isIntro, true),
                                            onBoardingCtrl.selectIndex =
                                                onBoardingCtrl.selectIndex + 1,
                                            onBoardingCtrl.update()
                                          }
                                        : {Get.offAllNamed(routeName.dashboard), appCtrl.isOnboard = true,
                                      appCtrl.storage.write(
                                          session.isIntro,true),appCtrl.update()}
                                  }),
                        )
                      ]);
                    } else {
                      return Container();
                    }
                  })));
    });
  }
}
