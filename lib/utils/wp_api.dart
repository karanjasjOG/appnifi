import 'package:storematic_flutter/utils/constants.dart';

class WpApi {
  static const String _searchFieldDefault = "search";
  static const String wpApiEndpoint = "wp-json/wp/v2";
  static const String _fieldsDefault = "id,title,link,_links,_embedded";
  static const int _perPage = 5;
  // String searchProductApi = 'https://www.deczo.com/wp-json/wp/v2/product?search=&per_page=5&_fields=id,title,link,_links,_embedded&_embed';
  static String getApi(String baseUrl, String endpoint,
      {String search = "",
      String searchField = _searchFieldDefault,
      String fields = _fieldsDefault,
      int perPage = _perPage,
      bool w2a = false}) {
    if (w2a) {
      return baseUrl == null ? "" : "$baseUrl$wpApiEndpoint$endpoint";
    }
    return baseUrl == null
        ? ""
        : "$baseUrl$wpApiEndpoint$endpoint?$searchField=$search&per_page=$perPage&_fields=$fields&_embed";
  }
}
