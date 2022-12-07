import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_options.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ImageWidget extends StatelessWidget {
  final ItemsOptions itemsOptions;

  final HeightWidthOfCard heightWidthOfCard;
  final bool fromCategoryOrProduct;

  ImageWidget(
      {@required this.heightWidthOfCard,
      @required this.itemsOptions,
      this.fromCategoryOrProduct = false});
  @override
  Widget build(BuildContext context) {
    double cardPadding = heightWidthOfCard.cardPadding;
    if (fromCategoryOrProduct) cardPadding = 0;
    // print(imageUrl);
    return ClipRRect(
        borderRadius: BorderRadius.circular(cardPadding),
        child: Container(
          width: heightWidthOfCard.widthOfCard,
          height: heightWidthOfCard.heightOfCard,
          padding: EdgeInsets.all(cardPadding),
          child: itemsOptions.isCircular
              ? ClipRRect(
                  borderRadius:
                      BorderRadius.circular(heightWidthOfCard.borderRadius),
                  child: Container(
                      width: heightWidthOfCard.widthOfImageInCard,
                      height: heightWidthOfCard.heightOfImageInCard,
                      child: (itemsOptions.imageUrl == Constants.noImageUrl)
                          ? Image(
                              image: AssetImage('assets/images/no_image.png'),
                            )
                          : CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: itemsOptions.imageUrl,
                              placeholder: (context, url) {
                                return ShimmerLoader(
                                    heightWidthOfCard: heightWidthOfCard);
                              },
                            )),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(heightWidthOfCard.borderRadius),
                      child: Container(
                          // padding:
                          // EdgeInsets.all(heightWidthOfCard.cardPadding),
                          width: heightWidthOfCard.widthOfImageInCard,
                          height: heightWidthOfCard.heightOfImageInCard,
                          child: (itemsOptions.imageUrl == Constants.noImageUrl)
                              ? Image(
                                  image:
                                      AssetImage('assets/images/no_image.png'),
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: itemsOptions.imageUrl,
                                  placeholder: (context, url) {
                                    return ShimmerLoader(
                                        heightWidthOfCard: heightWidthOfCard);
                                  },
                                )),
                    ),
                    ImageTitle(
                        visible: fromCategoryOrProduct
                            ? false
                            : itemsOptions.showTitle,
                        title: itemsOptions.title,
                        height:
                            heightWidthOfCard.availableHeightForEachBottomItem)
                  ],
                ),
        ));
  }
}

class ImageTitle extends StatelessWidget {
  final bool visible;

  final String title;

  final double height;

  ImageTitle({
    @required this.visible,
    @required this.title,
    @required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
          height: height,
          child: AdaptiveText(
            text: title,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.normal,
            minFontSize: (height * 0.7).truncate().toDouble(),
            maxFontSize: (height * 0.9).truncate().toDouble(),
            textColor: Colors.black,
          )),
    );
  }
}

class ShimmerLoader extends StatelessWidget {
  final HeightWidthOfCard heightWidthOfCard;
  final String error;
  final bool isError;
  ShimmerLoader(
      {@required this.heightWidthOfCard,
      this.error = '',
      this.isError = false});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: isError ? Colors.black : Colors.white,
        highlightColor: Colors.grey[100],
        period: Duration(milliseconds: 1000),
        child: (isError)
            ? Center(child: Text(error))
            : Container(
                // width: 30,
                // height: 30,
                color: Colors.white,
                // child: (isError) ?  : Text('...'),
              )
        // gradient: LinearGradient(colors: [Colors.white, Colors.black])
        );
  }
}
