import 'package:flutter/material.dart';
import 'package:storematic_flutter/theme/my_theme.dart';
import 'package:storematic_flutter/utils/app_configuration.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/global_state_controller.dart';
import 'package:storematic_flutter/utils/my_routes.dart';
import 'package:storematic_flutter/view/pages/my_webpage.dart';

class MyBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: GlobalStateController.state.cartValue,
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () {
              MyRoutes.pushWebPage(context: context, path: 'cart');
              // new Webpage(title: 'Cart', url: '')
            },
            child: Container(
              width: 24,
              height: 24,
              // color: Colors.black,
              child: new Stack(
                clipBehavior: Clip.none,
                // overflow: Overflow.visible,
                children: <Widget>[
                  new Icon(
                    Icons.shopping_cart, // Shopping Cart
                  ),
                  new Positioned(
                    // height: 24,
                    // width: 24,
                    right: -7,
                    top: -7,
                    child: new Container(
                      height: 12,
                      // Badge
                      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                      decoration: new BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                        color: DefaultColors.badgeColor,
                        // borderRadius: BorderRadius.circular(10),
                      ),
                      // constraints: BoxConstraints(
                      //   minWidth: 14,
                      //   minHeight: 14,
                      // ),
                      child: new Text(
                        // '100',
                        value.toString(),
                        // widget.numberOfItemsInCart.toString(),
                        // textDirection: TextDirection.rtl,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: DefaultColors.badgeFontColor,
                          fontSize: DefaultColors.badgeFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
