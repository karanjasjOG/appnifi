import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:storematic_flutter/models/drawer_item.dart';
import 'package:storematic_flutter/utils/global_state_controller.dart';
// import 'package:woocommerce/woocommerce.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/stm_api.dart';
import 'package:storematic_flutter/controller/data_controller.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:storematic_flutter/utils/json_keys.dart';

import 'package:storematic_flutter/theme/my_theme.dart';

// class NativePages {
//   static const String allCategories = 'all_categories';
// }

// class DrawerItem {
//   final String iconUrl;
//   final String title;
//   final bool isWebpage;
//   final String navUrl;
//   final String nativePage;

//   const DrawerItem._(
//       {this.iconUrl,
//       @required this.isWebpage,
//       this.nativePage,
//       this.navUrl,
//       this.title});

//   factory DrawerItem(Map json) {
//     RegExp appnifi = RegExp(r'appnifi://');
//     String link = json['link'];
//     Match match = appnifi.matchAsPrefix(link);

//     bool isWebPage = match == null ? true : false;
//     String nativePage = isWebPage
//         ? null
//         : DataControllerHelperFunctions.nullSafety(
//             ConfigJsonKeys.isWebPage, json, NativePages.allCategories);
//     if (isWebPage) {
//       return DrawerItem._(
//           isWebpage: isWebPage,
//           iconUrl: DataControllerHelperFunctions.nullSafety(
//               ConfigJsonKeys.iconUrl, json, Constants.noImageUrl),
//           navUrl: DataControllerHelperFunctions.nullSafety(
//               ConfigJsonKeys.navUrl, json, Constants.noNavUrl),
//           title: DataControllerHelperFunctions.nullSafety(
//               ConfigJsonKeys.title, json, 'Home'));
//     } else {
//       return DrawerItem._(isWebpage: isWebPage, nativePage: nativePage);
//     }
//   }
// }

class AppConfiguration {
  final String baseUrl;
  final String packageName;
  final String authKey;
  final String title;
  final String searchQuery;
  final ShopEndpoints shopEndpoints;
  final String currencySymbol;
  final String aboutShop, poweredBy, poweredByLink;
  final bool showAppBarLogo;
  final bool showViewCartStrip;
  final bool showCarticon;
  final String appBarLogoUrl;
  final List<DrawerItem> drawerItems;
  // final List<DrawerItem> bottomItems;
  final bool showBottomCartIcon;
  final bool hasBottomNavigation;
  final bool hasCustomDrawerItems;
  final AppTheme appTheme;

  const AppConfiguration(
      {@required this.baseUrl,
      @required this.packageName,
      @required this.authKey,
      @required this.title,
      @required this.searchQuery,
      @required this.hasCustomDrawerItems,
      this.drawerItems,
      @required this.appTheme,
      @required this.showAppBarLogo,
      @required this.appBarLogoUrl,
      this.shopEndpoints,
      this.aboutShop,
      this.poweredBy,
      this.poweredByLink,
      @required this.currencySymbol,
      @required this.showViewCartStrip,
      @required this.showCarticon,
      this.hasBottomNavigation,
      this.showBottomCartIcon});

  factory AppConfiguration.fromJson(Map json) {
    var configJson = json;
    List navigationDrawer = configJson['navigation_drawer'];

    // List<DrawerItem> bottomNavigationItems = [];
    List<DrawerItem> drawerItems = [];

    bool hasCustomDrawerItems = DataControllerHelperFunctions.nullSafety(
        ConfigJsonKeys.hasCustomDrawerItems, configJson, false);
    bool hasBottomNavigation = DataControllerHelperFunctions.nullSafety(
        ConfigJsonKeys.hasBottomNavigation, configJson, false);

    if (hasCustomDrawerItems) {
      navigationDrawer.forEach((element) {
        drawerItems.add(DrawerItem(element));
      });
    }

    // print('error ${configJson.runtimeType}');
    AppConfiguration appConfig = AppConfiguration(
        showBottomCartIcon: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.showBottomCartIcon, configJson, false),
        hasBottomNavigation: hasBottomNavigation,
        // bottomItems: bottomNavigationItems,
        appBarLogoUrl: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.appBarLogoUrlKey, configJson, Constants.noImageUrl),
        aboutShop: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.aboutShop, configJson, ''),
        poweredBy: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.poweredBy, configJson, ''),
        poweredByLink: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.poweredByLink, configJson, ''),
        currencySymbol: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.currencyKey, configJson, '₹'),
        baseUrl: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.baseUrlKey, configJson, ''),
        title: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.titleKey, configJson, 'Appnifi'),
        searchQuery: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.searchQueryPlaceholderKey,
            configJson,
            'Search for Products, Brands and More'),
        packageName: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.packageNameKey, configJson, ''),
        authKey: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.authKey, configJson, ''),
        shopEndpoints:
            ShopEndpoints.fromJson(json: configJson[ConfigJsonKeys.endpoints]),
        showAppBarLogo: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.showAppBarLogoKey, configJson, false),
        showViewCartStrip: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.showViewCartStripKey, configJson, false),
        showCarticon: DataControllerHelperFunctions.nullSafety(
            ConfigJsonKeys.showCartIcon, configJson, true),
        hasCustomDrawerItems: hasCustomDrawerItems,
        drawerItems: drawerItems,
        appTheme: AppTheme(
          statusBarColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.statusBarColorKey,
              configJson,
              DefaultColors.statusBarColor),
          appBarColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.appBarColorKey,
              configJson,
              DefaultColors.appBarColor),
          sectionBgColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.sectionBgColorKey,
              configJson,
              DefaultColors.sectionBgColor),
          sectionHeadingFontColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.sectionHeadingFontColorKey,
              configJson,
              DefaultColors.sectionHeadingFontColor),
          sectionButtonColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.sectionButtonColorKey,
              configJson,
              DataControllerHelperFunctions.nullSafety(
                  ConfigJsonKeys.appBarColorKey,
                  configJson,
                  DefaultColors.appBarColor)),
          sectionButtonFontColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.sectionButtonFontColorKey,
              configJson,
              DefaultColors.sectionButtonFontColor),
          cardTitleFontColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.cardTitleFontColorKey,
              configJson,
              DefaultColors.cardTitleFontColor),
          cardSubtitleFontColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.cardSubtitleFontColorKey,
              configJson,
              DefaultColors.cardSubtitleFontColor),
          cardPriceFontColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.cardPriceFontColorKey,
              configJson,
              DefaultColors.cardPriceFontColor),
          circularCardTitleFontColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.circularCardTitleFontColorKey,
              configJson,
              DefaultColors.circularCardTitleFontColor),
          appBgColor: DataControllerHelperFunctions.nullSafety(
              ConfigJsonKeys.appBgColor, configJson, DefaultColors.appBgColor),
        ));
    return appConfig;
  }
}

