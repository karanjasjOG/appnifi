import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/view/pages/my_search_page.dart';
import 'package:storematic_flutter/view/pages/my_category_page.dart';

class AppBarBottom extends StatelessWidget {
  final String searchQuery;
  final double appBarHeight;
  AppBarBottom({@required this.searchQuery, @required this.appBarHeight});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Constants.appConfig.showCarticon,
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: Search());
        },
        child: Row(children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Container(
                height: appBarHeight * 0.4,
                //  Search Bar
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Icon(
                                    Icons.search_outlined,
                                    color: Colors.black38,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    searchQuery,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: IconButton(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyCategoryPage()),
                            );
                          },
                          icon: Icon(Icons.category_rounded),
                          color: Colors.black38,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
