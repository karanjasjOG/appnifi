import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_data.dart';

import 'package:storematic_flutter/view/item_type/category_widget.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';
import 'package:storematic_flutter/view/item_type/image_widget.dart';
import 'package:storematic_flutter/view/item_type/product_widget.dart';
import 'package:storematic_flutter/models/item_options.dart';
import 'package:storematic_flutter/utils/my_routes.dart';

List<Widget> createCustomCardList({
  @required ModelItemData data,
  @required HeightWidthOfCard heightWidthOfCard,
}) {
  List<Widget> customCardList = [];
  var itemsOptions = createItemsOptions(data);
  for (var item in itemsOptions) {
    customCardList.add(CustomCard(
      itemsOptions: item,
      heightWidthOfCard: heightWidthOfCard,
    ));
  }
  return customCardList;
}

class CustomCard extends StatelessWidget {
  final ItemsOptions itemsOptions;

  final HeightWidthOfCard heightWidthOfCard;

  CustomCard({@required this.itemsOptions, @required this.heightWidthOfCard});

  @override
  Widget build(BuildContext context) {
    if (!itemsOptions.isCircular) {
      if (itemsOptions.isImages) {
        return MyCard(
          appBarTitle: itemsOptions.title,
          heightWidthOfCard: heightWidthOfCard,
          navUrl: itemsOptions.navUrl,
          child: ImageWidget(
            itemsOptions: itemsOptions,
            heightWidthOfCard: heightWidthOfCard,
          ),
        );
      } else if (itemsOptions.isProducts) {
        return MyCard(
          appBarTitle: itemsOptions.title,
          heightWidthOfCard: heightWidthOfCard,
          navUrl: itemsOptions.navUrl,
          child: ProductsWidget(
            itemsOptions: itemsOptions,
            heightWidthOfCard: heightWidthOfCard,
          ),
        );
      } else if (itemsOptions.isCategories) {
        return MyCard(
            appBarTitle: itemsOptions.title,
            heightWidthOfCard: heightWidthOfCard,
            child: CategoryWidget(
              heightWidthOfCard: heightWidthOfCard,
              itemsOptions: itemsOptions,
            ),
            navUrl: itemsOptions.navUrl);
      }
    }
    return MyCircularCard(
      itemsOptions: itemsOptions,
      heightWidthOfCard: heightWidthOfCard,
    );
  }
}

class MyCard extends StatelessWidget {
  final String appBarTitle;
  final HeightWidthOfCard heightWidthOfCard;
  final String navUrl;
  final Widget child;

  MyCard(
      {@required this.appBarTitle,
      @required this.child,
      @required this.navUrl,
      @required this.heightWidthOfCard});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRoutes.pushWebPage(
            context: context,
            path: 'misc',
            pathUrl: navUrl,
            title: appBarTitle);
      },
      child: Card(
        margin: EdgeInsets.all(heightWidthOfCard.cardMargin),
        elevation: heightWidthOfCard.elevation,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(heightWidthOfCard.borderRadius)),
        child: child,
      ),
    );
  }
}

class MyCircularCard extends StatelessWidget {
  final ItemsOptions itemsOptions;
  final HeightWidthOfCard heightWidthOfCard;

  MyCircularCard(
      {@required this.heightWidthOfCard, @required this.itemsOptions});
  @override
  Widget build(BuildContext context) {
    // double fontSizeFactor = (isGrid) ? 0.8 : 0.9;
    // print(heightWidthOfCard.availableHeightForEachBottomItem);
    return InkWell(
      onTap: () {
        MyRoutes.pushWebPage(
          context: context,
          path: 'misc',
          isMisc: true,
          pathUrl: itemsOptions.navUrl,
          title: itemsOptions.title,
        );
      },
      child: Container(
        // color: Colors.black,
        margin: EdgeInsets.all(heightWidthOfCard.cardMargin),
        padding: EdgeInsets.all(heightWidthOfCard.cardPadding),
        width: heightWidthOfCard.widthOfCard,
        height: heightWidthOfCard.heightOfCard,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            !itemsOptions.hideCircularCardsBoder
                ? Container(
                    // padding: EdgeInsets.all(heightWidthOfCard.cardPadding),
                    height: heightWidthOfCard.heightOfImageInCard,
                    width: heightWidthOfCard.widthOfImageInCard,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            heightWidthOfCard.borderRadius),
                        border: Border.all(
                            width: 1,
                            color: Colors.black26,
                            style: BorderStyle.solid)),
                    child: ImageWidget(
                      itemsOptions: itemsOptions,
                      heightWidthOfCard: heightWidthOfCard,
                      // borderRadius: 100,
                    ),
                  )
                : Container(
                    // padding: EdgeInsets.all(heightWidthOfCard.cardPadding),
                    height: heightWidthOfCard.heightOfImageInCard,
                    width: heightWidthOfCard.widthOfImageInCard,
                    child: ImageWidget(
                      itemsOptions: itemsOptions,
                      heightWidthOfCard: heightWidthOfCard,
                      // borderRadius: 100,
                    ),
                  ),
            SizedBox(
              height: heightWidthOfCard.availableHeightForEachBottomItem / 2,
            ),
            AdaptiveText(
              text: itemsOptions.title,
              minFontSize:
                  (heightWidthOfCard.availableHeightForEachBottomItem * 1)
                      .truncate()
                      .toDouble(),
              maxFontSize:
                  (heightWidthOfCard.availableHeightForEachBottomItem * 1)
                      .truncate()
                      .toDouble(),
              textColor: Colors.black54,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
