import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/json_keys.dart';

class DrawerItem {
  final String title;
  final String navUrl;
  const DrawerItem._({@required this.navUrl, @required this.title});

  factory DrawerItem(Map json) {
    return DrawerItem._(
        navUrl: json[ConfigJsonKeys.link], title: json[ConfigJsonKeys.title]);
  }
}
