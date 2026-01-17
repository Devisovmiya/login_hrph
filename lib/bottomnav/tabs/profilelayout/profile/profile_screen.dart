import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/bottomnav/tabs/profilelayout/profile/accountdetails/screen/accountdetails_screen.dart';
import 'package:login_hrph/bottomnav/tabs/profilelayout/profile/accountdetails/widget/setting_title.dart';
import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        elevation: 25,
        centerTitle: true,
        leading: Icon(Icons.person_2),
        title: Text('Profile'),
      ),
      body: user == null
          ? const Center(child: Text("No user data found"))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: BoxBorder.all(width: 1),
                      //color: const Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(
                              255,
                              124,
                              162,
                              226,
                            ),
                            radius: 25,
                            child: Icon(Icons.person, size: 30),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 23,
                              ),
                            ),

                            Text(
                              currentemail,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //LIST_TILE

                //Tile_1
                SettingTile(
                  icon: Icons.account_circle,
                  title: 'Account Details',
                  onTapping: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AccountDetails()),
                    );
                  },
                ),

                //Tile_2(DarkMode Toggle)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(width: 0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SwitchListTile(
                       
                          title: Row(
                            children: [
                              Icon(Icons.mode_night_outlined, size: 15),
                              SizedBox(width: 15),
                              Text(
                                'Theme',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          value: isDark,
                          onChanged: (value) {
                            ref.read(themeProvider.notifier).state =
                                value; //RiverPod updtes the UI
                            box.put(
                              'darkmode',
                              value,
                            ); //current theme stored in Hive Box
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                //Tile_3
                SettingTile(
                  icon: Icons.color_lens_outlined,
                  title: 'App Theme',
                  onTapping: () {},
                ),

              
                //Tile_4(Log_Out)
                SettingTile(
                  icon: Icons.logout_rounded,
                  title: 'LogOut',
                  onTapping: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.blueGrey[100],

                          title: Text('Are You Sure That You Want To LogOut?'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  autofocus: true,
                                  onPressed: () async {
                                    Colors.indigoAccent;
                                    Navigator.of(context).pop();
                                    box.put('loggedIn', false);
                                    await ref
                                        .read(authProvider.notifier)
                                        .logout();
                                  },
                                  child: Text('Yes,LogOut'),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
    );
  }
}
