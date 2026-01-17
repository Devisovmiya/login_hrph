import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/bottomnav/tabs/home_layout/widgets/sliver_appbar.dart';
import 'package:login_hrph/utilis/greeting_utils.dart';
import 'package:login_hrph/widgets/drawer/homedrawer.dart';

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

    //greetings logic
    final greetings = getGreetings();
    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),

        /* appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          elevation: 25,
          centerTitle: true,
          title: Text('Daily Hub'),
        ), */
        body: CustomScrollView(slivers: [homeappBar(username: username, greetings: greetings)]),
      ),
    );
  }
}
