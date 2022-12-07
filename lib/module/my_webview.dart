import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:storematic_flutter/utils/global_state_controller.dart';
import 'package:storematic_flutter/utils/my_routes.dart';
import 'package:storematic_flutter/utils/constants.dart';
import 'package:storematic_flutter/utils/my_loader/loader_controller.dart';
import 'package:storematic_flutter/utils/my_loader/loading_overlay_view.dart';
import 'package:storematic_flutter/view/view_utils/linear_loader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MyWebViewState { STARTED, NOT_STARTED, FINISHED }

class MyWebView extends StatefulWidget {
  final String url;
  MyWebView({Key key, @required this.url}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool _progressVisible = true;
  bool _webViewVisible = true;
  WebViewController webViewController;

  // Widget linearProgressBar =
  MyWebViewState webViewState = MyWebViewState.NOT_STARTED;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  FutureOr<NavigationDecision> navigationDelegate(
      BuildContext context, NavigationRequest request) {
    /**
         * Need to work on urls with query params (eg. ?add-to-cart=3030)
         * Delegate should prevent urls with query params to get opened as new webpage 
         * instead let it open on the same webpage and start the progress bar
         */
    // print('req:${request.url} def:${widget.url}');
    // isQueryUrl(defined: widget.url, request: request.url);
    if (!request.url.startsWith(Constants.appConfig.baseUrl)) {
      // check if url is not the base website
      if (canLaunch(request.url) != null) {
        // open links in other app
        launch(request.url);
      }
      return NavigationDecision.prevent;
    }
    if (request.url == Constants.appConfig.baseUrl) {
      // if user tried to visit homepage then pop the screen
      Navigator.pop(context);
      return NavigationDecision.prevent;
    } else if (request.url == widget.url + '/') {
      // if the navigation is for current url just let it navigate
      return NavigationDecision.navigate;
    } else if (request.url.startsWith(widget.url)) {
      // url with query params
      setState(() {
        _progressVisible = true;
      });
      return NavigationDecision.navigate;
    }
    MyRoutes.pushWebPage(
      context: context,
      path: 'misc',
      isMisc: true,
      pathUrl: request.url,
    );
    /* Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Webpage(title: "", url: request.url)),
    ); */
    return NavigationDecision.prevent;
  }

  ///
  ///
  ///
  void _resourceError(WebResourceError error) {
    switch (error.errorType) {
      case WebResourceErrorType.badUrl:
      case WebResourceErrorType.failedSslHandshake:
      case WebResourceErrorType.hostLookup:
      case WebResourceErrorType.io:
      //case WebResourceErrorType.redirectLoop:
      case WebResourceErrorType.connect:
        setState(() {
          _webViewVisible = false;
        });
        break;
      default:
    }
    print('resource error:${error.errorType}');
  }

  Future<void> getCookies() async {
    var cookies = await webViewController.evaluateJavascript('document.cookie');
    Constants.cookies = cookies;
    print('cookies :' + cookies);
    // webViewController.evaluateJavascript(
    //     "STM_HANDLER.postMessage('{'event':'cookies','message':document.cookie}');");
  }

  void saveCookies(String cookies) {
    Constants.cookies = cookies;
  }

  JavascriptChannel _javascriptChannel() {
    // check why tf its causing issues when enabled
    // issue: when enabled onclick any link loads multiple webpage
    // Note: solved - see comment below

    /**
     * added a click listener on ".cart button" class for listening non ajax adding of products to cart
     * Thus this can solve the problem of progress bar 
     */

    return JavascriptChannel(
        name: 'STM_HANDLER',
        onMessageReceived: (JavascriptMessage message) {
          var input = jsonDecode(message.message);
          print('${input["event"]} jschannel event');

          switch (input['event']) {
            case 'pageStarted':
              break;
            case 'interactive':
              Loader.appLoader.hideLoader();
              break;
            case 'DOMContentLoaded':
              break;
            case 'complete':
              break;
            case 'add-to-cart': // synchronous item added to cart and page about to reload
              //Loader.appLoader.showLoader();
              break;
            case 'cart_updated': // ajax cart update
              // print('cart updated');
              break;
            case 'cart_count':
              GlobalStateController.state.setCartValue(value: input['message']);
              // print(input['message']);
              break;
            case 'alert_triggered':
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                input['message'],
                // overflow: TextOverflow.ellipsis,
              )));
              print(input['message']);
              break;
            default:
          }
        });
  }

  ///////////////////////////////////////
  /// Flutter webview widget defintion
  //////////////////////////////////////
  Widget _webView() {
    return WebView(
      debuggingEnabled: false, // turn off in production
      javascriptMode: JavascriptMode.unrestricted,
      userAgent: Constants
          .webViewUserAgent, // contains "storematic" appended at end for validating req from webview
      navigationDelegate: (NavigationRequest request) {
        // print('navigation triggered');
        return navigationDelegate(context, request);
      },

      javascriptChannels: <JavascriptChannel>[
        _javascriptChannel(),
      ].toSet(),
      initialUrl: widget.url,
      onWebViewCreated: (controller) {
        webViewController = controller;

        //controller.clearCache();
        //controller.loadUrl(widget.url);
      },
      onPageStarted: (url) {
        // on page started
        webViewState = MyWebViewState.STARTED;

        if (!_progressVisible) {
          setState(() {
            _progressVisible = true;
          });
        }
        // print('started:$url');
      },
      onPageFinished: (url) {
        // on page finished
        if (webViewState != MyWebViewState.STARTED) {
          return;
        }
        // print('finished:$url');
        Loader.appLoader.hideLoader();
        setState(() {
          _progressVisible = false;
        });
        // getCookies(); // inject js that sends cookies event
      },
      onWebResourceError: (error) => _resourceError(error),
    );
  }

  //////////////////////////////
  /// Widget Tree Build method
  /// //////////////////////////
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearLoader(showIndicator: _progressVisible),
              Visibility(
                visible: _webViewVisible,
                replacement: Expanded(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/error.gif',
                            height: MediaQuery.of(context).size.width * 0.6,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Failed to load. Please Check your internet connection and try again.',
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.2,
                              softWrap: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: OutlineButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _webViewVisible = true;
                                  });
                                },
                                color: Constants
                                    .appConfig.appTheme.appBarColorParsed,
                                highlightedBorderColor: Constants
                                    .appConfig.appTheme.appBgColorParsed,
                                icon: Icon(Icons.replay),
                                label: Text('Retry')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: Expanded(
                  child: _webView(),
                ),
              ),
            ],
          ),
        ),
        LoaderOverlayView(),
      ],
    );
  }
}
