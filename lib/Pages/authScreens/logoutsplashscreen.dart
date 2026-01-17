import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class LogoutSplashScreen extends ConsumerStatefulWidget {
  const LogoutSplashScreen({super.key});
  @override
  ConsumerState<LogoutSplashScreen> createState() {
    return _LogoutSplashScreen();
  }
}

class _LogoutSplashScreen extends ConsumerState<LogoutSplashScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Lottie.asset(
              'assets/animation/logout.json',
              width: 400,
              height: 400,
            ),
          ),
          Text(
            "Logging Out...",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
