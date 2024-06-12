import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:app/screens/other_screens/home_screens/home_body.dart';
import 'package:app/widgets/common_loader.dart';
import '../../../config.dart';

class HomeScreen extends StatelessWidget {
  final homeScreenCtrl = Get.put(HomeScreenController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (homeScreenCtrl) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: appCtrl.appTheme.white
        ),
        child: SafeArea(

          child:  Scaffold(
              backgroundColor: appCtrl.appTheme.backgroudColor,

              body:CustomMaterialIndicator(withRotation: false,
                onRefresh: () async{
                  return await homeScreenCtrl.getRefresh();
                },indicatorBuilder: (BuildContext context, IndicatorController controller) {
                  return const CommonLoader();
                },
                child: const HomeBody(),
              ))
        ),
      );
    });
  }
}
