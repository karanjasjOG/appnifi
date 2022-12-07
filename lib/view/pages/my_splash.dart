import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:storematic_flutter/main.dart';
import 'package:storematic_flutter/utils/app_configuration.dart';
import 'package:storematic_flutter/module/storematic_store.dart';

class Splash extends StatelessWidget {
  final bool demo;
  Splash(this.demo);
  Future<Widget> loadAppConfig(context) async {
    await fetchAppConfiguration(demo: false);

    return StorematicStore();
  }

  @override
  Widget build(BuildContext context) {
    return demo
        ? SplashScreen(
            seconds: 2,
            navigateAfterSeconds: MyQR(),
            // navigateAfterSeconds: Duration(seconds: 1),
            // navigateAfterFuture: Future.delayed(Duration(seconds: 1), () {
            //   return '0';
            // }),
            image: Image.asset(
              'assets/images/demo_logo.png',
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            photoSize: 150,
            backgroundColor: Colors.white,
            loaderColor: Colors.blueAccent,
            pageRoute: PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => MyQR(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          )
        : SplashScreen(
            navigateAfterFuture: loadAppConfig(context),
            image: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            photoSize: 150,
            backgroundColor: Colors.white,
            loaderColor: Colors.blueAccent,
            pageRoute: PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  StorematicStore(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
  }
}
