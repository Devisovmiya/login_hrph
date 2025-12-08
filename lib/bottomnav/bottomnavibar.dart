import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/bottomnav/tabs/home.dart';
import 'package:login_hrph/bottomnav/tabs/profile.dart';
import 'package:login_hrph/bottomnav/tabs/settings.dart';

class BottomNaviBar extends ConsumerStatefulWidget {
  const BottomNaviBar({super.key});
  @override
  ConsumerState<BottomNaviBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomNaviBar> {
  //to manage the state of the bottom navigation bar
  int _selectedPage = 0;
   final pages = [HomePage(), ProfilePage(), SettingsPage()];

  //list of pages to be displayed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: _selectedPage,
        onTap: (value) {
          setState(() {
            _selectedPage  = value.clamp(0, pages.length - 1);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications_sharp),
            label: 'Settings',
          ),
        ],
      ),

    );
  }
}
