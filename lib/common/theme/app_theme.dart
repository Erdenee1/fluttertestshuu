import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/package_list.dart';

import '../../utils/extensions.dart';

enum ThemeType {
  light,
  dark,
}

StreamSubscription? messageSub;
Color? selectedThemeColor,selectedGradientColor1,selectedGradientColor2;
bool isGradient =false;

getData()async{



  FirebaseFirestore.instance.collection("themeColor").get().then((value) {
    if (value.docs.isNotEmpty) {
      selectedThemeColor = hexStringToColor(value.docs[0].data()["selectedThemeColor"]);
      selectedGradientColor1 = hexStringToColor(value.docs[0].data()["selectedGradientColor1"]);
      selectedGradientColor2 = hexStringToColor(value.docs[0].data()["selectedGradientColor2"]);
      if(value.docs[0].data()["customGradientColorVisible"] || value.docs[0].data()["gradientColorVisible"]) {
        isGradient = true;
        Get.forceAppUpdate();
      }else{
      isGradient = false;
      Get.forceAppUpdate();
      }
    }
  });

}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;



  bool isDark;
  Color primary;
  Color secondary;
  Color backgroudColor;
  Color gray;
  Color darkGray;
  Color lightGray;
  Color moreLightGray;
  Color onBoardingColor;
  Color onBoardingColorOpacity;
  Color white;
  Color black;
  Color gradient1,gradient2;


  AppTheme({
    required this.isDark,
    required this.primary,
    required this.secondary,
    required this.backgroudColor,
    required this.gray,
    required this.darkGray,
    required this.lightGray,
    required this.moreLightGray,
    required this.onBoardingColor,
    required this.onBoardingColorOpacity,
    required this.white,
    required this.black,
    required this.gradient1,
    required this.gradient2,
  });


  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:

        return AppTheme(
          isDark: false,
          primary: selectedThemeColor ?? const Color(0xff35C1FF),
          secondary: const Color(0xFF6EBAE7),
          backgroudColor: const Color(0xFFFAFAFC),
          gray: const Color(0xFF8A95A4),
          darkGray: const Color(0xFF272740),
          lightGray: const Color(0xFFA7A6A7),
          moreLightGray: const Color(0xFFEEEEEE),
          onBoardingColor: const Color(0xFF7D6CF5),
          onBoardingColorOpacity: const Color.fromARGB(255, 207, 204, 240),
          white: Colors.white,
          black: Colors.black,
          gradient1: selectedGradientColor1 ?? const Color(0xff35C1FF),
          gradient2: selectedGradientColor2 ?? const Color(0xff35C1FF),
        );

      case ThemeType.dark:
        return AppTheme(
          isDark: true,
          primary:selectedThemeColor ?? const Color(0xff35C1FF),
          secondary: const Color(0xFF6EBAE7),
          backgroudColor: const Color(0xFF110F25),
          gray: const Color(0xFF8A95A4),
          darkGray: const Color(0xFF272740),
          lightGray: const Color(0xFFA7A6A7),
          moreLightGray: const Color(0xFFEEEEEE),
          onBoardingColor: const Color(0xFF7D6CF5),
          onBoardingColorOpacity: const Color.fromARGB(255, 207, 204, 240),
          white: Colors.black,
          black: Colors.white,
          gradient1: selectedGradientColor1 ?? const Color(0xff35C1FF),
          gradient2: selectedGradientColor2 ?? const Color(0xff35C1FF),
        );
    }
  }

  ThemeData get themeData {
    var t = ThemeData.from(
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primary,
        secondary: secondary,
        background: secondary,
        surface: secondary,
        onBackground: secondary,
        onSurface: secondary,
        onError: secondary,
        onPrimary: secondary,
        onSecondary: secondary,
        error: secondary,surfaceTint: white
      ),
    );
    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.transparent, cursorColor: primary),
      buttonTheme: ButtonThemeData(buttonColor: primary),
      highlightColor: primary,
    );
  }
}
