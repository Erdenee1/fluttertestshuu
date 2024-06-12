import '../../../../config.dart';

class OnBoardBottomLayout extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title, description;

  const OnBoardBottomLayout(
      {Key? key, this.description, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(title!,
                  style: TextStyle(
                    color: appCtrl.appTheme.darkGray,
                    fontSize: FontSizes.f28,
                    fontWeight: FontWeight.w600,
                  )),
              Text(
                description!,
                style: TextStyle(
                  color: appCtrl.appTheme.lightGray,
                  fontSize: FontSizes.f15,
                  fontWeight: FontWeight.w400,
                  height: 1.44,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: Insets.i20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                          width: onBoardingCtrl.selectIndex == index
                              ? Insets.i20
                              : Insets.i10,
                          height: Sizes.s6,
                          decoration: ShapeDecoration(
                            color: onBoardingCtrl.selectIndex == index
                                ? appCtrl.appTheme.primary
                                : appCtrl.appTheme.primary.withOpacity(.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                      ).marginOnly(left: 10))).marginSymmetric(horizontal: Insets.i20),
              Image.asset(eImageAssets.submit1,height: Sizes.s100).inkWell(
                onTap: onTap,
              )
            ],
          )
        ],
      ).marginOnly(bottom: Insets.i40);
    });
  }
}
