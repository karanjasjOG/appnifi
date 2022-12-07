// import 'dart:html';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storematic_flutter/models/item_options.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/global_state_controller.dart';
import 'package:storematic_flutter/view/item_type/image_widget.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:storematic_flutter/view/view_utils/rating_indicator.dart';
// import 'package:animations/animations.dart';

class ProductsWidget extends StatelessWidget {
  final ItemsOptions itemsOptions;

  // final bool isGrid;
  // final int numOfColumn;
  final HeightWidthOfCard heightWidthOfCard;
  // final double widthFactor;
  // final double aspectRatio;

  ProductsWidget(
      {
      // @required this.isGrid,
      // @required this.numOfColumn,

      @required this.heightWidthOfCard,
      @required this.itemsOptions
      // @required this.widthFactor,
      // @required this.aspectRatio
      });
  @override
  Widget build(BuildContext context) {
    bool tempShowSalePrice = itemsOptions.showSalePrice;
    if (itemsOptions.salePrice == '0') {
      tempShowSalePrice = false;
    }
    final addToCartKey = GlobalKey<_AddToCartState>();

    return ClipRRect(
      borderRadius: BorderRadius.circular(heightWidthOfCard.borderRadius),
      child: Stack(
        children: [
          Container(
            width: heightWidthOfCard.widthOfCard,
            height: heightWidthOfCard.heightOfCard,
            padding: EdgeInsets.all(heightWidthOfCard.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: heightWidthOfCard.widthOfImageInCard,
                  height: heightWidthOfCard.heightOfImageInCard,
                  child: ImageWidget(
                    itemsOptions: itemsOptions,
                    fromCategoryOrProduct: true,
                    heightWidthOfCard: heightWidthOfCard,
                  ),
                ),
                Container(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductName(
                        visible: itemsOptions.showTitle,
                        // width: heightWidthOfCard.availableWidthForEachBottomItem,
                        name: itemsOptions.title,
                        height:
                            heightWidthOfCard.availableHeightForEachBottomItem,
                        // totalNumberOfBottomItem: totalNumberOfBottomItems
                      ),
                      (itemsOptions.showPrice)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: ProductPrice(
                                      isSale: tempShowSalePrice,
                                      visible: itemsOptions.showPrice,
                                      price: itemsOptions.price,
                                      height: heightWidthOfCard
                                          .availableHeightForEachBottomItem),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: ProductPrice(
                                      isSale: false,
                                      visible: tempShowSalePrice,
                                      price: itemsOptions.salePrice,
                                      height: heightWidthOfCard
                                          .availableHeightForEachBottomItem),
                                )
                              ],
                            )
                          : Container(),
                      ProductRating(
                        visible: itemsOptions.showRating,
                        width:
                            heightWidthOfCard.availableWidthForEachBottomItem,
                        rating: itemsOptions.rating,
                        height:
                            heightWidthOfCard.availableHeightForEachBottomItem,
                        // totalNumberOfBottomItem: totalNumberOfBottomItems
                      ),
                      AddToCart(
                        key: addToCartKey,
                        visible: itemsOptions.showAddToCart,
                        heightWidthOfCard: heightWidthOfCard,
                        id: itemsOptions.id,
                        addToCartKey: addToCartKey,
                      ),
                      ProductSubtitle(
                        visible: itemsOptions.showSubtitle,
                        width:
                            heightWidthOfCard.availableWidthForEachBottomItem,
                        subtitle: itemsOptions.subtitle,
                        height:
                            heightWidthOfCard.availableHeightForEachBottomItem,
                        // totalNumberOfBottomItem: totalNumberOfBottomItems
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              child: SaleBadge(
                  showBadge: tempShowSalePrice && !itemsOptions.hideOnSaleBadge
                      ? true
                      : false,
                  heightWidthOfCard: heightWidthOfCard)),
        ],
      ),
    );
  }
}

