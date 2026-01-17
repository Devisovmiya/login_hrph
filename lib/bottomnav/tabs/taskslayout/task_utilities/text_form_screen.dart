import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:login_hrph/hivemodels/task/taskdata.dart';
import 'package:login_hrph/riverpod_provider/provider/tasks_tab_provider/tasksproviders.dart';

class TextFormScreen extends ConsumerStatefulWidget {
  final TaskData? task;

  const TextFormScreen({super.key, required this.task});

  @override
  ConsumerState<TextFormScreen> createState() {
    return _TextFormScreen();
  }
}

class _TextFormScreen extends ConsumerState<TextFormScreen> {
  late TextEditingController titleCtrl;
  late TextEditingController descripCtrl;
  late int priorityCtrl;
  late DateTime dueDateCtrl;
  late String statusCtrl;

  bool get isEdit => widget.task != null;



  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: (isEdit) ? widget.task!.title : "");
    descripCtrl = TextEditingController(text: (isEdit) ? widget.task!.description : '',);
    priorityCtrl = isEdit ? widget.task!.priority : 1;
    dueDateCtrl = isEdit ? widget.task!.duedate : DateTime.now();
    statusCtrl = isEdit ? widget.task!.status : 'Done';
  }

  @override
  Widget build(BuildContext context) {
    final userMail = ref.watch(currentUserProvider);

    final completedTasks = ref.watch(completedTaskCountProvider);
    final totaltasks = ref.watch(totalTaskCountProvider);
    return Scaffold(
      appBar: AppBar(title: (isEdit) ? Text('Edit Task') : Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //addTitle
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 197, 46, 0),
                  ),
                ),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 10),
            //addDescription
            TextField(
              controller: descripCtrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: const Color.fromARGB(255, 197, 46, 0),
                  ),
                ),
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<int>(
                value: priorityCtrl,
                items: [
                  DropdownMenuItem(value: 0, child: Text('Low')),
                  DropdownMenuItem(value: 1, child: Text('Medium')),
                  DropdownMenuItem(value: 2, child: Text('High')),
                ],
                onChanged: (value) {
                  setState(() {
                    priorityCtrl = value ?? 1;
                  });
                },
                dropdownColor: Colors.lime[50],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    dueDateCtrl = picked;
                  });
                }
              },
              label: Text(
                'Due:${DateFormat('yyyy-MM-dd').format(dueDateCtrl)}',
              ),
              icon: Icon(Icons.calendar_month),
            ),
            SizedBox(height: 10),
            Text('Status'),
            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SegmentedButton(
                  segments: [
                    ButtonSegment(
                      value: 'ToDo',
                      label: Text('ToDo'),
                      icon: Icon(Icons.list_alt_outlined),
                    ),
                    ButtonSegment(
                      value: 'InProgress',
                      label: Text('InProgress'),
                      icon: Icon(Icons.timelapse_sharp),
                    ),
                    ButtonSegment(
                      value: 'Done',
                      label: Text('Done'),
                      icon: Icon(Icons.playlist_add_check_circle_sharp),
                    ),
                  ],
                  selected: {statusCtrl},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      statusCtrl = ((newSelection.isNotEmpty)
                          ? newSelection.first
                          : null)!;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Go Back'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (isEdit) {
                      //edit/Update
                      final task = widget.task!
                        ..title = titleCtrl.text
                        ..description = descripCtrl.text
                        ..priority = priorityCtrl
                        ..duedate = dueDateCtrl
                        ..status = statusCtrl
                        ..completedSubTasks = completedTasks
                        ..totalsubtasks = totaltasks;
                      ref.read(taskListProvider.notifier).updateTask(task);
                    } else {
                      //add Task
                      final newTask = TaskData(
                        title: titleCtrl.text,
                        description: descripCtrl.text,
                        priority: priorityCtrl,
                        duedate: dueDateCtrl,
                        completedSubTasks: completedTasks,
                        totalsubtasks: totaltasks,
                        status: statusCtrl,
                        userEmail: userMail.toString(),
                      );
                      ref.read(taskListProvider.notifier).addTask(newTask);
                    }
                    Navigator.of(context).pop();
                  },
                  label: isEdit ? Text('Update Task') : Text('Add Task'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
