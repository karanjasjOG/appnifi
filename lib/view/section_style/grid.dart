import 'package:flutter/material.dart';
import 'package:storematic_flutter/models/item_data.dart';
import 'package:storematic_flutter/view/view_utils/section.dart';

import 'package:storematic_flutter/view/view_utils/section_header.dart';
import 'package:storematic_flutter/view/view_utils/square_and_circular_card.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';

class GridList {
  List<Widget> columnList = [];

  GridList({@required List<Widget> items, @required int numOfColumn}) {
    // print(items.length);
    // print(numOfColumn);
    List<Widget> rowList = [];
    for (var item in items) {
      if ((items.indexOf(item) + 1).remainder(numOfColumn) == 0) {
        rowList.add(item);
        var row = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowList,
        );
        columnList.add(row);
        // print(columnList);
        rowList = [];
      } else {
        rowList.add(item);
        // print(rowList[1]);
      }
    }
    if (items.length < numOfColumn) {
      columnList = items;
    }
  }
}

class MyGrid extends StatelessWidget {
  final ModelItemData data;
  // final double aspectRatio;
  MyGrid({@required this.data});

  @override
  Widget build(BuildContext context) {
    HeightWidthOfCard heightWidthOfCard = HeightWidthOfCard(
        screenWidth: MediaQuery.of(context).size.width, data: data);
    List<Widget> items =
        createCustomCardList(data: data, heightWidthOfCard: heightWidthOfCard);
    return Section(
      data: data,
      section: Column(
        children: [
          SectionHeader(
            sectionHeading: data.sectionHeading,
            sectionNavUrl: data.sectionNavUrl,
            hideSectionHeader: data.sectionBool.hideSectionHeader,
            sectionHeaderTitleColor: data.sectionHeaderTitleColor,
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: GridList(items: items, numOfColumn: data.numOfColumn)
                .columnList,
          )
        ],
      ),
    );
  }
}
