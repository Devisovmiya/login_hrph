// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:login_hrph/bottomnav/tabs/profilelayout/profile/accountdetails/widget/accountdetails_widget.dart';

import 'editprofilepage.dart';

class AccountDetails extends ConsumerWidget {
  const AccountDetails({super.key});

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Account Details',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: user == null
          ? Center(child: Text('User Not Found'))
          : SingleChildScrollView(
              child: Column(
                children: [
                  ProfileSection(),
                  SizedBox(height: 24),
                  Label(text: 'User', icon: Icons.person_3_outlined),
                  InfoFeild(text: user.username),
                  SizedBox(height: 24),
                  Label(text: 'Email', icon: Icons.email_outlined),
                  InfoFeild(text: user.email),
                  SizedBox(height: 24),
                  Label(text: 'Contact', icon: Icons.contact_page_outlined),
                  InfoFeild(text: user.phnum),
                  SizedBox(height: 24),
                  Label(text: 'Date Of Birth', icon: Icons.date_range_outlined),
                  InfoFeild(text: DateFormat('yyyy-MM-dd').format(user.dob!)),
                  SizedBox(height: 24),
                  Label(text: 'City', icon: Icons.location_city_outlined),
                  InfoFeild(text: user.city),
                  SizedBox(height: 24),

                  Label(text: 'Nationality', icon: Icons.location_on_outlined),
                  InfoFeild(text: user.country),
                  SizedBox(height: 24),
                  Label(text: 'Gender', icon: Icons.star_half_sharp),
                  InfoFeild(text: user.gender),
                  SizedBox(height: 24),

                  //Edit_Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 400),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfilePage(),
                          ),
                        );
                      },
                      child: const Text("Edit Profile"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
