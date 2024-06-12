
import '../../../config.dart';

class AppBarTitle extends StatelessWidget {
  final String? appName,logo;
  final int? index;
  const AppBarTitle({super.key, this.appName, this.logo, this.index});

  @override
  Widget build(BuildContext context) {
    return  Text(index == 0
        ? appFonts.search.tr
        : index == 1
        ? appFonts.home.tr
        : appFonts.settings.tr)
        .textColor(appCtrl.appTheme.black)
        .fontSize(FontSizes.f20)
        .fontWeight(FontWeight.w600).fontFamily(GoogleFonts.readexPro().fontFamily!).marginSymmetric(horizontal: Insets.i10);
  }
}
