import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Reminders extends ConsumerWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),
            ),

         ),
         elevation: 25,
        centerTitle: true,
        leading: Icon(Icons.touch_app_outlined),
        title: Text('Reminders'),
      ),
      body: Text('Reminders  Screen'),
    );
  }
}
