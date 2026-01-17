import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loadingsplashscreen extends StatelessWidget {
  const Loadingsplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset('assets/animation/loading.json')),
    );
  }
}
