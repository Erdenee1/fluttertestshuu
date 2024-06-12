

import '../../../config.dart';

class OnBoardingVariant2 extends StatelessWidget {
  final onBoardingCtrl = Get.put(OnBoardingController());

  OnBoardingVariant2({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {

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
                      return Column(children: [
                        const VSpace(Sizes.s30),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.6,
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
                                  .map(
                                    (e) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  eImageAssets.onBoarding2Bg),
                                              fit: BoxFit.contain),
                                        ),
                                        child: PageViewCommon(
                                          image: snapShot.data!
                                              .docs[onBoardingCtrl.selectIndex]
                                              .data()["logo"],
                                        )),
                                  )
                                  .toList()),
                        ),
                        OnBoardBottomLayout2(
                            title: snapShot.data!
                                .docs[onBoardingCtrl.selectIndex]['title'],
                            description: snapShot
                                    .data!.docs[onBoardingCtrl.selectIndex]
                                ['description'],
                            onTap: () => {
                                  onBoardingCtrl.selectIndex != 2
                                      ? {
                                          appCtrl.isOnboard = true,
                                          appCtrl.storage.write(
                                              "isOnboard", appCtrl.isOnboard),
                                          onBoardingCtrl.selectIndex =
                                              onBoardingCtrl.selectIndex + 1,
                                          onBoardingCtrl.update()
                                        }
                                      : {Get.offAllNamed(routeName.dashboard), appCtrl.isOnboard = true,
                                    appCtrl.storage.write(
                                        session.isIntro, true),appCtrl.update()}
                                })
                      ]);
                    } else {
                      return Container();
                    }
                  })));
    });
  }
}
