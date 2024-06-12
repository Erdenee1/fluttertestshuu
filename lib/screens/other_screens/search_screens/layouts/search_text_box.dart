import '../../../../config.dart';

class SearchTextBox extends StatelessWidget {
  const SearchTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dash) {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: Insets.i10),
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appCtrl.appTheme.white,
              borderRadius: BorderRadius.circular(26)),
          child: Stack(
            children: [
              Theme(
                data: ThemeData(canvasColor: Colors.red),
                child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(eImageAssets.globalImage),
                    HSpace(Sizes.s10),
                    TextField(
                        style: TextStyle(color: appCtrl.appTheme.black),
                        controller: dash.searchCtrl,
                        decoration:
                        InputDecoration(hintText: appFonts.enterYourUrl.tr))
                        .expanded(),
                    Container(
                      width: Sizes.s35,
                      height: Sizes.s35,
                      decoration: BoxDecoration(
                          color: appCtrl.appTheme.onBoardingColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Image.asset(eImageAssets.arrowRight),
                    ).inkWell(onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      String pattern =
                          r'^((ftp|http|https):\/\/)?(www.)?(?!.*(ftp|http|https|www.))[a-zA-Z0-9_-]+(\.[a-zA-Z]+)+((\/)[\w#]+)*(\/\w+\?[a-zA-Z0-9_]+=\w+(&[a-zA-Z0-9_]+=\w+)*)?$';
                      RegExp regExp = RegExp(pattern);
                      if (dash.searchCtrl.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: appCtrl.appTheme.primary,
                            content: Text(appFonts.validUrl.tr,
                                style: AppCss.outfitMedium16
                                    .textColor(appCtrl.appTheme.white))));
                      } else if (!(regExp.hasMatch(dash.searchCtrl.text))) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: appCtrl.appTheme.primary,
                            content: Text(appFonts.validUrl.tr,
                                style: AppCss.outfitMedium16
                                    .textColor(appCtrl.appTheme.white))));
                      } else if (!dash.searchCtrl.text.contains("www.")) {
                        String? wwwUrl;
                        if (dash.searchCtrl.text.contains("https://")) {
                          wwwUrl =
                          "https://www.${dash.searchCtrl.text.replaceAll("https://", "")}";
                        } else {
                          wwwUrl = "https://www.${dash.searchCtrl.text}";
                        }

                        Get.toNamed(routeName.webView, arguments: {"URL": wwwUrl})!
                            .then((value) {
                          dash.searchCtrl.text = "";
                          dash.update();
                        });
                      } else {
                        Get.toNamed(routeName.webView,
                            arguments: {"URL": dash.searchCtrl.text})!
                            .then((value) {
                          dash.searchCtrl.text = "";
                          dash.update();
                        });
                      }
                    })
                  ],
                ),
              )
            ],
          )
          );
    });
  }
}
