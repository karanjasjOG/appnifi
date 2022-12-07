import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:storematic_flutter/utils/global_state_controller.dart';
import 'package:storematic_flutter/view/app_bar/my_badge.dart';
import 'package:storematic_flutter/view/app_bar/app_bar_bottom.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/pages/my_search_page.dart';

class AppBarTop extends StatelessWidget {
  final String searchQeury;
  final String title;
  final int numberOfItemInCart;
  final double appBarHeight;
  AppBarTop(
      {@required this.title,
      @required this.numberOfItemInCart,
      @required this.searchQeury,
      @required this.appBarHeight});
  @override
  Widget build(BuildContext context) {
    return Constants.appConfig.showCarticon
        ? AppBarWithCart(
            title: title,
            numberOfItemInCart: numberOfItemInCart,
            searchQeury: searchQeury,
            appBarHeight: appBarHeight)
        : AppBarWithoutCart(
            title: title,
            numberOfItemInCart: numberOfItemInCart,
            searchQeury: searchQeury,
            appBarHeight: appBarHeight);
  }
}

class AppBarWithCart extends StatelessWidget {
  final String searchQeury;
  final String title;
  final int numberOfItemInCart;
  final double appBarHeight;
  AppBarWithCart(
      {@required this.title,
      @required this.numberOfItemInCart,
      @required this.searchQeury,
      @required this.appBarHeight});
  @override
  Widget build(BuildContext context) {
    print(Constants.appConfig.appTheme.appBarColorParsed);
    return AppBar(
      iconTheme: IconThemeData(
          color: Constants.appConfig.appTheme
              .sectionButtonFontColorParsed), //Drawer icon color
      toolbarHeight: appBarHeight * 0.6,
      centerTitle: true,

      backgroundColor: Constants.appConfig.appTheme.appBarColorParsed,
      // toolbarHeight: appBarHeight * (0.1),
      title: Constants.appConfig.showAppBarLogo
          ? Container(
              height: appBarHeight * 0.6 -
                  10, //TODO fix this jugaad make your own custom appbar
              width: appBarHeight * 0.6 * 1.7 - 10,
              child: FittedBox(
                // alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CachedNetworkImage(
                      imageUrl: Constants.appConfig.appBarLogoUrl),
                ),
              ),
            )
          : FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(
                    color: Constants
                        .appConfig.appTheme.sectionButtonFontColorParsed),
              ),
            ),

      actions: <Widget>[
        // Actions
        IconButton(
          color: Constants.appConfig.appTheme.sectionButtonFontColorParsed,
          icon: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: MyBadge(
                // numberOfItemsInCart: numberOfItemInCart,
                ),
          ),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
          preferredSize: null,
          child: AppBarBottom(
            searchQuery: searchQeury,
            appBarHeight: appBarHeight,
          )),
    );
  }
}

class AppBarWithoutCart extends StatelessWidget {
  final String searchQeury;
  final String title;
  final int numberOfItemInCart;
  final double appBarHeight;
  AppBarWithoutCart(
      {@required this.title,
      @required this.numberOfItemInCart,
      @required this.searchQeury,
      @required this.appBarHeight});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
          color: Constants.appConfig.appTheme
              .sectionButtonFontColorParsed), //Drawer icon color
      toolbarHeight: 56,
      centerTitle: true,
      backgroundColor: Constants.appConfig.appTheme.appBarColorParsed,
      // toolbarHeight: appBarHeight * (0.1),
      title: Constants.appConfig.showAppBarLogo
          ? Container(
              height:
                  56.0 - 10, //TODO fix this jugaad make your own custom appbar
              width: 56 * 1.7 - 10,
              child: FittedBox(
                // alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CachedNetworkImage(
                      imageUrl: Constants.appConfig.appBarLogoUrl),
                ),
              ),
            )
          : FittedBox(
              fit: BoxFit.contain,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
                style: TextStyle(
                    color: Constants
                        .appConfig.appTheme.sectionButtonFontColorParsed),
              ),
            ),

      actions: <Widget>[
        // Actions
        IconButton(
          color: Constants.appConfig.appTheme.sectionButtonFontColorParsed,
          icon: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
              )),
          onPressed: () {},
        ),
      ],
    );
  }
}
