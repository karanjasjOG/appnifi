import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:storematic_flutter/utils/constants.dart';

import 'package:storematic_flutter/utils/my_routes.dart';
import 'package:storematic_flutter/view/pages/error_page.dart';
import 'package:storematic_flutter/view/pages/my_about.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> customDrawerItems = [];
    double screenWidth = MediaQuery.of(context).size.width;

    double drawerWidth =
        screenWidth * Constants.appConfig.appTheme.drawerWidthFactor;

    if (Constants.appConfig.hasCustomDrawerItems) {
      Constants.appConfig.drawerItems.forEach((element) {
        defaultDrawerItems
            .add(DrawerTile(title: element.title, navUrl: element.navUrl));
      });
    }
    var drawerItems = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(mainAxisSize: MainAxisSize.min, children: [
          SafeArea(
            child: DrawerTile(
              icon: Icons.home,
              title: "Home",
              navUrl: null,
              disableNav: true,
              tileBgColor: Constants.appConfig.appTheme.appBarColorParsed,
              textColor: Colors.white,
            ),
          ),
          ListView(
            shrinkWrap: true,
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: Constants.appConfig.hasCustomDrawerItems
                ? customDrawerItems
                : defaultDrawerItems,
          ),
        ]),
        Visibility(
          visible: false,
          child: Container(
            margin: EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border:
                              Border(top: BorderSide(color: Colors.black12))),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(Icons.settings, color: Colors.black45),
                      )),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      MyAbout.dialog(context: context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border(
                              top: BorderSide(color: Colors.black12),
                              left: BorderSide(color: Colors.black12),
                              // right: BorderSide(color: Colors.black38)
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.info,
                            color: Colors.black45,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );

    return Container(
      color: Colors.white,
      width: drawerWidth,
      child: Drawer(
        child: drawerItems,
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  // final double drawerWidth;

  final IconData icon;
  final String title;
  final String navUrl;
  final bool showBottomBorder;
  final Color textColor;
  final Color tileBgColor;
  final bool isWebpage;
  final bool isDialog;
  final ScreenPath screenPath;
  final bool disableNav;
  DrawerTile(
      {this.icon,
      @required this.title,
      @required this.navUrl,
      this.showBottomBorder = false,
      this.textColor = Colors.black54,
      this.tileBgColor = Colors.white,
      this.isWebpage = true,
      this.isDialog = false,
      this.disableNav = false,
      this.screenPath});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tileBgColor,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop(); // hiding navigation drawer on item tap

          if (disableNav) {
            // if true do nothing
            return;
          }
          if (navUrl != null && isWebpage) {
            String pathUrl = Constants.appConfig.baseUrl + navUrl;
            MyRoutes.pushWebPage(
                context: context,
                path: 'misc',
                isMisc: true,
                pathUrl: pathUrl,
                title: title);
          } else if (!isWebpage && screenPath != null) {
            MyRoutes.pushScreen(
                path: screenPath, context: context, isDialog: isDialog);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ErrorPage(errorMessage: 'Error')),
            );
          }
        },
        child: Column(
          children: [
            icon == null
                ? ListTile(
                    title: AdaptiveText(
                      textAlign: TextAlign.start,
                      textColor: textColor,
                      text: title,
                      minFontSize: 15,
                      maxFontSize: 20,
                      // textAlign: TextAlign.start,
                    ),
                  )
                : ListTile(
                    leading: Icon(
                      icon,
                      color: textColor,
                    ),
                    title: AdaptiveText(
                      textAlign: TextAlign.start,
                      textColor: textColor,
                      text: title,
                      minFontSize: 15,
                      maxFontSize: 20,
                      // textAlign: TextAlign.start,
                    ),
                  ),
            Visibility(
              visible: showBottomBorder,
              child: Divider(
                height: 1,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> defaultDrawerItems = [
  DrawerTile(
    navUrl: null,
    icon: Icons.category_rounded,
    title: 'All Categories',
    isWebpage: false,
    screenPath: ScreenPath.ALL_CATS,
    showBottomBorder: true,
  ),
  DrawerTile(
      icon: Icons.account_circle,
      title: 'My Account',
      navUrl: Constants.appConfig.shopEndpoints.myAccount),
  DrawerTile(
      icon: Icons.shopping_bag_rounded,
      title: 'My Orders',
      navUrl: Constants.appConfig.shopEndpoints.myAccount),
  DrawerTile(
      icon: Icons.local_offer_rounded,
      title: 'My Coupons',
      navUrl: Constants.appConfig.shopEndpoints.myCoupons),
  DrawerTile(
    icon: Icons.shopping_cart_rounded,
    title: 'My Cart',
    navUrl: Constants.appConfig.shopEndpoints.cart,
    // showBottomBorder: true,
  ),
  DrawerTile(
    icon: Icons.favorite,
    title: 'My Wishlist',
    navUrl: Constants.appConfig.shopEndpoints.wishList,
    showBottomBorder: true,
  ),
  DrawerTile(
    icon: Icons.help_center,
    title: 'Help Center',
    navUrl: Constants.appConfig.shopEndpoints.helpCenter,
    isWebpage: true,
  ),
  DrawerTile(
    icon: Icons.info,
    title: 'About',
    navUrl: null,
    screenPath: ScreenPath.ABOUT_APP,
    isDialog: true,
    isWebpage: false,
    showBottomBorder: true,
  ),
];
