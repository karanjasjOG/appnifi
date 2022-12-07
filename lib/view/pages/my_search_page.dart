import 'package:flutter/material.dart';

import 'package:storematic_flutter/controller/data_controller.dart';

import 'package:storematic_flutter/utils/my_routes.dart';
import 'package:storematic_flutter/utils/woo_api.dart';
import 'package:storematic_flutter/view/view_utils/dimensions.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    if (query.length > 2) {
      String api = WooApi.searchProducts(search: query);
      return FutureBuilder(
          future: DataController.searchPage(api),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var response = snapshot.data;
              if (response.length > 0) {
                return Container(
                    child: ListView.builder(
                        itemCount: response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomListItem(response: response[index]);
                        }));
              } else {
                return NoResultOrError();
              }
            } else if (snapshot.hasError) {
              return NoResultOrError(
                isError: true,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else {
      return NoResultOrError();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length > 2) {
      String api = WooApi.searchProducts(search: query);

      // TODO check if api is null or empty

      return FutureBuilder(
          future: DataController.searchPage(api),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var response = snapshot.data;
              if (response.length > 0) {
                return Container(
                    child: ListView.builder(
                        itemCount: response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomListItem(response: response[index]);
                        }));
              } else {
                return NoResultOrError();
              }
            } else if (snapshot.hasError) {
              return NoResultOrError(
                isError: true,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else {
      return Container();
    }
  }
}

class NoResultOrError extends StatelessWidget {
  NoResultOrError({this.isError = false});
  final bool isError;
  final String noResultsMessage =
      'No results found! Please try again with different keywords and terms.';
  final String errorMessage =
      'Error while searching. Please check your internet connection.';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.sentiment_dissatisfied_rounded,
            size: 100,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            isError ? errorMessage : noResultsMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({this.response});

  final response;

  @override
  Widget build(BuildContext context) {
    // var response;
    return InkWell(
      onTap: () {
        MyRoutes.pushWebPage(
            context: context,
            path: 'misc',
            isMisc: true,
            pathUrl: response.navUrl);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 5),
                  // color: Colors.black,
                  height: MediaQuery.of(context).size.width * 0.2 - 5,
                  width: MediaQuery.of(context).size.width * 0.2 - 5,
                  child: Image.network(response.imageUrl, fit: BoxFit.fill),
                ),
              ),
            ),
            Expanded(
              // flex: 3,
              child: TitleAndSubtitle(
                response: response,
              ),
            ),
            Transform.rotate(
                angle: 345,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_upward_sharp,
                    color: Colors.black54,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class TitleAndSubtitle extends StatelessWidget {
  const TitleAndSubtitle({Key key, @required this.response}) : super(key: key);

  final response;

  @override
  Widget build(BuildContext context) {
    // var response;
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AdaptiveText(
            text: response.title,
            fontWeight: FontWeight.w500,
            minFontSize: 20.0,
            maxFontSize: 20,
            textColor: Colors.black87,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          AdaptiveText(
            text: response.subtitle,
            textColor: Colors.blueAccent,
            // fontWeight: FontWeight.w500,
            minFontSize: 14,
            maxFontSize: 14,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
        ],
      ),
    );
  }
}
