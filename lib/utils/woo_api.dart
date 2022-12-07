import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/wp_api.dart';

class WooApi {
  static String homePage() {
    String api = getW2a(parameter: 'sections');
    if (api != null) {
      return api;
    } else
      return null;
  }

  static String allCategoryPage() {
    String api = getW2a(parameter: 'categories');
    if (api != null) {
      return api;
    } else
      return null;
  }

  static String searchProducts({@required String search}) {
    String api = getW2a(parameter: 'search');
    if (api != null) {
      api = api + '&name=$search';
      return api;
    } else
      return null;
  }

  static String getW2a({@required String parameter}) {
    // website2App api
    // String parameter = isCategoryPage ? 'categories' : 'sections';
    String endpoint = 'wp-json/website2app/$parameter?auth_key=';
    if (Constants.appConfig != null) {
      return Constants.appConfig.baseUrl +
          endpoint +
          Constants.appConfig.authKey;
    }
    return null;
  }

  /**
   * Function getCart()
   * Not required
   */
  static Future<int> getCartValue() {
    String api =
        Constants.appConfig.baseUrl + "/?wc-ajax=get_refreshed_fragments";
  }
  /* static List<String> getCategories(){
    Constants.wooCommerce.getProductCategories(hideEmpty: true,)
  } */
}
