import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAbout {
  static Widget about = Container(
    padding: EdgeInsets.only(top: 20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Constants.appConfig.title,
            textScaleFactor: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Build: ${Constants.packageInfo.buildNumber} v${Constants.packageInfo.version}',
              style: TextStyle(color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                'assets/images/logo.png',
                // height: 80,
                // fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              Constants.appConfig.aboutShop.isEmpty
                  ? '© 2021 ${Constants.appConfig.title}'
                  : Constants.appConfig.aboutShop,
              style: TextStyle(color: Colors.black38),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: InkWell(
              onTap: () async {
                if (await canLaunch(Constants.appConfig.poweredByLink)) {
                  await launch(
                    Constants.appConfig.poweredByLink,
                  );
                } else {
                  print('not able to launch ');
                }
              },
              child: Text(
                Constants.appConfig.poweredBy,
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  // constructor
  static void dialog({@required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return SimpleDialog(
          children: [about],
        );
      },
    );
  }
}
