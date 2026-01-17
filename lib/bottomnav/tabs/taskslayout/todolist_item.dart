import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_hrph/hivemodels/task/taskdata.dart';
import 'package:login_hrph/riverpod_provider/provider/tasks_tab_provider/tasksproviders.dart';

class ToDoListItem extends ConsumerWidget {
  final TaskData task;

  const ToDoListItem({super.key, required this.task});

  //priority_Color
  Color getPriorityColor() {
    switch (task.priority) {
      case 2:
        return Colors.redAccent;
      case 1:
        return Colors.orangeAccent;
      default:
        return Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Check_Box
              Checkbox(
                value: task.status == 'Done',
                onChanged: (_) {
                  ref
                      .read(taskListProvider.notifier)
                      .toggleTaskCompletion(task);
                },
              ),
              SizedBox(width: 6),

              //MAIN CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title + Priority
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            task.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            maxRadius: 8,
                            backgroundColor: getPriorityColor(),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    // description
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                     
                   
                    //DUE_DATE
                     Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          SizedBox(width: 5),
                          Text(
                            '${task.duedate.day}/${task.duedate.month}/${task.duedate.year}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                       ],
                    ),
                    
                    SizedBox(height: 4),

                    // status chip
                    Chip(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      label: Text(task.status),
                    ),

                    SizedBox(height: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
