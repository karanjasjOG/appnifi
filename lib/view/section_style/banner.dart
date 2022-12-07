import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:storematic_flutter/models/item_data.dart';
import 'package:storematic_flutter/view/view_utils/section.dart';
// import 'package:storematic_flutter/design_elements/clickable_images.dart';
import 'package:storematic_flutter/view/view_utils/square_and_circular_card.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';

class MyBanner extends StatefulWidget {
  final ModelItemData data;
  // final double widthFactor = 1;
  // final double aspectRatio;
  // final double padding;
  // final double heightFactor;
  // final List<Map> imagesWithNavURL;
  // final Function onTapFunction;
  final int intervalInSeconds;
  MyBanner({@required this.data, this.intervalInSeconds = 10});
  @override
  _MyBannerState createState() => _MyBannerState();
}

class _MyBannerState extends State<MyBanner> {
  int _current = 0;
  List<Widget> items;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidthOfCard heightWidthOfCard = HeightWidthOfCard(
        screenWidth: MediaQuery.of(context).size.width, data: widget.data);
    List<Widget> items = createCustomCardList(
        data: widget.data, heightWidthOfCard: heightWidthOfCard);
    if (items.length == 1) {
      return Section(
        section: items[0],
        data: widget.data,
      );
    }

    return Section(
      data: widget.data,
      section: Stack(alignment: AlignmentDirectional.center, children: [
        CarouselSlider(
            items: items,
            options: CarouselOptions(
                viewportFraction: 1,
                // aspectRatio: 1.6,

                height: heightWidthOfCard.heightOfCard,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: widget.intervalInSeconds),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                })),
        Positioned(
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.map((item) {
              int index = items.indexOf(item);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(255, 255, 255, 0.9)
                      : Color.fromRGBO(255, 255, 255, 0.4),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