class ProductName extends StatelessWidget {
  final bool visible;
  // final double width;
  final String name;
  // final double width;
  final double height;
  // final int totalNumberOfBottomItem;
  ProductName({
    @required this.visible,
    // @required this.width,
    @required this.name,
    // @required this.width,
    @required this.height,
    // @required this.totalNumberOfBottomItem
  });
  @override
  Widget build(BuildContext context) {
    // print(height);
    // double height=(width-8)*(1/)
    return Visibility(
      visible: visible,
      child: Container(
          // margin: EdgeInsets.only(top: 5),
          // color: Colors.black,
          // width: width,
          // padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
          height: height,
          child: AdaptiveText(
            text: name,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.normal,
            minFontSize: (height * 0.7).truncate().toDouble(),
            maxFontSize: (height * 0.9).truncate().toDouble(),
            textColor: Colors.black,
          )),
    );
  }
}

class ProductPrice extends StatelessWidget {
  final bool visible;
  // final double width;
  final bool isSale;
  final String price;
  final double height;
  // final int totalNumberOfBottomItem;
  ProductPrice({
    @required this.isSale,
    // @required this.width,
    @required this.visible,
    @required this.price,
    @required this.height,
    // @required this.totalNumberOfBottomItem
  });
  @override
  Widget build(BuildContext context) {
    // print(height);
    return Container(
      // margin: EdgeInsets.only(right: 5),
      height: height,
      // width: width,
      child: Visibility(
        visible: visible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                // width: width,
                child: AdaptiveText(
              text: Constants.appConfig.currencySymbol +
                  price, //TODO add currency to app configration

              fontWeight: isSale ? FontWeight.normal : FontWeight.bold,
              minFontSize:
                  (height * (isSale ? 0.6 : 0.8)).truncate().toDouble(),
              maxFontSize:
                  (height * (isSale ? 0.7 : 0.9)).truncate().toDouble(),
              textColor: isSale ? Colors.black38 : Colors.black,
              textAlign: TextAlign.start,
              lineThrough: isSale,
            )),
          ],
        ),
      ),
    );
  }
}

class ProductRating extends StatelessWidget {
  final bool visible;
  final double width;
  final String rating;
  final double height;
  // final int totalNumberOfBottomItem;
  ProductRating({
    @required this.visible,
    @required this.width,
    @required this.rating,
    @required this.height,
    // @required this.totalNumberOfBottomItem
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        height: height,
        child: Container(
            // color: Colors.black,
            width: width * 0.5,
            // height: height * 0.2,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: RatingBar(
                rating: double.parse(rating),
              ),
            )),
      ),
    );
  }
}

class ProductSubtitle extends StatelessWidget {
  final bool visible;
  final double width;
  final String subtitle;
  final double height;
  // final int totalNumberOfBottomItem;
  ProductSubtitle({
    @required this.visible,
    @required this.width,
    @required this.subtitle,
    @required this.height,
    // @required this.totalNumberOfBottomItem
  });
  @override
  Widget build(BuildContext context) {
    // print((height * 0.6).truncate().toDouble());
    // print((height * 0.7).truncate().toDouble());
    return Visibility(
      visible: visible,
      child: Container(
          // color: Color.fromARGB(100, 0, 0, 0),
          // padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
          height: height,
          child: AdaptiveText(
            text: subtitle,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.normal,
            minFontSize: (height * 0.6).truncate().toDouble(),
            maxFontSize: (height * 0.6).truncate().toDouble(),
            textColor: Colors.black,
          )),
    );
  }
}

class AddToCart extends StatefulWidget {
  final bool visible;
  final String id;
  final HeightWidthOfCard heightWidthOfCard;
  final addToCartKey;
  const AddToCart(
      {Key key,
      this.heightWidthOfCard,
      this.id,
      this.visible,
      this.addToCartKey})
      : super(key: key);

  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool inLoading = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: ValueListenableBuilder(
          valueListenable: GlobalStateController.state.inLoading,
          builder: (context, value, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                  onTap: () {
                    if (!GlobalStateController.state.isAddToCartActive)
                      return null;
                    GlobalStateController.state.setAddToCart(false);
                    // print('assd');
                    HeadlessWebview headlessWebview =
                        HeadlessWebview(widget.id);

                    inLoading = true;

                    headlessWebview.run();
                  },
                  child:
                      inLoading && GlobalStateController.state.inLoading.value
                          ? ShimmerAddToCart(
                              heightWidthOfCard: widget.heightWidthOfCard,
                              addToCartKey: widget.addToCartKey,
                            )
                          : SimpleAddToCart(
                              heightWidthOfCard: widget.heightWidthOfCard,
                            )),
            );
          }),
    );
  }
}

