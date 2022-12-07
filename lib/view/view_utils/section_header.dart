import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/my_routes.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(
      {Key key,
      @required this.sectionHeading,
      @required this.sectionNavUrl,
      @required this.sectionHeaderTitleColor,
      this.hideSectionHeader = false})
      : super(key: key);
  final bool hideSectionHeader;
  final String sectionHeading;
  final String sectionNavUrl;
  final Color sectionHeaderTitleColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !hideSectionHeader,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionHeading,
              style: TextStyle(
                  fontSize: 24,
                  color: sectionHeaderTitleColor,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                MyRoutes.pushWebPage(
                    context: context,
                    path: 'misc',
                    isMisc: true,
                    pathUrl: sectionNavUrl);
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    Constants.appConfig.appTheme.sectionButtonColorParsed,
              ),
              child: Text(
                'View all',
                style: TextStyle(
                    color: Constants
                        .appConfig.appTheme.sectionButtonFontColorParsed),
              ),
            )
          ],
        ),
      ),
    );
  }
}
