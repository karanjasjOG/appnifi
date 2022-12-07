import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_data.dart';

List<ItemsOptions> createItemsOptions(ModelItemData data) {
  List<ItemsOptions> itemsOptions = [];

  if (data.itemTypeBool.isImages) {
    var imageOptions = data.imageOptions;
    for (var options in imageOptions) {
      itemsOptions.add(ItemsOptions(data: data, options: options));
    }

    return itemsOptions;
  } else if (data.itemTypeBool.isProducts) {
    var productOptions = data.productOptions;

    for (var options in productOptions) {
      itemsOptions
          .add(ItemsOptions(data: data, options: options, isProducts: true));
    }

    return itemsOptions;
  } else if (data.categoryOptions != [] && data.categoryOptions != null) {
    var categoryOptions = data.categoryOptions;
    for (var options in categoryOptions) {
      itemsOptions.add(ItemsOptions(data: data, options: options));
    }

    return itemsOptions;
  }
  return [];
}

class ItemsOptions {
  final String id;
  final String title;
  final String imageUrl;
  final String navUrl;
  final String price;
  final String salePrice;
  final String rating;

  final String subtitle;
  final bool showSubtitle;
  final bool showPrice;
  final bool showSalePrice;
  final bool showTitle;
  final bool showRating;
  final bool showAddToCart;

  final String sectionHeading;
  final bool isImages;
  final bool isProducts;
  final bool isCategories;
  final bool isCircular;
  final bool hideCircularCardsBoder;
  final bool isBanner;
  final bool isSlider;
  final bool isGrid;
  final bool hideOnSaleBadge;
  final int numOfColumn;

  ItemsOptions._(
      {@required this.sectionHeading,
      @required this.isImages,
      @required this.isProducts,
      @required this.isCategories,
      @required this.isCircular,
      @required this.isBanner,
      @required this.isSlider,
      @required this.isGrid,
      @required this.numOfColumn,
      @required this.title,
      @required this.imageUrl,
      @required this.navUrl,
      @required this.subtitle,
      @required this.showSubtitle,
      @required this.price,
      @required this.rating,
      @required this.salePrice,
      @required this.showTitle,
      @required this.showPrice,
      @required this.showSalePrice,
      @required this.showRating,
      @required this.hideCircularCardsBoder,
      @required this.hideOnSaleBadge,
      this.id,
      this.showAddToCart});

  factory ItemsOptions(
      {@required ModelItemData data,
      @required var options,
      bool isProducts = false}) {
    return ItemsOptions._(
        isCircular: data.sectionStyleBool.isCircular,
        showSubtitle: data.bottomItemBool.showSubtitle,
        sectionHeading: data.sectionHeading,
        isBanner: data.sectionStyleBool.isBanner,
        isSlider: data.sectionStyleBool.isSlider,
        isGrid: data.sectionStyleBool.isGrid,
        numOfColumn: data.numOfColumn,
        isImages: data.itemTypeBool.isImages,
        isProducts: data.itemTypeBool.isProducts,
        isCategories: data.itemTypeBool.isCategories,
        showTitle: data.bottomItemBool.showTitle,
        showRating: data.bottomItemBool.showRating,
        showPrice: data.bottomItemBool.showPrice,
        showSalePrice: data.bottomItemBool.showSalesPrice,
        hideCircularCardsBoder: data.sectionStyleBool.hideCircularCardsBoder,
        hideOnSaleBadge: data.sectionStyleBool.hideOnSaleBadge,
        // -------
        title: options.title,
        imageUrl: options.imageUrl,
        navUrl: options.navUrl,
        subtitle: options.subtitle,
        price: isProducts ? options.price : null,
        salePrice: isProducts ? options.salePrice : null,
        rating: isProducts ? options.rating : null,
        id: isProducts ? options.id : null,
        showAddToCart: isProducts ? data.bottomItemBool.showAddToCart : false);
  }
}
