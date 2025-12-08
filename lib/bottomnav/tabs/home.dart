
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = Hive.box('auth');
    final List users = box.get('users', defaultValue: []);
    //getting current_user_email
    final currentemail = box.get('current_user_email');

    //find the match user
    final user = users.firstWhere(
      (u) => u.email == currentemail,
      orElse: () => null,
    );

    //get the current user

    final username = user?.username ?? 'User';

    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.home_filled), title: Text('Home')),
      body: Center(
        child: Text('Welcome $username',
        style: TextStyle(fontWeight: FontWeight.w600,
        fontSize: 26,
        fontStyle: FontStyle.italic),
        ),
      )
    );
  }
}
