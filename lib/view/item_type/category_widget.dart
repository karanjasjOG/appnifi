import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_options.dart';
import 'package:storematic_flutter/view/item_type/image_widget.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';

class CategoryWidget extends StatelessWidget {
  final ItemsOptions itemsOptions;
  final HeightWidthOfCard heightWidthOfCard;

  CategoryWidget(
      {@required this.heightWidthOfCard, @required this.itemsOptions});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(heightWidthOfCard.borderRadius),
      child: Container(
        width: heightWidthOfCard.widthOfCard,
        padding: EdgeInsets.all(heightWidthOfCard.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: heightWidthOfCard.widthOfImageInCard,
                height: heightWidthOfCard.widthOfImageInCard,
                child: ImageWidget(
                  fromCategoryOrProduct: true,
                  itemsOptions: itemsOptions,
                  heightWidthOfCard: heightWidthOfCard,
                )),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryName(
                    visible: itemsOptions.showTitle,
                    width: heightWidthOfCard.availableWidthForEachBottomItem,
                    name: itemsOptions.title,
                    height: heightWidthOfCard.availableHeightForEachBottomItem,
                  ),
                  CategorySubtitle(
                    visible: itemsOptions.showSubtitle,
                    width: heightWidthOfCard.availableWidthForEachBottomItem,
                    subtitle: itemsOptions.subtitle,
                    height: heightWidthOfCard.availableHeightForEachBottomItem,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryName extends StatelessWidget {
  final bool visible;
  final double width;
  final String name;

  final double height;

  CategoryName({
    @required this.visible,
    @required this.width,
    @required this.name,
    @required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AdaptiveText(
              text: name,
              fontWeight: FontWeight.bold,
              minFontSize: (height * 0.7).truncate().toDouble(),
              maxFontSize: (height * 0.9).truncate().toDouble(),
              textColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

class CategorySubtitle extends StatelessWidget {
  final bool visible;
  final double width;
  final String subtitle;
  final double height;
  // final int totalNumberOfBottomItem;
  CategorySubtitle({
    @required this.visible,
    @required this.width,
    @required this.subtitle,
    @required this.height,
    // @required this.totalNumberOfBottomItem
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
          // color: Color.fromARGB(100, 0, 0, 0),
          // padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
          height: height,
          child: AdaptiveText(
            text: subtitle,
            fontWeight: FontWeight.normal,
            minFontSize: (height * 0.7).truncate().toDouble(),
            maxFontSize: (height * 0.9).truncate().toDouble(),
            textColor: Colors.black,
          )),
    );
  }
}
