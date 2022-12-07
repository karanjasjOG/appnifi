import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';
import 'package:storematic_flutter/utils/constants.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  ErrorPage({@required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error.gif',
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
            ),
            AdaptiveText(
              text: errorMessage,
              minFontSize: 20,
              maxFontSize: 20,
              textColor: Colors.black87,
              fontWeight: FontWeight.bold,
              maxlines: 2,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Constants.appConfig.appTheme.appBarColorParsed,
                child: Text('Go back'),
                textColor:
                    Constants.appConfig.appTheme.sectionButtonFontColorParsed,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
