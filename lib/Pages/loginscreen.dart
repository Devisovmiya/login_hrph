// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/Pages/homescreen.dart';
import 'package:collection/collection.dart';

import 'package:login_hrph/Pages/signupscreen.dart';

import 'package:login_hrph/riverpod_provider/stateprovider.dart';
import 'package:login_hrph/usermodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final mail = TextEditingController();
  final pass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              Icon(
                Icons.person_pin_circle_outlined,
                size: 75,
                color: Colors.blueGrey[100],
              ),

              Text(
                'Hello Again...',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                'Nice To See You Again...',
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
              ),
              //emailfeild
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 247, 245, 245),
                    ),
                    child: TextFormField(
                      controller: mail,
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
              ),
              //passwodfeild
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 245, 245),
                  ),
                  child: TextFormField(
                    controller: pass,
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
              SizedBox(height: 15),
              //sigin
              ElevatedButton.icon(
                onPressed: () {
                  //check the conditions n move to respective home page
                  if (!formKey.currentState!.validate()) return;

                  final box = Hive.box('auth');

                  List<UserModel> users = box
                      .get('users', defaultValue: <UserModel>[])
                      .cast<UserModel>();

                  final match = users.firstWhereOrNull(
                    (u) =>
                        u.email.trim() == mail.text.trim() &&
                        u.password.trim() == pass.text.trim(),
                  );

                  if (match == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invalid User')),
                    );
                    return;
                  }

                  box.put('loggedInUser', match.email);
                  box.put('loggedIn', true);
                  ref.read(authProvider.notifier).state = true;
                  //print("All keys: ${box.keys}");

                  box.put('current_user_email', mail.text);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                label: Text('LogIn'),
                icon: Icon(Icons.login_sharp),
              ),
              SizedBox(height: 10),

              //notamember
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a Member?'),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      //navigate tosign in page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignUpScreen()),
                      );
                    },
                    child: Text(
                      'REGISTER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[400],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
