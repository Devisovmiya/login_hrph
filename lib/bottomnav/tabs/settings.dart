// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:login_hrph/riverpod_provider/provider/auth_provider/theme_auth_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final box = Hive.box('auth');
    return Scaffold(
      appBar: AppBar(

        leading: Icon(Icons.settings_applications_outlined),
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Theme'),
              value: isDark,
              onChanged: (value) {
                ref.read(themeProvider.notifier).state =
                    value; //RiverPod updtes the UI
                box.put('darkmode', value); //current theme stored in Hive Box
              },
            ),
          
          ],
        ),
      ),
    );
  }
}
