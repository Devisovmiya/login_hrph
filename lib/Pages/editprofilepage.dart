import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late TextEditingController usernameCtrl;
  late String gender;

  @override
  void initState() {
    super.initState();
    final box = Hive.box('auth');
    final List users = box.get('users', defaultValue: []);
    final currentEmail = box.get('current_user_email');

    final user = users.firstWhere(
      (u) => u.email == currentEmail,
      orElse: () => null,
    );

    usernameCtrl = TextEditingController(text: user?.username ?? "");
    gender = ["Male", "Female", ].contains(user?.gender) ? user!.gender : "Male";

  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('auth');
    final List users = box.get('users', defaultValue: []);
    final currentEmail = box.get('current_user_email');

    //to get thecurrent user index
    final userIndex = users.indexWhere((u) => u.email == currentEmail);
    final user = users[userIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: usernameCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: gender.isNotEmpty ? gender : "Male",
              decoration: const InputDecoration(labelText: "Gender"),
              items: [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ],
              onChanged: (value) {
                setState(() => gender = value!);
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // Update user info
                user.username = usernameCtrl.text;
                user.gender = gender;

                // Save back to list
                users[userIndex] = user;
                box.put('users', users);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile updated successfully")),
                );

                Navigator.pop(context);
              },
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}
