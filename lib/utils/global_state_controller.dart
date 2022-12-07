import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storematic_flutter/view/item_type/product_widget.dart';

enum PrefType { INT, STRING, BOOL }

class GlobalStateController {
  static final GlobalStateController state = new GlobalStateController();
  bool isAddToCartActive = true;
  ValueNotifier inLoading = ValueNotifier(false);
  HeadlessWebview headlessWebview;
  void setWebview(HeadlessWebview headlessWebview) {
    headlessWebview = headlessWebview;
  }

  void setAddToCart(bool addToCart) {
    isAddToCartActive = addToCart;
    inLoading.value = !addToCart;
  }

  void disposeWebview() {
    headlessWebview?.dispose();
  }

  ValueNotifier<int> cartValue = ValueNotifier(0);

  ValueNotifier<bool> homeReload = ValueNotifier(false);

  void setHomeData({@required bool value}) {
    homeReload.value = value;
  }

  void setCartValue({@required int value}) {
    cartValue.value = value;
    saveToPref(key: 'cart_value', value: value, type: PrefType.INT);
  }

  void saveToPref(
      {@required String key, @required var value, PrefType type}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    switch (type) {
      case PrefType.BOOL:
        pref.setBool(key, value);
        break;
      case PrefType.INT:
        pref.setInt(key, value);
        break;
      case PrefType.STRING:
      default:
        pref.setString(key, value.toString());
    }
  }

  void loadStateFromPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int cartVal = pref.getInt('cart_value');
    cartValue.value = cartVal ?? 0;
    // setCartValue(value: pref.getInt('cart_value'));
  }
}
