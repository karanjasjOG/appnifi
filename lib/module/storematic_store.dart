import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/global_state_controller.dart';
import 'package:storematic_flutter/utils/my_routes.dart';
import 'package:storematic_flutter/view/app_bar/my_app_bar.dart';
import 'package:storematic_flutter/view/app_bar/my_badge.dart';
import 'package:storematic_flutter/view/app_bar/my_drawer.dart';
import 'package:storematic_flutter/view/pages/home.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/pages/my_category_page.dart';
import 'package:storematic_flutter/view/pages/my_search_page.dart';

// ignore: must_be_immutable
class StorematicStore extends StatefulWidget {
  StorematicStore();
  @override
  _StorematicStoreState createState() => _StorematicStoreState();
}

class _StorematicStoreState extends State<StorematicStore> {
  String _searchQuery = Constants.appConfig.searchQuery;
  int _numberOfItemsInCart = 0;

  void changeCounter({@required int numberOfItemsInCart}) {
    if (numberOfItemsInCart >= 0 && numberOfItemsInCart < 1000) {
      setState(() {
        _numberOfItemsInCart = numberOfItemsInCart;
      });
    }
  }

  @override
  void initState() {
    print(Constants.appConfig.searchQuery);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height *
        Constants.appConfig.appTheme.appBarHeightFactor;
    // List<BottomNavigationBarItem> bottomItems = [];

    return Constants.appConfig.hasBottomNavigation
        ? SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      Constants.appConfig.showCarticon ? height : 56),
                  child: AppBarTop(
                    title: Constants.appConfig.title,
                    numberOfItemInCart: _numberOfItemsInCart,
                    searchQeury: _searchQuery,
                    appBarHeight: height,
                  )),
              drawer: MyDrawer(),
              body: HomePage(
                numberOfItemsInCart: _numberOfItemsInCart,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                // backgroundColor: Colors.black,
                selectedItemColor: Colors.black54,
                unselectedItemColor: Colors.black54,
                selectedFontSize: 12,
                // selectedLabelStyle: TextStyle(color: Colors.black54),
                // unselectedLabelStyle: TextStyle(color: Colors.black),
                items: Constants.appConfig.showBottomCartIcon
                    ? bottomItemsWithCart
                    : bottomItemsWithOutCart,
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(
                      Constants.appConfig.showCarticon ? height : 56),
                  child: AppBarTop(
                    title: Constants.appConfig.title,
                    numberOfItemInCart: _numberOfItemsInCart,
                    searchQeury: _searchQuery,
                    appBarHeight: height,
                  )),
              drawer: MyDrawer(),
              body: HomePage(
                numberOfItemsInCart: _numberOfItemsInCart,
              ),
              // bottomNavigationBar: BottomNavigationBar(items: bottomItems,),
            ),
          );
  }
}

class BottomItems extends StatelessWidget {
  final String title;
  final bool isWebPage;
  final String navUrl;
  final IconData icon;
  final Widget badge;
  final bool isSearch;
  const BottomItems(
      {Key key,
      this.icon,
      this.isWebPage,
      this.navUrl,
      this.title,
      this.badge,
      this.isSearch = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 24,
        width: 24,
        child: icon == null
            ? badge
            : Icon(
                icon,
                // color: Colors.black,
              ),
      ),
      onTap: () {
        if (isWebPage) {
          MyRoutes.pushWebPage(
              context: context,
              path: 'misc',
              isMisc: true,
              pathUrl: navUrl,
              title: title);
        } else if (isSearch) {
          showSearch(context: context, delegate: Search());
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCategoryPage()),
          );
        }
      },
    );
  }
}

List<BottomNavigationBarItem> bottomItemsWithOutCart = [
  BottomNavigationBarItem(
      label: 'Account',
      icon: BottomItems(
          title: 'Account',
          isWebPage: true,
          icon: Icons.manage_accounts,
          navUrl: Constants.appConfig.shopEndpoints.myAccount)),
  BottomNavigationBarItem(
      label: 'Wishlist',
      icon: BottomItems(
          title: 'Wishlist',
          isWebPage: true,
          icon: Icons.linked_camera,
          navUrl: Constants.appConfig.shopEndpoints.wishList)),
  BottomNavigationBarItem(
      label: 'Categories',
      icon: BottomItems(
        title: 'Categories',
        isWebPage: false,
        icon: Icons.category,
      )),
  BottomNavigationBarItem(
      label: 'Search',
      icon: BottomItems(
        title: 'Search',
        isWebPage: false,
        icon: Icons.search,
        isSearch: true,
      )),
];

List<BottomNavigationBarItem> bottomItemsWithCart = [
  BottomNavigationBarItem(
      label: 'Account',
      icon: BottomItems(
          title: 'Account',
          isWebPage: true,
          icon: Icons.manage_accounts,
          navUrl: Constants.appConfig.shopEndpoints.myAccount)),
  BottomNavigationBarItem(
      label: 'Wishlist',
      icon: BottomItems(
          title: 'Wishlist',
          isWebPage: true,
          icon: Icons.linked_camera,
          navUrl: Constants.appConfig.shopEndpoints.wishList)),
  BottomNavigationBarItem(
      label: 'Cart',
      icon: BottomItems(
          title: 'Cart',
          isWebPage: true,
          badge: MyBadge(),
          // icon: Icons.manage_accounts,
          navUrl: Constants.appConfig.shopEndpoints.cart)),
  BottomNavigationBarItem(
      label: 'Categories',
      icon: BottomItems(
        title: 'Categories',
        isWebPage: false,
        icon: Icons.category,
      )),
  BottomNavigationBarItem(
      label: 'Search',
      icon: BottomItems(
        title: 'Search',
        isWebPage: false,
        icon: Icons.search,
        isSearch: true,
      )),
];
