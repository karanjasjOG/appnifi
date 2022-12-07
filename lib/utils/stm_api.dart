import 'package:flutter/cupertino.dart';
import 'package:storematic_flutter/utils/wp_api.dart';

class StmApi {
  static const String baseUrl = "https://apps.storematic.in/";
  static const String auth_key = "storematic_akjas69";

  static String _getConfig({@required String packageName}) {
    return WpApi.getApi(baseUrl, '/app_control',
        search: packageName, // search value or What to Search
        searchField: "package_name", // search field \ key// LHS
        perPage: 1,
        fields:
            'id,modified,title,package_name,app_bar_color,status_bar_color,logo,link,_links,base_url');
  }

  static String getConfig({@required String packageName}) {
    return baseUrl +
        "wp-json/app_control/app?package_name=$packageName&auth_key=$auth_key";
  }
}

//https://storematic.co/wp-json/app_control/app?auth_key=storematic_akjas69&package_name=com.example.storematic_flutter
