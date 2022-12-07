import 'package:flutter/material.dart';

import 'loader_controller.dart';

class LoaderOverlayView extends StatefulWidget {
  LoaderOverlayView({Key key}) : super(key: key);

  @override
  _LoaderOverlayViewState createState() => _LoaderOverlayViewState();
}

class _LoaderOverlayViewState extends State<LoaderOverlayView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      //IMP , using ValueListenableBuilder for showing/removing overlay
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return Container(
            child: Container(
              color: Color.fromARGB(200, 255, 255, 255),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ); // your awesome overlay
        } else {
          return Container();
        }
      },
    );
  }
}
