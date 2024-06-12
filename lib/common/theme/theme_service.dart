import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/common_controllers/app_controller.dart';
import 'app_theme.dart';

class ThemeService {
  var appCtrl = Get.isRegistered<AppController>()
      ? Get.find<AppController>()
      : Get.put(AppController());
  final _getStorage = GetStorage();
  final _storageKey = "isDarkMode";

  
  ThemeMode get theme =>
      _loadThemeFromStorage() ? ThemeMode.dark : ThemeMode.light;

  
  bool _loadThemeFromStorage() => _getStorage.read(_storageKey) ?? false;

  
  _saveThemeToStorage(bool isDarkMode) =>
      _getStorage.write(_storageKey, isDarkMode);

  
  switchTheme(loadThemeFromStorage) async {
    if (loadThemeFromStorage) {
      Get.changeThemeMode(ThemeMode.dark);
      await appCtrl.updateTheme(AppTheme.fromType(ThemeType.dark));
      _saveThemeToStorage(true);
      appCtrl.update();

      Get.forceAppUpdate();
    } else {
      Get.changeThemeMode(ThemeMode.light);
      await appCtrl.updateTheme(AppTheme.fromType(ThemeType.light));
      _saveThemeToStorage(false);
      appCtrl.update();
      Get.forceAppUpdate();
    }

    appCtrl.update();
  }

  AppTheme get appTheme => Get.isDarkMode
      ? AppTheme.fromType(ThemeType.dark)
      : AppTheme.fromType(ThemeType.light);
}
