import 'package:get/get.dart';
import 'package:app/controllers/other_controller/ad_controller.dart';

export 'package:get/get.dart';
export 'package:get_storage/get_storage.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:app/common/extension/text_extension.dart';
export 'package:get/route_manager.dart';
export '../../models/vklm.dart';
export '../../utils/extensions.dart';
export 'package:app/controllers/auth_controller/splash_controller.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:flutter/material.dart';
import 'common/app_array.dart';
import 'common/app_fonts.dart';
export 'package:flutter/services.dart';

export '../routes/index.dart';
export '../routes/screen_list.dart';

export '../common/extension/text_style_extensions.dart';
export '../common/extension/widget_extension.dart';
export '../common/assets/index.dart';
export '../common/theme/app_css.dart';
export '../common/extension/spacing.dart';
export '../common/theme/theme_service.dart';
export '../package_list.dart';

export '../common/languages/index.dart';
export '../common/theme/app_theme.dart';
import '../controllers/common_controllers/app_controller.dart';
import 'common/session.dart';
export '../controllers/index.dart';

export 'package:app/screens/auth_screens/onBoarding_screen/onboard_1.dart';
export 'package:app/screens/auth_screens/onBoarding_screen/onboard_3.dart';
export 'package:app/screens/auth_screens/onBoarding_screen/onboard_2.dart';
export 'package:app/screens/auth_screens/onBoarding_screen/layouts/page_view_common.dart';
export 'package:app/screens/auth_screens/onBoarding_screen/layouts/bottom_layout.dart';
export 'package:app/screens/auth_screens/onBoarding_screen/layouts/bottom_layout_2.dart';
export 'package:app/screens/auth_screens/onBoarding_screen/layouts/bottom_layout_3.dart';
export 'package:app/screens/other_screens/home_screens/index.dart';
export 'package:app/screens/other_screens/search_screens/index.dart';
export 'package:app/screens/other_screens/search_screens/layouts/check_this_out.dart';

final appCtrl = Get.isRegistered<AppController>()
    ? Get.find<AppController>()
    : Get.put(AppController());

final addCtrl = Get.isRegistered<AdController>()
    ? Get.find<AdController>()
    : Get.put(AdController());

AppFonts appFonts = AppFonts();
AppArray appArray = AppArray();

Session session = Session();
