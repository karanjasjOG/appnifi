import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:storematic_flutter/controller/data_controller.dart';

import 'package:storematic_flutter/utils/woo_api.dart';
import 'package:storematic_flutter/view/section_style/slider.dart';
import 'package:storematic_flutter/view/section_style/grid.dart';
import 'package:storematic_flutter/view/section_style/banner.dart';
import 'package:storematic_flutter/view/view_utils/body.dart';

import 'package:storematic_flutter/view/view_utils/linear_loader.dart';
import 'package:storematic_flutter/view/view_utils/view_cart_strip.dart';

class HomePage extends StatefulWidget {
  final int numberOfItemsInCart;
  HomePage({@required this.numberOfItemsInCart});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  List relodedData = [];
  Future future;
  String api = WooApi.homePage();
  bool isReloded = false;

  @override
  void initState() {
    super.initState();

    future = DataController.homePage(api);
  }

  Future<void> pullToRefresh() async {
    List tempData = await DataController.homePage(api);
    // print(api);
    isReloded = true;
    setState(() {
      data = tempData;
      relodedData = tempData;
      future = DataController.homePage(api);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: pullToRefresh,
      child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data;
              if (isReloded) {
                data = relodedData;
                isReloded = false;
              }
              return HomePageListView(
                data: data,
                showIndicator: false,
                numberOfItemsInCart: widget.numberOfItemsInCart,
              );
            } else {
              data = [];

              return HomePageListView(
                data: [],
                showIndicator: true,
                numberOfItemsInCart: widget.numberOfItemsInCart,
              );
            }
          }),
    );
  }
}

class HomePageListView extends StatelessWidget {
  const HomePageListView(
      {@required this.data,
      @required this.showIndicator,
      @required this.numberOfItemsInCart,
      Key key})
      : super(key: key);
  final List data;
  final bool showIndicator;
  final int numberOfItemsInCart;

  @override
  Widget build(BuildContext context) {
    return MyBody(
        myChild: Container(
      child: Column(
        children: [
          LinearLoader(showIndicator: showIndicator),
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var sectionStyle = data[index].sectionStyleBool;

                  // print(index);
                  if (sectionStyle.isSlider) {
                    return MySlider(data: data[index]);
                  } else if (sectionStyle.isGrid) {
                    return MyGrid(data: data[index]);
                  } else if (sectionStyle.isBanner) {
                    return MyBanner(data: data[index]);
                    // Banner(message: null, location: null)
                  } else {
                    return Container(
                      color: Colors.amberAccent,
                    );
                  }
                }),
          ),
        ],
      ),
    ));
  }
}
