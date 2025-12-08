import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/Pages/editprofilepage.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = Hive.box('auth');
    final List users = box.get('users', defaultValue: []);
    //getting current_user_email
    final currentemail = box.get('current_user_email');

    //find the match user
    // Find the user object
    final user = users.firstWhere(
      (u) => u.email == currentemail,
      orElse: () => null,
    );

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person_2),
          title: const Text('Profile'),
        ),
        body: const Center(child: Text("No user data found")),
      );
    }

    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.person_2), title: Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile Info', style: const TextStyle(fontSize: 30)),
            SizedBox(height: 15),

            Text(
              "NAME:  ${user.username}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              "MAIL ID: ${user.email}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text("GENDER:${user.gender}", style: const TextStyle(fontSize: 20)),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                );
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
