import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_hrph/widgets/drawer/progress.dart';
import 'package:login_hrph/widgets/drawer/todays_task/todaystask.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final box = Hive.box('auth');

    //getting current_user_email
    final currentemail = box.get('current_user_email');
    final List users = box.get('users', defaultValue: []);

    //find the match user
    // Find the user object
    final user = users.firstWhere(
      (u) => u.email == currentemail,
      orElse: () => null,
    );

    return Drawer(
    //  backgroundColor: const Color.fromARGB(255, 138, 169, 206),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: DrawerHeader(
              decoration: BoxDecoration(
               color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 30, child: Icon(Icons.person)),
                  Text(user?.username ?? 'User'),
                  Text(user?.email ?? currentemail ?? 'No email'),
                ],
              ),
            ),
          ),

          //TASK_TILE
          ExpansionTile(
            title: Text('Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_drop_down_rounded),
            children: [
              //PROGRESS
              Progress(),

              //TODAY_TASK
              TodaysTask(),
            ],
          ),

          ListTile(
            title: Text(
              'LogOut',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
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
                              child: Text('Cancel',style: TextStyle(color: Colors.black38),),
                            ),
                           /*  ElevatedButton(
                              autofocus: true,
                              onPressed: () async {
                                Colors.indigoAccent;
                                Navigator.of(context).pop();
                                box.put('loggedIn', false);
                                await ref.read(authProvider.notifier).logout();
                              },
                              child: Text('Yes,LogOut'),
                            ), */
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.logout_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
