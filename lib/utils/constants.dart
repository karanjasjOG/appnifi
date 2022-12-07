import 'package:package_info/package_info.dart';

import 'app_configuration.dart';
// import 'package:woocommerce/woocommerce.dart';
import 'package:flutter/material.dart';

class Constants {
  static const String placeHolderUrl =
      "https://via.placeholder.com/100x100.png?text=!!!";
  static const String noImageUrl = 'noImageUrl';
  static const String noNavUrl = 'noNavUrl';

  static final Constants _constants = Constants._internal();

  static AppConfiguration appConfig;
  static PackageInfo packageInfo;
  // static DefaultColors defaultColors;
  // static WooCommerce wooCommerce;
  static String webViewUserAgent;
  static Map<String, String> cookiesMap;
  static String cookies;
  factory Constants() {
    return _constants;
  }
  Constants._internal();

  static String getCookieByKey(
      {@required String key, bool refreshList = true}) {
    if (Constants.cookies != null) {
      // Constants.cookies.splitMapJoin(pattern,)
      if (Constants.cookiesMap == null || refreshList) {
        List<String> cl = cookies.split(';');
        for (String item in cl) {
          String key = item.substring(0, item.indexOf('=')).trim();
          String val =
              item.substring(item.indexOf('=') + 1, item.length).trim();
          Constants.cookiesMap[key] = val;
        }
      }
      return Constants.cookiesMap['key'];
    }
  }
}

class DefaultColors {
  static const String appBarColor = '#29C8FF';
  static const String statusBarColor = '#29C8FF';
  static const String sectionBgColor = '#FFFFFF';
  static const String sectionHeadingFontColor = '#000000';
  static const String sectionButtonColor = '#29C8FF';
  static const String sectionButtonFontColor = '#FFFFFF';
  static const cardTitleFontColor = '#80A4A8';
  static const cardSubtitleFontColor = '#80A4A8';
  static const cardPriceFontColor = '#80A4A8';
  static const circularCardTitleFontColor = '#000000';

  static const appBgColor = '#FFFFFF';

  static double badgeFontSize = 9;
  static Color badgeColor = Colors.red;
  static Color badgeFontColor = Colors.white;

  static Object parseColor(String hex) {
    return int.tryParse('0x' + 'FF' + hex.substring(1).toUpperCase());
  }
}
