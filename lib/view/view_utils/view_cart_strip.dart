import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/global_state_controller.dart';
import 'package:storematic_flutter/utils/my_routes.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';

class ViewCartStrip extends StatelessWidget {
  final bool visible;
  ViewCartStrip({this.visible = true});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: GlobalStateController.state.cartValue,
      builder: (context, value, child) {
        ViewCartStripDimensions dimensions = ViewCartStripDimensions(context);
        return Visibility(
          visible: Constants.appConfig.showViewCartStrip && value > 0 && visible
              ? true
              : false,
          child: InkWell(
            onTap: () {
              MyRoutes.pushWebPage(
                  context: context, path: 'cart', isCart: true);
            },
            child: Container(
              height: dimensions.heightOfStrip,
              width: dimensions.widthOfStrip,
              color: Constants.appConfig.appTheme.appBarColorParsed,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: AdaptiveText(
                        text: '$value Item',
                        minFontSize: dimensions.fontSizeLeading,
                        maxFontSize: dimensions.fontSizeLeading,
                        textColor: Constants
                            .appConfig.appTheme.sectionButtonFontColorParsed,
                      ),
                    ),
                    Row(
                      children: [
                        AdaptiveText(
                          text: 'View Cart',
                          minFontSize: dimensions.fontSizeActions,
                          maxFontSize: dimensions.fontSizeActions,
                          textColor: Constants
                              .appConfig.appTheme.sectionButtonFontColorParsed,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Constants.appConfig.appTheme
                                .sectionButtonFontColorParsed,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
