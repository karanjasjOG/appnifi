import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:storematic_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:storematic_flutter/models/item_data.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/json_keys.dart';
// import 'package:storematic_flutter/design_elements/item_options.dart';

class ProductOptions {
  final String id;
  final String title;
  final String imageUrl;
  final String navUrl;
  final String subtitle;
  final String price;
  final String salePrice;
  final String rating;

  ProductOptions(
      {@required this.title,
      @required this.imageUrl,
      @required this.navUrl,
      @required this.subtitle,
      @required this.price,
      @required this.rating,
      @required this.salePrice,
      @required this.id});
}

class CategoryOptions {
  final String title;
  final String imageUrl;
  final String navUrl;
  final String subtitle;

  CategoryOptions(
      {@required this.title,
      @required this.imageUrl,
      @required this.navUrl,
      @required this.subtitle});
}

class ImageOptions {
  final String title;
  final String imageUrl;
  final String navUrl;
  final String subtitle;

  ImageOptions(
      {@required this.title,
      @required this.imageUrl,
      @required this.navUrl,
      @required this.subtitle});
}

class DataController {
  static Future<List<ModelItemData>> homePage(String api) async {
    List<ModelItemData> modelItemDataList = [];
    var response = await http.get(api);
    print(api);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // print(data);
      var items = DataControllerHelperFunctions.sortList(data);
      // print(items);
      // print(items[0]['id']);
      for (var item in items) {
        item = item[ControllerVariables.itemSectionSettingsKey];

        String sectionNavUrl = DataControllerHelperFunctions.nullSafety(
            ControllerVariables.sectionNavUrlKey, item, Constants.noNavUrl);
        Color sectionBgColorStart = Color(DefaultColors.parseColor(
          DataControllerHelperFunctions.nullSafety(
              ControllerVariables.sectionBgColorStartKey,
              item,
              DefaultColors.sectionBgColor),
        ));
        Color sectionBgColorEnd = Color(DefaultColors.parseColor(
          DataControllerHelperFunctions.nullSafety(
              ControllerVariables.sectionBgColorEndKey,
              item,
              DefaultColors.sectionBgColor),
        ));
        String gradientStart = DataControllerHelperFunctions.nullSafety(
            ControllerVariables.gradientStartKey,
            item,
            Constants.appConfig.appTheme.gradientStartDefault);

        String gradientEnd = DataControllerHelperFunctions.nullSafety(
            ControllerVariables.gradientEndKey,
            item,
            Constants.appConfig.appTheme.gradientEndDefault);
        Color sectionHeaderTitleColor = Color(DefaultColors.parseColor(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.sectionHeaderTitleColorKey,
                item,
                DefaultColors.sectionHeadingFontColor)));
        double sectionMarginTop = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.sectionMarginTopKey,
                item,
                Constants.appConfig.appTheme.sectionMarginTopDefault
                    .toString()));
        double sectionMarginBottom = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.sectionMarginBottomKey,
                item,
                Constants.appConfig.appTheme.sectionMarginBottomDefault
                    .toString()));
        double sectionPaddingTop = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.sectionPaddingTopKey,
                item,
                Constants.appConfig.appTheme.sectionPaddingTopDefault
                    .toString()));
        double sectionPaddingBottom = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.sectionPaddingBottomKey,
                item,
                Constants.appConfig.appTheme.sectionPaddingBottomDefault
                    .toString()));
        String sectionHeading = DataControllerHelperFunctions.nullSafety(
            ControllerVariables.sectionHeadingKey, item, 'Deals For You');

        double itemAspectRatio = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.itemAspectRatioKey,
                item,
                Constants.appConfig.appTheme.itemAspectRatioDefault
                    .toString()));
        double itemWidthFactor = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.itemWidthFactorKey,
                item,
                Constants.appConfig.appTheme.itemWidthFactorDefault
                    .toString()));
        double itemElevation = double.parse(
            DataControllerHelperFunctions.nullSafety(
                ControllerVariables.itemElevationKey,
                item,
                Constants.appConfig.appTheme.elevation.toString()));
        modelItemDataList.add(ModelItemData(
            gradientEnd: gradientEnd,
            gradientStart: gradientStart,
            itemAspectRatio: itemAspectRatio,
            itemElevation: itemElevation,
            itemWidthFactor: itemWidthFactor,
            sectionHeaderTitleColor: sectionHeaderTitleColor,
            sectionHeading: sectionHeading,
            sectionBgColorStart: sectionBgColorStart,
            sectionBgColorEnd: sectionBgColorEnd,
            sectionMarginBottom: sectionMarginBottom,
            sectionMarginTop: sectionMarginTop,
            sectionPaddingBottom: sectionPaddingBottom,
            sectionPaddingTop: sectionPaddingTop,
            sectionNavUrl: sectionNavUrl,
            numOfColumn: DataControllerHelperFunctions.nullSafety(
                ControllerVariables.numOfColumnKey,
                item,
                Constants.appConfig.appTheme.homePageGridNumOfColumnDefault),
            bottomItemBool: BottomItemBool(item: item),
            productOptions:
                DataControllerHelperFunctions.fillItemOptionsForProducts(
                    item[ControllerVariables.products]),
            categoryOptions:
                DataControllerHelperFunctions.fillItemOptionsForCategories(
                    item[ControllerVariables.categories]),
            imageOptions:
                DataControllerHelperFunctions.fillItemOptionsForImages(
                    item[ControllerVariables.images]),
            itemTypeBool: ItemTypeBool(item: item),
            sectionBool: SectionBool(item: item),
            sectionStyleBool: SectionStyleBool(item: item)));
      }
      // return [];
    }
    // print(modelItemDataList[0].sectionHeading);
    return modelItemDataList;
  }

  static Future<ModelItemData> categoryPage(String api) async {
    //TODO exception handling
    var response = await http.get(api);
    var item = jsonDecode(response.body);
    print(api);
    if (response.statusCode == 200) {
      return ModelItemData(
          gradientEnd: Constants.appConfig.appTheme.gradientEndDefault,
          gradientStart: Constants.appConfig.appTheme.gradientStartDefault,
          itemAspectRatio: Constants.appConfig.appTheme.itemAspectRatioDefault,
          itemWidthFactor: Constants.appConfig.appTheme.itemWidthFactorDefault,
          itemElevation: 0,
          sectionMarginBottom: 0,
          sectionMarginTop: 0,
          sectionPaddingBottom: 0,
          sectionPaddingTop: 0,
          sectionHeaderTitleColor: Colors.black,
          sectionBool: SectionBool(item: item, categoryPage: true),
          sectionBgColorStart: Colors.white,
          sectionBgColorEnd: Colors.white,
          sectionNavUrl: Constants.noNavUrl,
          sectionHeading: 'All Categories',
          sectionStyleBool: SectionStyleBool(item: item, categoryPage: true),
          bottomItemBool: BottomItemBool(item: item),
          numOfColumn: DataControllerHelperFunctions.nullSafety(
              ControllerVariables.numOfColumnKey,
              item,
              Constants.appConfig.appTheme.categoryPageGridNumOfColumnDefault),
          itemTypeBool: ItemTypeBool(item: item),
          categoryOptions:
              DataControllerHelperFunctions.fillItemOptionsForCategories(
                  item[ControllerVariables.categories]),
          imageOptions: null,
          productOptions: null);
    }
  }

  static Future<List<ImageOptions>> searchPage(String api) async {
    var response = await http.get(api);
    var items = jsonDecode(response.body);
    List<ImageOptions> resultList = [];
    for (var item in items) {
      ImageOptions imageOptions = ImageOptions(
          title: item['name'],
          imageUrl: item['image'],
          navUrl: item['url'],
          subtitle: item['categories']);
      resultList.add(imageOptions);
    }
    // print(resultList.runtimeType);
    return resultList;
  }
}

