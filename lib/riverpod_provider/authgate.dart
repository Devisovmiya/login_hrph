// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/Pages/homescreen.dart';
import 'package:login_hrph/Pages/loginscreen.dart';
import 'package:login_hrph/riverpod_provider/stateprovider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final islogged = ref.watch(authProvider);
    return islogged ? HomeScreen() : LoginScreen();
  }
}
