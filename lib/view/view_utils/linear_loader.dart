import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';

class LinearLoader extends StatelessWidget {
  final bool showIndicator;
  // final Color bgColor;
  // final Color animationColor;

  LinearLoader({@required this.showIndicator});
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: showIndicator,
        child: LinearProgressIndicator(
          backgroundColor: Constants.appConfig.appTheme.appBarColorParsed,
          valueColor: new AlwaysStoppedAnimation(Colors.white),
        ));
  }
}
