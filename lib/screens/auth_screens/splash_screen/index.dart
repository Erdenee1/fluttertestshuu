
import '../../../config.dart';

class SplashScreen extends StatelessWidget {
  final splashCtrl = Get.put(SplashController());

  final DocumentSnapshot<Map<String, dynamic>>? rm, uc;

  SplashScreen({super.key, required this.rm, required this.uc});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (_) {
      splashCtrl.rm = rm;
      splashCtrl.uc = uc;
      splashCtrl.update();

      return Scaffold(
          body: uc != null ? Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                hexStringToColor(rm!.data()!["firstColor"]),
                hexStringToColor(rm!.data()!["secondColor"]),
              ], begin: const Alignment(14, 3), end: const Alignment(-2, -2))),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  rm!.data()!["splashLogo"] != null
                      ? Image.network(rm!.data()!["splashLogo"],
                          height: double.parse(rm!.data()!["splashLogoHeight"]),
                          width: double.parse(rm!.data()!["splashLogoWeight"]))
                      : Image.asset(eImageAssets.logo,
                          height: Insets.i120, width: Insets.i120),
                  rm!.data()!['splashTitleVisible']
                      ? Text(rm!.data()!['splashTitle'])
                          .textColor(hexStringToColor(rm!.data()!["splashTitleColor"]))
                          .fontSize(FontSizes.f18)
                      : Container()
                ],
              )) :Image.asset(eImageAssets.logo));
    });
  }
}
