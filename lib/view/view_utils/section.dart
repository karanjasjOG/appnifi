import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_data.dart';

Map alignment = {
  'top_left': Alignment.topLeft,
  'top_center': Alignment.topCenter,
  'top_right': Alignment.topRight,
  'center_left': Alignment.centerLeft,
  'center': Alignment.center,
  'center_right': Alignment.centerRight,
  'bottom_left': Alignment.bottomLeft,
  'bottom_center': Alignment.bottomCenter,
  'bottom_right': Alignment.bottomRight
};

class Section extends StatelessWidget {
  final Widget section;
  final ModelItemData data;
  Section({@required this.data, @required this.section});
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: !data.sectionBool.isHidden,
        child: Container(
          margin: EdgeInsets.only(
              top: data.sectionMarginTop, bottom: data.sectionMarginBottom),
          padding: EdgeInsets.only(
              top: data.sectionPaddingTop, bottom: data.sectionPaddingBottom),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: alignment[data.gradientStart],
                  end: alignment[data.gradientEnd],
                  colors: [data.sectionBgColorStart, data.sectionBgColorEnd])),
          child: section,
        ));
  }
}