Future<AppConfiguration> fetchAppConfiguration(
    {@required demo, String baseUrl}) async {
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  AppConfiguration appConfiguration;
  /* first check if its first and contains baseUrl otherwsie fetch from server */
  if (demo) {
    appConfiguration = AppConfiguration(
        hasBottomNavigation: false,
        baseUrl: baseUrl,
        packageName: 'packageName',
        authKey: 'storematic_jasak',
        title: 'Appnifi',
        searchQuery: 'Search for products and more.',
        hasCustomDrawerItems: false,
        appTheme: AppTheme(),
        showAppBarLogo: false,
        appBarLogoUrl: 'appBarLogoUrl',
        currencySymbol: 'currencySymbol',
        showViewCartStrip: false,
        showCarticon: true);
  } else {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // print(packageInfo.packageName);
    final api = StmApi.getConfig(packageName: packageInfo.packageName);
    final response = await http.get(api);
    // print(api);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      appConfiguration = AppConfiguration.fromJson(jsonDecode(response.body));
      // saveConfig(appConfiguration);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load app configuration');
    }
    // await Future.delayed(Duration(seconds: 5));
  }
  initConstants(appConfiguration);
  return appConfiguration;
}

void initConstants(AppConfiguration appConfiguration) async {
  Constants.appConfig = appConfiguration;
  // await loadWoocommerceSecret(context);
  await loadWebViewUserAgent();
  GlobalStateController.state.loadStateFromPref();
  Constants.packageInfo = await PackageInfo.fromPlatform();
  // print(appConfiguration.shopEndpoints.cart);
  // Constants.baseUrl = baseUrl;
}

Future<void> loadWebViewUserAgent() async {
  try {
    await FlutterUserAgent.getPropertyAsync('userAgent');
    await FlutterUserAgent.init();
    Constants.webViewUserAgent =
        FlutterUserAgent.webViewUserAgent + " storematic";
  } on PlatformException {
    Constants.webViewUserAgent =
        "Mozilla/5.0 (Linux; Android 5.1.1; Android SDK built for x86 Build/LMY48X) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36 storematic";
  }
}

class ShopEndpoints {
  final String shop; // main shop page
  final String cart;
  final String checkout;
  final String myAccount; // login/registration page
  final String wishList; // TODO: init this from network
  final String myCoupons; // TODO: init this from network
  final String helpCenter;
  ShopEndpoints({
    @required this.shop,
    @required this.cart,
    @required this.checkout,
    @required this.myAccount,
    this.myCoupons,
    this.wishList,
    this.helpCenter,
  });
  factory ShopEndpoints.fromJson({@required dynamic json}) {
    return ShopEndpoints(
      shop: json['shop'],
      cart: json['cart'],
      checkout: json['checkout'],
      myAccount: json['my_account'],
      myCoupons: json['my_coupons'],
      wishList: json['wishlist'],
      helpCenter: json['help_center'],
    );
  }
  factory ShopEndpoints.fromPref({@required SharedPreferences pref}) {
    dynamic json = jsonDecode(pref.getString(ConfigJsonKeys.endpoints));
    return ShopEndpoints.fromJson(json: json);
  }
  String toJson() {
    return jsonEncode({
      'shop': shop,
      'cart': cart,
      'checkout': checkout,
      'my_account': myAccount,
      'wishlist': wishList,
      'my_coupons': myCoupons,
      'help_center': helpCenter
    });
  }
}
