import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/riverpod_provider/provider/edit_profile/edit_profile_form_provider.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late String gender;
  DateTime? pickedDate;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = Hive.box('auth');
      final List users = box.get('users', defaultValue: []);
      final currentEmail = box.get('current_user_email');

      final user = users.firstWhere(
        (u) => u.email == currentEmail,
        orElse: () => null,
      );

      if (user != null) {
        ref.read(editProfileFormProvider.notifier).loadUser(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(editProfileFormProvider);
    final reset = ref.read(editProfileFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //UserName
              TextFormField(
                initialValue: form.username,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Username',
                ),
                onChanged: reset.setUsername,
              ),

              const SizedBox(height: 20),
              //Email
              TextFormField(
                initialValue: form.email,

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Email*',
                ),
                validator: (v) => v != null && v.contains('@gmail.com')
                    ? null
                    : 'Invalid Email',
                onChanged: reset.setEmail,
              ),

              //phoneNumber
              const SizedBox(height: 20),
              TextFormField(
                initialValue: form.phnum,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Phone Number*',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter your phone number';
                  } else if (value.length < 10) {
                    return 'enter valid phonenumber';
                  }
                  return null;
                },
                onChanged: reset.setphonenum,
              ),

              //city
              const SizedBox(height: 20),
              TextFormField(
                initialValue: form.city,
                decoration: InputDecoration(
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'City*',
                ),
                validator: (v) => v != null && v.isNotEmpty ? null : 'Required',
                onChanged: reset.setCity,
              ),

              const SizedBox(height: 20),

              //gender
              DropdownButtonFormField<String>(
                dropdownColor: Color.fromARGB(255, 160, 190, 214),
                initialValue: form.gender,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  labelText: "Gender",
                ),
                items: [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                  DropdownMenuItem(value: "Others", child: Text("Others")),
                ],
                onChanged: (value) {
                  reset.setGender(value!);
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () => _saveProfile(),
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProfile() {
    final box = Hive.box('auth');
    final List users = box.get('users', defaultValue: []);
    final currentEmail = box.get('current_user_email');

    final index = users.indexWhere((u) => u.email == currentEmail);
    final user = users[index];

    final form = ref.read(editProfileFormProvider);

    user.username = form.username;
    user.email = form.email;
    user.phnum = form.phnum;
    user.city = form.city;
    user.dob = form.dob;
    user.gender = form.gender;

    users[index] = user;
    box.put('users', users);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully')),
    );

    Navigator.pop(context);
  }
}
