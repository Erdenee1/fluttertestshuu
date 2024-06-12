import '../../config.dart';
import '../../models/select_language_model.dart';

class SelectLanguageController extends GetxController {
  List selectLanguageLists = [];
  int selectIndex = 0;
  bool isBack = false;
  SelectLanguageModel? data;

  onLanguageChange(index) {
    selectIndex = index;
    update();
  }

  onContinue() async {
    if (data!.code == "en") {
      appCtrl.languageVal = "en";
    } else if (data!.code == "mn") {
      appCtrl.languageVal = "mn";
    } 

    appCtrl.languageVal  = data!.code!;
    appCtrl.update();
    await appCtrl.storage
        .write("index", selectIndex);
    await appCtrl.storage
        .write("locale", data!.code);

    update();
    appCtrl.update();
    Get.updateLocale(data!.locale!);
    Get.forceAppUpdate();
  }

  @override
  void onReady() async {

    var index = await appCtrl.storage.read("index") ?? 0;
    selectIndex = index;
    selectLanguageLists = appArray.languagesList
        .map((e) => SelectLanguageModel.fromJson(e))
        .toList();
    update();

    data = selectLanguageLists[selectIndex];
    update();
    super.onReady();
  }

  onLanguageSelectTap(index,SelectLanguageModel lan)async{
    selectIndex =index;
    data =lan;
    update();
  }
}
