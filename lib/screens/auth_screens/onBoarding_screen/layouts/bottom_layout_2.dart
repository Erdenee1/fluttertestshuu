import '../../../../config.dart';

class OnBoardBottomLayout2 extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title, description;
  const OnBoardBottomLayout2(
      {Key? key, this.description, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
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
            const VSpace(Sizes.s10),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appCtrl.appTheme.lightGray,
                fontSize: FontSizes.f15,
                fontWeight: FontWeight.w400,
                height: 1.44,
              ),
            ),
            const VSpace(Sizes.s30),
            Container(
              width: Sizes.s250,
              height: Sizes.s46,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                color: appCtrl.appTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
              ),
              child: Text(
                appFonts.next.toUpperCase(),
                style: TextStyle(
                  color: appCtrl.appTheme.white,
                  fontSize: FontSizes.f16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.28,
                ),
              ),
            ).inkWell(onTap: onTap),
            const VSpace(Sizes.s30),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    3,
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
            const VSpace(Sizes.s10)
          ],
        ),
      );
    });
  }
}
