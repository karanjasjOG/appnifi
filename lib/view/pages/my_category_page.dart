import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storematic_flutter/controller/data_controller.dart';
import 'package:storematic_flutter/utils/woo_api.dart';
import 'package:storematic_flutter/view/pages/my_webpage.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/section_style/grid.dart';
import 'package:storematic_flutter/view/view_utils/square_and_circular_card.dart';

class MyCategoryPage extends StatefulWidget {
  @override
  _MyCategoryPageState createState() => _MyCategoryPageState();
}

class _MyCategoryPageState extends State<MyCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.appConfig.appTheme.appBarColorParsed,
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'All Categories',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.left,
          ),
        ),
        body: FutureBuilder(
          future: DataController.categoryPage(WooApi.allCategoryPage()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null)
                return Container(
                  child: Text('null'),
                );
              return ListView(children: [MyGrid(data: snapshot.data)]);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error while fetching data!'),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
