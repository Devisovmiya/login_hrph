// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/Pages/loginscreen.dart';
import 'package:login_hrph/usermodel.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  //variables
  final usernamectrl = TextEditingController();
  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  final confrimPassctrl = TextEditingController();

  String gender = '';
  //FormKey
  final formKey = GlobalKey<FormState>();

  final box = Hive.box('auth');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(
            Icons.person,
            size: 100,
            color: const Color.fromARGB(255, 232, 233, 240),
          ),

          Text(
            'Welcome :)',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: const Color.fromARGB(255, 0, 17, 15),
            ),
          ),
          //emailfeild
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                    child: TextFormField(
                      controller: usernamectrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'UserName',
                      ),
                      validator: (v) =>
                          v != null && v.isNotEmpty ? null : 'Required',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                    child: TextFormField(
                      controller: emailctrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                      ),
                      validator: (v) => v != null && v.contains('@gmail.com')
                          ? null
                          : 'Invalid Email',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //passwodfeild
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                    child: TextFormField(
                      controller: passwordctrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                      ),
                      validator: (v) =>
                          v != null && v.length > 6 ? null : 'Min 6 Characters',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      controller: confrimPassctrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Confrim Password',
                      ),
                      // ignore: unrelated_type_equality_checks
                      validator: (v) => v == (passwordctrl.text)
                          ? null
                          : 'password should match',
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //RadioButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text('Gender', style: TextStyle(fontSize: 15)),
                      SizedBox(width: 15),
                      Radio<String>(
                        value: 'Male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() => gender = value!);
                        },
                      ),
                      Text('Male'),

                      SizedBox(width: 10),
                      Radio<String>(
                        value: 'Female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() => gender = value!);
                        },
                      ),
                      Text('Female'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          //siginvalue
          ElevatedButton.icon(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              // cross checkfrom Hive Box
              final box = Hive.box('auth');
              List users = box.get('users', defaultValue: []);
              final exists = users.any((u) => u.email == emailctrl.text);
              if (exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Email Already Registered')),
                );
                return;
              }
              //Assigning to usermodel
              final newUser = UserModel(
                username: usernamectrl.text,
                email: emailctrl.text,
                password: passwordctrl.text,
                gender: gender,
              );
              //adding new user info to box
              users.add(newUser);
              box.put('users', users);
              box.put('current_user_email', newUser.email);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Account Created Successfully')),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Signup successful! Please login.")),
              );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            label: Text('Register'),
            icon: Icon(Icons.app_registration_rounded),
          ),
        ],
      ),
    );
  }
}
