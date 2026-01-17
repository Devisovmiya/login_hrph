import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'task_check_dialogbox.dart';

class TodaysTask extends ConsumerWidget {
  const TodaysTask({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return  ListTile(
      title: const Text('Checklist Today', style: TextStyle(fontSize: 15)),
      trailing: const Icon(Icons.check_circle_outlined),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => const TaskCheckDialogeBox(),
        );
      },
    );
  }
}

