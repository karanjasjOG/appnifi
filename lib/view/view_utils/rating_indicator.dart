import 'package:flutter/material.dart';

class _IndicatorClipper extends CustomClipper<Rect> {
  final double ratingFraction;
  final bool rtlMode;

  _IndicatorClipper({
    this.ratingFraction,
    this.rtlMode = false,
  });

  @override
  Rect getClip(Size size) {
    return rtlMode
        ? Rect.fromLTRB(
            0,
            0.0,
            size.width,
            size.height,
          )
        : Rect.fromLTRB(
            0.0,
            0.0,
            size.width * ratingFraction,
            size.height,
          );
  }

  @override
  bool shouldReclip(_IndicatorClipper oldClipper) {
    return ratingFraction != oldClipper.ratingFraction ||
        rtlMode != oldClipper.rtlMode;
  }
}

class RatingBar extends StatelessWidget {
  // final double iconSize;
  final double rating;

  RatingBar({@required this.rating});

  List<Widget> _childer(int count, context) {
    int ratingNumber = rating.truncate(); //4
    double ratingFraction = (rating - ratingNumber) > 0 ? 0.5 : 0;
    return List.generate(count, (index) {
      return Stack(
        children: [
          index + 1 <= ratingNumber
              ? StarIcon(
                  // iconSize: iconSize,
                  )
              : ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).disabledColor,
                    BlendMode.srcIn,
                  ),
                  child: StarIcon(
                      // iconSize: iconSize,
                      ),
                ),
          if (index == ratingNumber)
            ClipRect(
              clipper: _IndicatorClipper(
                ratingFraction: ratingFraction,
              ),
              child: StarIcon(
                  // iconSize: iconSize,
                  ),
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(100, 0, 0, 0),
      // width: iconSize * 5.0,
      child: Row(
        children: _childer(5, context),
      ),
    );
  }
}

class StarIcon extends StatelessWidget {
  // final double iconSize;
  // StarIcon({@required this.iconSize});
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star,
      color: Colors.amberAccent,
      // size: iconSize,
    );
  }
}
