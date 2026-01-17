//themeProvider
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/riverpod_provider/notifier/authnotifier.dart';
import 'package:riverpod/legacy.dart';

//themeProvider
final themeProvider = StateProvider<bool>((ref) {
  final box = Hive.box('auth');
  return box.get('darkmode', defaultValue: false);
});

//auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  return AuthNotifier();
});

//enums
enum AuthStatus { loading, isLoggedIn, intro, login, signup, loggingOut }
