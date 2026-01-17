import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_hrph/bottomnav/tabs/taskslayout/task_utilities/text_form_screen.dart';
import 'package:login_hrph/bottomnav/tabs/taskslayout/todolist_item.dart';
import 'package:login_hrph/riverpod_provider/provider/tasks_tab_provider/tasksproviders.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final progress = ref.watch(taskCompletionProgressProvider);

    //final taskBox = ref.watch(taskBoxProvider);
    final listBox = ref.watch(taskListProvider);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.task_outlined),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          elevation: 25,
          centerTitle: true,

          title: Text('Task Screen'),
        ),
body: listBox.isEmpty
    ? Center(child: Text('No Tasks Yet..,Add your tasks'))
    : Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: listBox.length,
              itemBuilder: (context, index) {
                final tasks = listBox[index];

                //slider to right /bottom to edit

                return 
                   Slidable(
                    startActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TextFormScreen(task: tasks),
                              ),
                            );
                          },
                          icon: Icons.edit_note_outlined,
                          backgroundColor: const Color.fromARGB(
                            255,
                            100,
                            255,
                            139,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ],
                    ),
                  
                    //slidable for ToDelete
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            ref
                                .read(taskListProvider.notifier)
                                .deleteTask(tasks);
                          },
                          icon: Icons.delete_outline_outlined,
                          backgroundColor: const Color.fromARGB(
                            255,
                            253,
                            67,
                            67,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                  
                    child: ToDoListItem(task: tasks),
                
                );
              },
            ),
          ),
        ),
        //Progress_Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    ),


          //FLOATING_ACTION_BUTTON
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //addTaskScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TextFormScreen(task: null),
              ),
            );
          },
          child: Icon(Icons.add_outlined),
        ),
      ),
    );
  }
}
