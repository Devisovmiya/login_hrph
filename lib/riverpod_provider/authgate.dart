// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:login_hrph/Pages/authScreens/introscreen.dart';
import 'package:login_hrph/Pages/authScreens/loadingsplashscreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/Pages/authScreens/logoutsplashscreen.dart';
import 'package:login_hrph/Pages/homescreen.dart';
import 'package:login_hrph/Pages/loginscreen.dart';
import 'package:login_hrph/Pages/signupscreen.dart';
import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(authProvider);

    switch (status) {
      case AuthStatus.loading:
        return Loadingsplashscreen();
      case AuthStatus.isLoggedIn:
        return HomeScreen();

      //intro button navigation using  authstatus

      case AuthStatus.login:
        return LoginScreen();
      case AuthStatus.signup:
        return SignUpScreen();

      case AuthStatus.loggingOut:
        return LogoutSplashScreen();
      case AuthStatus.intro:
        return IntroScreen();
    }
  }
}
