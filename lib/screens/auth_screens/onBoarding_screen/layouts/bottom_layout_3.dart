import '../../../../config.dart';

class OnBoardBottomLayout3 extends StatelessWidget {
  final GestureTapCallback? onTap, onPrevTap;
  final String? title, description;
  final int? totalCount;
  const OnBoardBottomLayout3(
      {Key? key, this.description, this.title, this.onTap, this.onPrevTap, this.totalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection("themeColor").snapshots(),
          builder: (context, themeSnap) {
            bool isGradient = false;
            if (themeSnap.hasData) {
              if (themeSnap.data!.docs.isNotEmpty) {
                if (themeSnap.data!.docs[0]
                    .data()['customGradientColorVisible'] ||
                    themeSnap.data!.docs[0].data()['gradientColorVisible']) {
                  isGradient = true;
                }
              }
            }
          return SizedBox(
            width: MediaQuery.of(context).size.width / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: appCtrl.appTheme.darkGray,
                    fontSize: FontSizes.f26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    description!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: appCtrl.appTheme.lightGray,
                      fontSize: FontSizes.f16,
                      fontWeight: FontWeight.w400,
                      height: 1.44,
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                        totalCount!,
                        (index) => InkWell(
                              onTap: () {
                                onBoardingCtrl.pageCtrl.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: Container(
                                width: Insets.i20,
                                height: Insets.i4,
                                decoration: ShapeDecoration(
                                  color: onBoardingCtrl.selectIndex == index
                                      ? appCtrl.appTheme.primary
                                      : appCtrl.appTheme.primary.withOpacity(.2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                              ),
                            ).marginOnly(left: Insets.i6))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Sizes.s155,
                      height: Sizes.s44,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: appCtrl.appTheme.moreLightGray,
                        gradient: isGradient? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              appCtrl.appTheme.gradient1,
                              appCtrl.appTheme.gradient2
                            ]):null,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            topRight: Radius.circular(6),
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                      ),
                      child: Text(
                        appFonts.prev.toUpperCase(),
                        style: TextStyle(
                          color: appCtrl.appTheme.lightGray,
                          fontSize: FontSizes.f15,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.28,
                        ),
                      ),
                    ).inkWell(onTap: onPrevTap),
                    const HSpace(Sizes.s10),
                    Container(
                        width: Sizes.s155,
                        height: Sizes.s44,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: appCtrl.appTheme.primary,
                          gradient: isGradient? LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                appCtrl.appTheme.gradient1,
                                appCtrl.appTheme.gradient2
                              ]):null,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(22),
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(22),
                            ),
                          ),
                        ),
                        child: Text(
                          appFonts.next.toUpperCase(),
                          style: TextStyle(
                            color: appCtrl.appTheme.white,
                            fontSize: FontSizes.f15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.28,
                          ),
                        )).inkWell(onTap: onTap)
                  ],
                ),
                const VSpace(Sizes.s10),
              ],
            ),
          );
        }
      );
    });
  }
}
