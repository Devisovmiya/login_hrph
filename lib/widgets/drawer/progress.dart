import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/riverpod_provider/provider/tasks_tab_provider/tasksproviders.dart';

class Progress extends ConsumerWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedTasks = ref.watch(completedTaskCountProvider);
    final totaltasks = ref.watch(totalTaskCountProvider);

    return ListTile(
      title: Text('Progress', style: TextStyle(fontSize: 15)),
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.blueGrey[100],
                content: Text(
                  '$completedTasks of $totaltasks subtask was completed till now',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(Icons.auto_graph_sharp),
      ),
    );
  }
}
