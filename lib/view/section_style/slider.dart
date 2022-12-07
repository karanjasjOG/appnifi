import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_data.dart';

import 'package:storematic_flutter/view/view_utils/dimensions.dart';
import 'package:storematic_flutter/view/view_utils/section.dart';
import 'package:storematic_flutter/view/view_utils/square_and_circular_card.dart';
import 'package:storematic_flutter/view/view_utils/section_header.dart';

class MySlider extends StatelessWidget {
  final ModelItemData data;

  MySlider({@required this.data});

  @override
  Widget build(BuildContext context) {
    HeightWidthOfCard heightWidthOfCard = HeightWidthOfCard(
        screenWidth: MediaQuery.of(context).size.width, data: data);

    List<Widget> items =
        createCustomCardList(data: data, heightWidthOfCard: heightWidthOfCard);

    return Section(
      data: data,
      section: Column(children: [
        SectionHeader(
          sectionHeading: data.sectionHeading,
          sectionNavUrl: data.sectionNavUrl,
          hideSectionHeader: data.sectionBool.hideSectionHeader,
          sectionHeaderTitleColor: data.sectionHeaderTitleColor,
        ),
        Container(
          height: heightWidthOfCard.heightOfSlider,
          child: ListView.builder(
              // shrinkWrap: true,
              // padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return items[index];
              }),
        ),
      ]),
    );
  }
}
