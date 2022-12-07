import 'package:flutter/widgets.dart';

class Loader {
  static final Loader appLoader = Loader(); // singleton
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> loaderTextNotifier = ValueNotifier('error message');

  void showLoader() {
    //using to show from anywhere
    loaderShowingNotifier.value = true;
  }

  void hideLoader() {
    //using to hide from anywhere
    if (loaderShowingNotifier.value) {
      loaderShowingNotifier.value = false;
    }
  }

  void setText({String errorMessage}) {
    // using to change error message from anywhere
    loaderTextNotifier.value = errorMessage;
  }

  void setImage() {
    // DIY
    // same as that of setText //
  }
}
