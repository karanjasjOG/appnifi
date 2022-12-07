import 'package:flutter/material.dart';
import 'package:storematic_flutter/view/view_utils/view_cart_strip.dart';

class MyBody extends StatelessWidget {
  final bool showViewStrip;
  final Widget myChild;
  MyBody({@required this.myChild, this.showViewStrip = true});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        myChild,
        ViewCartStrip(
          visible: showViewStrip,
        )
      ],
    );
  }
}
