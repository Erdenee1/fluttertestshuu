import 'package:app/screens/other_screens/search_screens/layouts/search_text_box.dart';

import '../../../config.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dash) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.backgroudColor,
          body: ListView(padding: const EdgeInsets.only(top: Sizes.s20),children: [
            Stack(alignment: Alignment.center, children: [
              Transform.flip(
                  flipX: appCtrl.isRTL ? true : false,
                  child: Image.asset(eImageAssets.bannerImage,width: MediaQuery.of(context).size.width,fit: BoxFit.fill,)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(appFonts.fastSearch.tr)
                    .fontWeight(FontWeight.w500)
                    .textColor(appCtrl.appTheme.white)
                    .fontSize(FontSizes.f16)
                    .paddingSymmetric(horizontal: Insets.i20),
                SizedBox(
                        width: Sizes.s190,
                        child: Text(appFonts.fastSearchDes.tr)
                            .textColor(appCtrl.appTheme.white)
                            .fontSize(FontSizes.f12))
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s40),
                const SearchTextBox()
              ])
            ]),
            const VSpace(Sizes.s20),
            Text(appFonts.checkThisOut.tr,
                style: TextStyle(
                    color: appCtrl.appTheme.black,
                    fontSize: FontSizes.f18,
                    fontWeight: FontWeight.w500)),
            const VSpace(Sizes.s14),
            GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Sizes.s200,
                    childAspectRatio: 3 / 1.6,
                    crossAxisSpacing: Sizes.s18,
                    mainAxisSpacing: Sizes.s16),
                itemCount: appCtrl.checkoutList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return CheckThisOut(
                    data: appCtrl.checkoutList[index],
                  );
                }),
            const VSpace(Sizes.s40)
          ]).paddingSymmetric(horizontal: Insets.i18));
    });
  }
}
