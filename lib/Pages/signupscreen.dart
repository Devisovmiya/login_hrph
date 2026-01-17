// ignore_for_file: deprecated_member_use, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';
import 'package:login_hrph/hivemodels/user/usermodel.dart';
import 'package:intl/intl.dart';

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
  final phnumctrl = TextEditingController();
  final dobctrl = TextEditingController();
  final cityctrl = TextEditingController();
  final countryctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  final confrimPassctrl = TextEditingController();

  String gender = '';
  DateTime? pickedDate;
  File? selectedImage;
  //FormKey
  final formKey = GlobalKey<FormState>();

  final box = Hive.box('auth');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Image.asset(
                'assets/images/account_signup.png',
                fit: BoxFit.fill,
                height: 200,
                width: 200,
                opacity: const AlwaysStoppedAnimation(1.0),
              ),
              SizedBox(height: 10),
              //Welcome message
              Text(
                textAlign: TextAlign.left,
                'Get On Board',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: const Color.fromARGB(255, 11, 87, 122),
                ),
              ),

              //subgreet
              Text(
                textAlign: TextAlign.left,

                'Create your profile to start your Journey ',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 11, 87, 122),
                ),
              ),

              //Credentials of user
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: usernamectrl,
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'UserName*',
                        ),
                        validator: (v) =>
                            v != null && v.isNotEmpty ? null : 'Required',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: emailctrl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Email*',
                        ),
                        validator: (v) => v != null && v.contains('@gmail.com')
                            ? null
                            : 'Invalid Email',
                      ),
                    ),

                    SizedBox(height: 10),
                    //Phone_number feild
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: phnumctrl,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: Text('Phone Number*'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter your phone number';
                          } else if (value.length < 10) {
                            return 'enter valid phonenumber';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),

                    //DOB feild
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: dobctrl,
                        readOnly: true,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Date Of Birth*',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),

                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          pickedDate = await showDatePicker(
                            // ignore: use_build_context_synchronously
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now(),
                          );

                          if (pickedDate != null) {
                            dobctrl.text = DateFormat(
                              'yyyy-MM-dd',
                            ).format(pickedDate!);
                          }
                        },

                        validator: (v) {
                          if ((v == null) || (v.isEmpty)) {
                            'Please choose your DATE OF  BIRTH';
                          }
                          return;
                        },
                      ),
                    ),

                    //Location(city)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: cityctrl,
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'City*',
                        ),
                        validator: (v) =>
                            v != null && v.isNotEmpty ? null : 'Required',
                      ),
                    ),
                    SizedBox(height: 10),
                    //Location(country)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: countryctrl,
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Country*',
                        ),
                        validator: (v) =>
                            v != null && v.isNotEmpty ? null : 'Required',
                      ),
                    ),
                    SizedBox(height: 10),

                    //passwodfeild
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: passwordctrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password*',
                        ),
                        validator: (v) => v != null && v.length > 6
                            ? null
                            : 'Min 6 Characters',
                      ),
                    ),

                    SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: confrimPassctrl,
                        decoration: InputDecoration(
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Confrim Password*',
                        ),
                        // ignore: unrelated_type_equality_checks
                        validator: (v) => v == (passwordctrl.text)
                            ? null
                            : 'password should match',
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
                          //Male
                          Radio<String>(
                            value: 'Male',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() => gender = value!);
                            },
                          ),
                          Text('Male'),

                          SizedBox(width: 10),
                          //Female
                          Radio<String>(
                            value: 'Female',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() => gender = value!);
                            },
                          ),
                          Text('Female'),
                          SizedBox(width: 10),

                          //Others
                          Radio<String>(
                            value: 'Others',
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() => gender = value!);
                            },
                          ),
                          Text('Others'),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),

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
                    phnum: phnumctrl.text,
                    dob: DateTime.parse(dobctrl.text),
                    city: cityctrl.text,
                    country: countryctrl.text,
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

                  ref.read(authProvider.notifier).goToLogin();
                  /*  print("Username entered: ${usernamectrl.text}");
                  print("Password entered: ${emailctrl.text}");
                  print("Phonenumber entered: ${phnumctrl.text}");
                  print(
                    "DOB entered: ${DateFormat('yyyy-MM-dd').format(pickedDate!)}",
                  );
                  print("city entered: ${cityctrl.text}");
                  print("country entered: ${countryctrl.text}");
                  print("gender selected: $gender"); */
                },
                label: Text('Register'),
                icon: Icon(Icons.app_registration_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