class DataControllerHelperFunctions {
  static Object nullSafety(String key, Map item, var defaultValue) {
    if (item[key] != null && item[key] != '') {
      if (defaultValue.runtimeType == bool) {
        return (item[key] == 'yes') ? true : false;
      } else if (defaultValue.runtimeType == double) {
        return double.parse(item[key]);
      } else if (defaultValue.runtimeType == int) {
        return int.parse(item[key]);
      } else if (item[key] == false) {
        if (defaultValue.runtimeType == String) {
          return defaultValue;
        }
      }
      return item[key];
    }
    return defaultValue;
  }

  static List sortList(List items) {
    var tempItems = items;
    int n = items.length;
    for (int i = 0; i < n; ++i) {
      for (int j = i + 1; j < n; ++j) {
        if (int.parse(tempItems[i][ControllerVariables.itemSectionSettingsKey]
                [ControllerVariables.itemSectionPriority]) >
            int.parse(tempItems[j][ControllerVariables.itemSectionSettingsKey]
                [ControllerVariables.itemSectionPriority])) {
          var temp = tempItems[i];
          tempItems[i] = tempItems[j];
          tempItems[j] = temp;
        }
      }
    }
    return tempItems;
  }

  static List<ImageOptions> fillItemOptionsForImages(List items) {
    List<ImageOptions> tempList = [];
    if (items == null) {
      return [];
    }
    for (var image in items) {
      ImageOptions imageOptions = ImageOptions(
          title: nullSafety('title', image, 'Storematic'),
          imageUrl: nullSafety('url', image, Constants.noImageUrl),
          navUrl: nullSafety('link', image, Constants.noNavUrl),
          subtitle: nullSafety('subtitle', image, 'Storematic'));
      tempList.add(imageOptions);
    }
    return tempList;
  }

  static List<ProductOptions> fillItemOptionsForProducts(List items) {
    // print(items);
    List<ProductOptions> tempList = [];
    if (items == null) {
      return [];
    }
    for (var product in items) {
      var temp = ProductOptions(
          id: nullSafety('id', product, '#').toString(),
          title: nullSafety('name', product, '#'),
          imageUrl: nullSafety('image', product, Constants.noImageUrl),
          navUrl: nullSafety('url', product, Constants.noNavUrl),
          price: nullSafety('price', product, '0'),
          salePrice: nullSafety('sale_price', product, '0'),
          subtitle: nullSafety('subtitle', product, 'Storematic'),
          rating: nullSafety('average_rating', product, '1'));
      tempList.add(temp);
    }
    return tempList;
  }

  static List<CategoryOptions> fillItemOptionsForCategories(List items) {
    List<CategoryOptions> tempList = [];
    if (items == null) {
      return [];
    }
    for (var category in items) {
      tempList.add(CategoryOptions(
          title: nullSafety('name', category, 'Storematic'),
          imageUrl: nullSafety('image', category, Constants.noImageUrl),
          navUrl: nullSafety('url', category, Constants.noNavUrl),
          subtitle: nullSafety('subtitle', category, 'Stromatic')));
    }

    return tempList;
  }
}
