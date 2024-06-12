import 'package:app/routes/route_name.dart';
import 'package:app/screens/other_screens/about_us/index.dart';
import 'package:app/screens/other_screens/dashboard/dashboard.dart';
import 'package:app/screens/other_screens/html_page.dart';
import 'package:app/screens/other_screens/language.dart';
import 'package:app/screens/other_screens/notification/index.dart';
import 'package:app/screens/other_screens/web_view.dart';

import '../config.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.dashboard, page: () => Dashboard()),
    GetPage(name: _routeName.webView, page: () => const WebViewPage()),
    GetPage(name: _routeName.htmlPage, page: () => const HtmlPage()),
    GetPage(name: _routeName.aboutUs, page: () => const AboutUs()),
    GetPage(name: _routeName.languageScreen, page: () => SelectLanguageScreen()),
    GetPage(name: _routeName.internet, page: () => SelectLanguageScreen()),
    GetPage(name: _routeName.notification, page: () => const NotificationList()),
  ];
}
