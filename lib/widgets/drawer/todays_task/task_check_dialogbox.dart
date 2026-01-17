import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/riverpod_provider/provider/tasks_tab_provider/tasksproviders.dart';

class TaskCheckDialogeBox extends ConsumerWidget {
  const  TaskCheckDialogeBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTasks = ref.watch(todaysTaskProvider);

    return AlertDialog(
      title: const Text("Today's Checklist"),
      content: SizedBox(
        width:300,
        height: 300,
        child: todayTasks.isEmpty
            ? const Text('No Tasks for Today...')
            : ListView.builder(
                shrinkWrap: true,
                itemCount: todayTasks.length,
                itemBuilder: (context, index) {
                  final task = todayTasks[index];

                  return CheckboxListTile(
                    title: Text(task.title),
                    value: task.status == 'Done',
                    onChanged: (_) {
                      ref
                          .read(taskListProvider.notifier)
                          .toggleTaskCompletion(task);
                    },
                  );
                },
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}