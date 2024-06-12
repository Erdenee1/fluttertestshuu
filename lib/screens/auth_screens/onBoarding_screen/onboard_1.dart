import '../../../config.dart';

class OnBoardingVariant1 extends StatelessWidget {


  const OnBoardingVariant1({super.key});

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
                      return Stack(children: [
                        PageView(
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
                                  (e) => Column(children: [
                                    Container(
                                      transform: Matrix4.translationValues(
                                          45.0, -52.0, 0.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                eImageAssets.onBoarding1Bg),
                                            fit: BoxFit.cover),
                                      ),
                                      child: PageViewCommon(
                                        image: snapShot.data!
                                            .docs[onBoardingCtrl.selectIndex]
                                            .data()["logo"],
                                      ),
                                    ),
                                  ]),
                                )
                                .toList()).marginOnly(
                          top: Sizes.s30,
                        ),
                        OnBoardBottomLayout(
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
                                              session.isIntro, true),
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
