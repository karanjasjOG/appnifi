import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:storematic_flutter/utils/constants.dart';

class ViewCartStripDimensions {
  final double heightOfStrip;
  final double widthOfStrip;
  final double fontSizeLeading;
  final double fontSizeActions;

  ViewCartStripDimensions._(
      {@required this.fontSizeActions,
      @required this.fontSizeLeading,
      @required this.heightOfStrip,
      @required this.widthOfStrip});
  factory ViewCartStripDimensions(context) {
    var size = MediaQuery.of(context).size;
    double height = size.height * 0.05;
    double width = size.width;
    double leading = height * .3;
    double action = height * .35;
    return ViewCartStripDimensions._(
        fontSizeActions: action.truncate().toDouble(),
        fontSizeLeading: leading.truncate().toDouble(),
        heightOfStrip: height,
        widthOfStrip: width);
  }
}

class HeightWidthOfCard {
  final double heightOfCard;
  final double widthOfCard;
  final double heightOfSlider;
  final double heightOfImageInCard;
  final double widthOfImageInCard;
  final double availableHeightForEachBottomItem;
  final double availableWidthForEachBottomItem;
  final double cardPadding;
  final double cardMargin;
  final double borderRadius;
  final double elevation;

  final double imageBottomMargin;

  HeightWidthOfCard._(
      {@required this.heightOfSlider,
      @required this.availableWidthForEachBottomItem,
      @required this.availableHeightForEachBottomItem,
      @required this.heightOfCard,
      @required this.widthOfCard,
      @required this.heightOfImageInCard,
      @required this.widthOfImageInCard,
      @required this.cardPadding,
      @required this.cardMargin,
      @required this.borderRadius,
      @required this.elevation,
      @required this.imageBottomMargin});
  factory HeightWidthOfCard(
      {@required ModelItemData data, @required double screenWidth}) {
    double cardPadding = Constants.appConfig.appTheme.cardPaddingDefault;
    double cardMargin = Constants.appConfig.appTheme.cardMarginDefault;
    double imageBottomMargin = 5;
    double borderRadius = Constants.appConfig.appTheme.borderRadiusDefault;
    double elevation = data.itemElevation;
    double widthFactor = Constants.appConfig.appTheme.itemWidthFactorDefault;
    double aspectRatio = Constants.appConfig.appTheme.itemAspectRatioDefault;
    double imageAspectRatio = 1;
    bool enableFreeSize = data.sectionStyleBool.enableFreeSize;
    bool showAddToCart = data.bottomItemBool.showAddToCart;
    final int maxNumberOfBottomItems =
        data.bottomItemBool.totalNumberOfBottomItems -
            1; //Sale price and price comes in same row.
    int tempTotalNumberBottomItems = 0;
    tempTotalNumberBottomItems = (data.bottomItemBool.showTitle)
        ? ++tempTotalNumberBottomItems
        : tempTotalNumberBottomItems;
    tempTotalNumberBottomItems = (data.bottomItemBool.showPrice)
        ? ++tempTotalNumberBottomItems
        : tempTotalNumberBottomItems;
    tempTotalNumberBottomItems = (data.bottomItemBool.showRating)
        ? ++tempTotalNumberBottomItems
        : tempTotalNumberBottomItems;
    tempTotalNumberBottomItems = (data.bottomItemBool.showSubtitle)
        ? ++tempTotalNumberBottomItems
        : tempTotalNumberBottomItems;

    if (tempTotalNumberBottomItems == 0) {
      imageBottomMargin = 0;
      if (data.itemTypeBool.isImages) cardPadding = 0;
    }

    if (data.sectionStyleBool.isBanner) {
      // cardPadding = 0;
      cardMargin = 0;
      imageBottomMargin = 0;
      borderRadius =
          Constants.appConfig.appTheme.bannerWidgetBorderRadiusDefault;
      elevation = 0;
      widthFactor = 1;
      aspectRatio = enableFreeSize
          ? data.itemAspectRatio
          : Constants.appConfig.appTheme.bannerAspectRatioDefault;
      imageAspectRatio = aspectRatio;
      tempTotalNumberBottomItems = 0;
    } else if (data.sectionStyleBool.isGrid) {
      if (enableFreeSize &&
          data.itemTypeBool.isImages &&
          tempTotalNumberBottomItems == 0) {
        imageBottomMargin = 0;
        aspectRatio = data.itemAspectRatio;
        imageAspectRatio = aspectRatio;
      }
      widthFactor = 1 / data.numOfColumn;
    } else if (data.sectionStyleBool.isSlider) {
      if (enableFreeSize &&
          data.itemTypeBool.isImages &&
          tempTotalNumberBottomItems == 0) {
        imageBottomMargin = 0;
        aspectRatio = data.itemAspectRatio;
        widthFactor = data.itemWidthFactor;
        imageAspectRatio = aspectRatio;
      }
    }

    if (data.sectionStyleBool.isCircular) {
      borderRadius = 100;
      tempTotalNumberBottomItems = 2;
      if (data.sectionStyleBool.isSlider) widthFactor = 0.3;
      // imageBottomMargin = 5;
    }

    double tempWidthOfcard = screenWidth * widthFactor - (2 * cardMargin);
    double tempHeightOfCard = (tempWidthOfcard * 1 / aspectRatio);
    double tempWidthOfImageInCard = tempWidthOfcard - (2 * cardPadding);
    // print(cardPadding);
    double tempHeightOfImageInCard =
        tempWidthOfImageInCard * (1 / imageAspectRatio);

    double availableHeightForBottomItems = tempHeightOfCard -
        (2 * cardPadding) -
        tempHeightOfImageInCard -
        imageBottomMargin;
    double availableWidthForEachBottomItem =
        tempWidthOfcard - (2 * cardPadding);

    double leastAvailableHeightFroEachBottomItem =
        availableHeightForBottomItems / maxNumberOfBottomItems;

    tempHeightOfCard = tempHeightOfCard - availableHeightForBottomItems;
    tempHeightOfCard = tempHeightOfCard +
        tempTotalNumberBottomItems * leastAvailableHeightFroEachBottomItem +
        imageBottomMargin;
    double tempHeightOfSlider = tempHeightOfCard + (2 * cardMargin);

    if (showAddToCart) {
      tempHeightOfSlider += 40;
      tempHeightOfCard += 40;
    }

    return HeightWidthOfCard._(
        heightOfSlider: tempHeightOfSlider,
        availableWidthForEachBottomItem: availableWidthForEachBottomItem,
        availableHeightForEachBottomItem: leastAvailableHeightFroEachBottomItem,
        heightOfCard: tempHeightOfCard,
        widthOfCard: tempWidthOfcard,
        heightOfImageInCard: tempHeightOfImageInCard,
        widthOfImageInCard: tempWidthOfImageInCard,
        cardPadding: cardPadding,
        cardMargin: cardMargin,
        borderRadius: borderRadius,
        elevation: elevation,
        // aspectRatio: aspectRatio,
        // widthFactor: widthFactor,
        imageBottomMargin: imageBottomMargin);
  }
}

class AdaptiveText extends StatelessWidget {
  final String text;
  final double minFontSize;
  final double maxFontSize;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  final Color textColor;
  final int maxlines;
  final TextAlign textAlign;
  final bool lineThrough;
  // final HeightWidthOfCard heightWidthOfCard;

  AdaptiveText(
      {this.lineThrough = false,
      @required this.text,
      @required this.minFontSize,
      @required this.maxFontSize,
      this.textOverflow = TextOverflow.ellipsis,
      this.fontWeight = FontWeight.normal,
      this.maxlines = 1,
      this.textAlign = TextAlign.center,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    bool visible = true;
    double minFont = minFontSize;
    double maxFont = maxFontSize;
    if (maxFont <= 0) visible = false;
    return Visibility(
      visible: visible,
      child: AutoSizeText(
        text,
        overflow: textOverflow,
        minFontSize: minFontSize,
        maxFontSize: maxFontSize,
        maxLines: maxlines,
        style: TextStyle(
            fontWeight: fontWeight,
            color: textColor,
            decoration:
                lineThrough ? TextDecoration.lineThrough : TextDecoration.none),
        textAlign: textAlign,
      ),
    );
  }
}
