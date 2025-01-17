import 'dart:async';

import 'package:bmicalculator/app/app.routes.dart';
import 'package:bmicalculator/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedImage(),
              Text('Healthy Options',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ));
  }
}

class AnimatedImage extends StatefulWidget {
  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>

    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat(reverse: true);
  late Animation<Offset> _animation = Tween(
          begin: Offset.zero, end: Offset(0, 0.08))
      .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushNamed(AppRoutes.HomeRoute));
    super.initState();
  }
  final String assetName = 'assets/girl.svg';

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: SvgPicture.asset(
        assetName,
        semanticsLabel: 'Acme Logo',
        width: MediaQuery.of(context).size.width*0.5,
        height: MediaQuery.of(context).size.width*0.5,
      ),
      );

  }
}
