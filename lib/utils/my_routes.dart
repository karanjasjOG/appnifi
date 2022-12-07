import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/pages/my_about.dart';
import 'package:storematic_flutter/view/pages/my_category_page.dart';
import 'package:storematic_flutter/view/pages/my_webpage.dart';

enum ScreenPath { ALL_CATS, ABOUT_APP }

class MyRoutes {
  static void pushWebPage({
    @required BuildContext context,
    @required String path,
    bool isCart = false,
    bool isCheckout = false,
    bool isMisc = false,
    String pathUrl = "",
    bool hideCartIcon = false,
    String title = '',
  }) {
    var pathMap = {
      'cart': {'title': 'Cart', 'url': 'cart', 'hideCartIcon': true},
      'checkout': {
        'title': 'Checkout',
        'url': 'checkout',
        'hideCartIcon': true
      },
      'misc': {'title': title, 'url': pathUrl, 'hideCartIcon': hideCartIcon}
    };
    path = isMisc ? 'misc' : path;
    if (pathUrl.endsWith('cart/')) {
      path = 'cart';
    } else if (pathUrl.endsWith('checkout/')) {
      path = 'checkout';
    }
    pathUrl = pathUrl == ""
        ? Constants.appConfig.baseUrl + pathMap[path]['url']
        : pathUrl;
    // print('pathUrl:${pathUrl}');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Webpage(
            title: pathMap[path]['title'],
            url: pathUrl,
            hideCartIcon: pathMap[path]['hideCartIcon'],
          ),
        ));
  }

  static void pushScreen(
      {@required ScreenPath path,
      @required BuildContext context,
      bool isDialog = false}) {
    Widget widget;
    switch (path) {
      case ScreenPath.ALL_CATS:
        widget = MyCategoryPage();
        break;
      case ScreenPath.ABOUT_APP:
        MyAbout.dialog(context: context);
    }
    if (!isDialog) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    }
  }
}
