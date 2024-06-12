import '../config.dart';

class AppArray {

  var settingList = [
    {"title": "darkMode", "icon": svgAssets.moon},
    {"title": "rtl", "icon": svgAssets.rtl},
    {"title": "language", "icon": svgAssets.language},
    {"title": "aboutUs", "icon": svgAssets.about},
    {"title": "privacy", "icon": svgAssets.privacy},
    {"title": "terms", "icon": svgAssets.terms},
    {"title": "share", "icon": svgAssets.share},
    {"title": "rate", "icon": svgAssets.rate},
  ];


  var languagesList = [
    {
      "image": eImageAssets.english,
      "title": appFonts.english,
      'locale': const Locale('en', 'US'),
      "code": "en"
    },
    {
      "image": eImageAssets.mongolian,
      "title": appFonts.mongolia,
      'locale': const Locale('mn', 'MN'),
      "code": "mn"
    },
  ];


  var bottomList = [{
    "title": appFonts.search,
    "icon": svgAssets.searchLine,
    "darkIcon": svgAssets.search
  },
    {
      "title": appFonts.home,
      "icon": svgAssets.homeLine,
      "darkIcon": svgAssets.home
    },{
      "title": appFonts.settings,
      "icon": svgAssets.settingLine,
      "darkIcon": svgAssets.setting
    }];
}
