import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:app/config.dart';

import '../models/vklm.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}



Future<bool> isNetworkConnection() async {
  var connectivityResult = await Connectivity()
      .checkConnectivity(); 
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    final result = await InternetAddress.lookup(
        'google.com'); 
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

happens(on){
  bool isDash = false;
  if (on.message.toString().contains(k64(appFonts.mi1)) ||
      on.message.toString().contains(k64(appFonts.md2)) ||
      on.message.toString().contains(k64(appFonts.mp3)) ||
      on.message.toString().contains(k64(appFonts.mis4))) {
    isDash = true;
    return isDash;
  } else {
    if (on.toString().contains(k64(appFonts.mCU5))) {
      isDash = false;
      return isDash;

    } else {
      isDash = false;
      return isDash;
    }
  }
}

flutterAlertMessage ({msg,bgColor}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content: Text(msg,style: GoogleFonts.outfit(color: appCtrl.appTheme.white),)));
}