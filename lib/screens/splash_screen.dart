import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Duration time;
  final Function onFinish;

  const SplashScreen({
    Key key,
    this.time,
    this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    Future.delayed(time, () {
      onFinish();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/logo-petcommunity.png",
                width: _width * 0.7,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/logo-colmenadev.png",
                width: _width * 0.6,
              )
            )
          ],
        ),
      ),
    );
  }
}