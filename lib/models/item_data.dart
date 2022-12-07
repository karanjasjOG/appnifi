import 'package:flutter/material.dart';
// import 'package:storematic_flutter/models/item_options.dart';
import 'package:storematic_flutter/controller/data_controller.dart';
import 'package:storematic_flutter/utils/json_keys.dart';

class ModelItemData {
  final SectionBool sectionBool;
  final String sectionHeading;
  final Color sectionBgColorStart;
  final Color sectionBgColorEnd;
  final String gradientStart;
  final String gradientEnd;
  final Color sectionHeaderTitleColor;
  final double sectionMarginTop;
  final double sectionMarginBottom;
  final double sectionPaddingTop;
  final double sectionPaddingBottom;
  final String sectionNavUrl;
  final double itemAspectRatio;
  final double itemWidthFactor;
  final double itemElevation;
  final ItemTypeBool itemTypeBool;

  final SectionStyleBool sectionStyleBool;

  final int numOfColumn;
  final BottomItemBool bottomItemBool;

  final List<ProductOptions> productOptions;
  final List<CategoryOptions> categoryOptions;
  final List<ImageOptions> imageOptions;

  ModelItemData({
    @required this.sectionHeading,
    @required this.sectionBgColorStart,
    @required this.sectionBgColorEnd,
    @required this.sectionNavUrl,
    @required this.numOfColumn,
    @required this.bottomItemBool,
    @required this.productOptions,
    @required this.categoryOptions,
    @required this.imageOptions,
    @required this.itemTypeBool,
    @required this.sectionBool,
    @required this.sectionStyleBool,
    @required this.sectionHeaderTitleColor,
    @required this.sectionMarginBottom,
    @required this.sectionMarginTop,
    @required this.sectionPaddingBottom,
    @required this.sectionPaddingTop,
    @required this.itemAspectRatio,
    @required this.itemWidthFactor,
    @required this.itemElevation,
    @required this.gradientStart,
    @required this.gradientEnd,
  });
}

class BottomItemBool {
  final bool showAddToCart;
  final bool showTitle;
  final bool showPrice;
  final bool showSalesPrice;
  final bool showRating;
  final bool showSubtitle;
  final int totalNumberOfBottomItems = 5;

  BottomItemBool._(
      {@required this.showPrice,
      @required this.showRating,
      @required this.showSalesPrice,
      @required this.showTitle,
      @required this.showSubtitle,
      @required this.showAddToCart});

  factory BottomItemBool({@required Map item, bool isCategoryPage = false}) {
    bool isProducts = false;
    bool isCategories = false;
    if (item[ControllerVariables.itemTypeKey] ==
            ControllerVariables.itemTypeValue_Products ||
        item[ControllerVariables.itemTypeKey] ==
            ControllerVariables.itemTypeValue_ProductsByCategory)
      isProducts = true;
    else if (item[ControllerVariables.itemTypeKey] ==
        ControllerVariables.itemTypeValue_Categories) isCategories = true;
    return BottomItemBool._(
        showAddToCart: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.showAddToCart, item, false),
        showPrice: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.showPriceKey, item, isProducts ? true : false),
        showRating: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.showRatingKey,
            item,
            isProducts ? false : false),
        showSalesPrice: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.showSalePriceKey,
            item,
            isProducts ? true : false),
        showSubtitle: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.showSubtitleKey,
            item,
            isCategoryPage ? true : false),
        showTitle: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.showTitleKey,
            item,
            isProducts || isCategories ? true : false));
  }
}

class SectionStyleBool {
  final bool isCircular;
  final bool isBanner;
  final bool isSlider;
  final bool isGrid;
  final bool hideCircularCardsBoder;
  final bool hideOnSaleBadge;
  final bool enableFreeSize;
  SectionStyleBool._(
      {@required this.isBanner,
      @required this.isGrid,
      @required this.isSlider,
      @required this.isCircular,
      @required this.hideCircularCardsBoder,
      @required this.hideOnSaleBadge,
      @required this.enableFreeSize});

  factory SectionStyleBool({@required Map item, bool categoryPage = false}) {
    bool hideCircularCardsBoder = DataControllerHelperFunctions.nullSafety(
        ControllerVariables.hideCircularCardsBorder, item, false);
    bool isBanner = false;
    bool isGrid = false;
    bool isSlider = false;
    bool isCircular = DataControllerHelperFunctions.nullSafety(
        ControllerVariables.circularKey, item, categoryPage ? true : false);
    bool hideOnSaleBadge = DataControllerHelperFunctions.nullSafety(
        ControllerVariables.hideOnSaleBadgeKey, item, false);

    bool enableFreeSize = DataControllerHelperFunctions.nullSafety(
        ControllerVariables.enableFreeSizeKey, item, false);
    if (item[ControllerVariables.sectionStyleKey] ==
        ControllerVariables.itemStyleValue_Banner)
      isBanner = true;
    else if (item[ControllerVariables.sectionStyleKey] ==
            ControllerVariables.itemStyleValue_Grid ||
        categoryPage)
      isGrid = true;
    else if (item[ControllerVariables.sectionStyleKey] ==
        ControllerVariables.itemStyleValue_Slider) isSlider = true;

    return SectionStyleBool._(
        hideCircularCardsBoder: hideCircularCardsBoder,
        isBanner: isBanner,
        isGrid: isGrid,
        isSlider: isSlider,
        isCircular: isCircular,
        hideOnSaleBadge: hideOnSaleBadge,
        enableFreeSize: enableFreeSize);
  }
}

class ItemTypeBool {
  final bool isImages;
  final bool isProducts;
  final bool isCategories;

  ItemTypeBool._(
      {@required this.isCategories,
      @required this.isImages,
      @required this.isProducts});

  factory ItemTypeBool({@required Map item}) {
    bool isImages = false;
    bool isProducts = false;
    bool isCategories = false;
    if (item[ControllerVariables.itemTypeKey] ==
        ControllerVariables.itemTypeValue_Categories)
      isCategories = true;
    else if (item[ControllerVariables.itemTypeKey] ==
        ControllerVariables.itemTypeValue_Images)
      isImages = true;
    else if (item[ControllerVariables.itemTypeKey] ==
            ControllerVariables.itemTypeValue_Products ||
        item[ControllerVariables.itemTypeKey] ==
            ControllerVariables.itemTypeValue_ProductsByCategory)
      isProducts = true;

    return ItemTypeBool._(
        isCategories: isCategories, isImages: isImages, isProducts: isProducts);
  }
}

class SectionBool {
  final bool hideSectionHeader;
  final bool isHidden;
  SectionBool._({@required this.hideSectionHeader, @required this.isHidden});
  factory SectionBool({@required Map item, bool categoryPage = false}) {
    return SectionBool._(
        hideSectionHeader: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.hideHeaderKey,
            item,
            categoryPage ? true : false),
        isHidden: DataControllerHelperFunctions.nullSafety(
            ControllerVariables.hideSectionKey, item, false));
  }
}
