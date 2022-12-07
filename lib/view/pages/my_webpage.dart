import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:storematic_flutter/module/my_webview.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/app_bar/my_badge.dart';
import 'package:storematic_flutter/view/view_utils/body.dart';

class Webpage extends StatefulWidget {
  final String title, url;
  final bool hideCartIcon;
  Webpage(
      {@required this.title,
      @required this.url,
      this.hideCartIcon = false,
      Key key})
      : super(key: key);

  @override
  _WebpageState createState() => _WebpageState();
}

class _WebpageState extends State<Webpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Constants.appConfig.appTheme.appBarColorParsed,
          centerTitle: false,
          leading: IconButton(
            color: Constants.appConfig.appTheme.sectionButtonFontColorParsed,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.title,
            style: TextStyle(
                color:
                    Constants.appConfig.appTheme.sectionButtonFontColorParsed),
          ),
          actions: <Widget>[
            // Actions
            Visibility(
              visible: !widget.hideCartIcon,
              child: IconButton(
                color:
                    Constants.appConfig.appTheme.sectionButtonFontColorParsed,
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: MyBadge(),
                ),
                onPressed: () {},
              ),
            ),
          ]),
      body: MyBody(
        myChild: MyWebView(url: widget.url),
        showViewStrip:
            widget.url.endsWith('cart') || widget.url.endsWith('checkout')
                ? false
                : true,
      ),
    );
  }
}
