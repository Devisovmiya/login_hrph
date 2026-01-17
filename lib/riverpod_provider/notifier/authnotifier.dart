// ignore_for_file: avoid_print

import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';
import 'package:riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthStatus> {
  //intial status loading

  AuthNotifier() : super(AuthStatus.loading) {
    _checkAuth();
  }
  //Hivebox instance
  final Box authBox = Hive.box('auth');

  //Authentication check function
  Future<void> _checkAuth() async {
    await Future.delayed(Duration(seconds: 2));
    final isLoggedIn = authBox.get('Loggedin', defaultValue: false);
    state = isLoggedIn ? AuthStatus.isLoggedIn : AuthStatus.intro;
  }

  //intro button navigation using  authstatus
  void goToLogin() => state = AuthStatus.login;
  void goToSignup() => state = AuthStatus.signup;

  //login function
  Future<void> login() async {
    //login process
    await authBox.put('Loggedin', true);

    state = AuthStatus.isLoggedIn;
  }

  //logout function
  Future<void> logout() async {
    // Simulate a delay for logging out

    state = AuthStatus.loggingOut;
    await Future.delayed(Duration.zero);

    await Future.delayed(Duration(seconds: 1));

    //logout process

    await authBox.put('Loggedin', false);
    state = AuthStatus.intro;
  }
}
