
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);
  int numRewardedLoadAttempts = 0;
  AdRequest request = const AdRequest(
    keywords: <String>['localhost', 'bar'],
    contentUrl: 'http://localhost.com/bar.html',
    nonPersonalizedAds: true,
  );
  AppTheme get appTheme => _appTheme;
  String priceSymbol = "\$";
  bool isTheme = false;
  bool isRTL = false;
  bool isLanguage = false;
  bool isSubscribe = false, isLocalChatApi = false;
  bool isRewardedAdLoaded = false;
  bool isAnySubscribe = false;
  bool isCharacter = false;
  bool isBiometric = false;
  bool isLogin = false;
  bool isChatting = false;
  bool isUserThemeChange = false;
  bool isUserTheme = false;
  bool isUserRTLChange = false;
  bool isUserRTL = false,isLoading=false;
  String languageVal = "en",headerTitlePosition="",shareContentTitle="",baseUrl="",loaderStyle="";
  Color? color;
  dynamic selectedCharacter;
  final storage = GetStorage();
  bool isSwitched = false;
  bool isOnboard = false;
  bool isGuestLogin = false;
  bool isNumber = false,isAppBar = true,isBottomNav=true;
  dynamic currency;
  dynamic envConfig;
  dynamic rightIcon,leftIcon;
  int characterIndex = 3;

  List checkoutList =[],socialLink =[];


  updateTheme(theme) {
    _appTheme = theme;
    Get.forceAppUpdate();
  }

  @override
  void dispose() {

    super.dispose();
  }
}
