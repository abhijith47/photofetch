import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  navigate() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/homepage', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/logo_icon.jpeg',
                fit: BoxFit.fitHeight,
                height: 50,
              ),
            ),
            LottieBuilder.asset(
              'assets/animations/splash_loader.json',
              height: 70,
              width: 100,
            )
          ],
        ),
      ),
    );
  }
}