class ShimmerAddToCart extends StatelessWidget {
  final addToCartKey;
  final HeightWidthOfCard heightWidthOfCard;
  const ShimmerAddToCart({Key key, this.heightWidthOfCard, this.addToCartKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    addToCartKey.currentState.inLoading = false;
    return Shimmer.fromColors(
      baseColor: Constants.appConfig.appTheme.appBarColorParsed,
      highlightColor: Colors.black,
      child: Container(
        width: heightWidthOfCard.availableWidthForEachBottomItem,
        height: 30,
        // color: Colors.amber,
        child: Center(
            child: Text(
          'Add +',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class SimpleAddToCart extends StatelessWidget {
  final HeightWidthOfCard heightWidthOfCard;
  const SimpleAddToCart({Key key, this.heightWidthOfCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: heightWidthOfCard.availableWidthForEachBottomItem,
      height: 30,
      color: Constants.appConfig.appTheme.appBarColorParsed,
      child: Center(
          child: Text(
        'Add +',
        style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Constants.appConfig.appTheme.sectionButtonFontColorParsed),
      )),
    );
  }
}

class SaleBadge extends StatelessWidget {
  final HeightWidthOfCard heightWidthOfCard;
  final bool showBadge;
  SaleBadge({@required this.showBadge, @required this.heightWidthOfCard});
  @override
  Widget build(BuildContext context) {
    // double sizeFactor = 0.15;
    return Visibility(
      visible: showBadge,
      child: Container(
        width: heightWidthOfCard.widthOfCard * 0.25,
        child: AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
            ),
            padding: EdgeInsets.all(3),
            child: FittedBox(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.white60,
                child: Text(
                  'On Sale',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeadlessWebview {
  HeadlessInAppWebView headlessInAppWebView;
  HeadlessWebview._({@required this.headlessInAppWebView});

  factory HeadlessWebview(String id) {
    return HeadlessWebview._(
        headlessInAppWebView: HeadlessInAppWebView(
            initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(userAgent: "storematic")),
            onWebViewCreated: (controller) async {
              //controller.setOptions(options: InApp)
              if (!Platform.isAndroid ||
                  await AndroidWebViewFeature.isFeatureSupported(
                      AndroidWebViewFeature.WEB_MESSAGE_LISTENER)) {
                await controller.addWebMessageListener(WebMessageListener(
                  jsObjectName: "STM_HANDLER",
                  onPostMessage:
                      (message, sourceOrigin, isMainFrame, replyProxy) {
                    var input = jsonDecode(message);
                    // print('${input["event"]} jschannel event');

                    switch (input['event']) {
                      case 'pageStarted':
                        break;
                      // case 'interactive':
                      //   Loader.appLoader.hideLoader();
                      // break;
                      case 'DOMContentLoaded':
                        break;
                      case 'complete':
                        break;
                      case 'add-to-cart': // synchronous item added to cart and page about to reload
                        //Loader.appLoader.showLoader();
                        break;
                      case 'cart_updated': // ajax cart update
                        // print('cart updated');
                        break;
                      case 'cart_count':
                        GlobalStateController.state
                            .setCartValue(value: input['message']);
                        // print(input['message']);
                        break;
                      // case 'alert_triggered':
                      //   Scaffold.of(context).showSnackBar(SnackBar(
                      //       content: Text(
                      //     input['message'],
                      //     // overflow: TextOverflow.ellipsis,
                      //   )));
                      //   print(input['message']);
                      //   break;
                      default:
                    }
                  },
                ));
              }
            },
            onLoadError: (controller, uri, i, s) {
              GlobalStateController.state.setAddToCart(true);
              GlobalStateController.state.disposeWebview();
            },
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    Constants.appConfig.baseUrl + '?add-to-cart=' + id)),
            onLoadStart: (controller, uri) {
              // print('asd');
            },
            onLoadStop: (controller, uri) {
              // print(uri.data.toString());
              GlobalStateController.state.setAddToCart(true);
              GlobalStateController.state.disposeWebview();
            }));
  }
  void run() {
    headlessInAppWebView.run();
  }

  void dispose() {
    headlessInAppWebView.dispose();
  }
}
