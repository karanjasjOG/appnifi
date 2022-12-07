import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:storematic_flutter/module/storematic_store.dart';
import 'package:storematic_flutter/theme/my_theme.dart';
import 'package:storematic_flutter/utils/app_configuration.dart';
import 'package:storematic_flutter/view/pages/my_splash.dart';

void main() {
  final bool demo = false;
  // int.parse(String.fromEnvironment('DEMO', defaultValue: '0')) == 1
  //     ? true
  //     : true;
  runApp(MaterialApp(
    // theme: MyTheme().theme,
    title: 'Storematic App',
    home: Splash(demo),
    debugShowCheckedModeBanner: false,
  ));
}

class MyQR extends StatefulWidget {
  const MyQR({Key key}) : super(key: key);

  @override
  _MyQRState createState() => _MyQRState();
}

class _MyQRState extends State<MyQR> {
  bool replaceToStore = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return replaceToStore
        ? StorematicStore()
        : Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text('Scan'),
                  ),
                )
              ],
            ),
          );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await fetchAppConfiguration(
          demo: true, baseUrl: 'https://ratnastore.in/');
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return StorematicStore();
      // }));
      setState(() {
        replaceToStore = true;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
