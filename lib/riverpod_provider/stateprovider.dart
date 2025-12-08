//themeProvider
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/legacy.dart';

//themeProvider
final themeProvider = StateProvider<bool>((ref) {
  final box = Hive.box('auth');
  return box.get('darkmode', defaultValue: false);
});

//auth Provider
final authProvider = StateProvider<bool>((ref) {
  final box = Hive.box('auth');
  return box.get('loggedin', defaultValue: false);
});
