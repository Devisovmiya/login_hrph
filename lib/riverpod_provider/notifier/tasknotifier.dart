import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:login_hrph/hivemodels/task/taskdata.dart';
import 'package:login_hrph/riverpod_provider/provider/tasks_tab_provider/tasksproviders.dart';

class TaskNotifier extends StateNotifier<List<TaskData>> {
  //intialzing state to empty List
  final Ref ref;

  TaskNotifier(this.ref) : super([]) {
    loadTask();
  }

  void loadTask() {
    final box = ref.read(taskBoxProvider);
    //initial loading
    state = box.values.toList();

    //after change loading
    box.watch().listen((_) {
      box.values.toList();
    });
  }

  void addTask(TaskData task) {
    final box = ref.read(taskBoxProvider);
    box.add(task);
    state = [...state, task];
  }

  Future<void> deleteTask(TaskData task) async {
    await task.delete();
    state = state.where((t) => t.key != task.key).toList();
  }

  void updateTask(TaskData task) {
    task.save();
    //if key matches updte the NEW_TASK other wise old task
    state = [
      for (final t in state)
        if (t.key == task.key) task else t,
    ];
  }

  void toggleTaskCompletion(TaskData task) async{
    final isCompleted =
        task.completedSubTasks >= task.totalsubtasks || task.status == 'Done';

    if (isCompleted) {
      task.completedSubTasks = 0;
      task.status = 'To Do';
    } else {
      task.completedSubTasks = task.totalsubtasks;
      task.status = 'Done';
    }
   await task.save();
   state = [
     for (final t in state) 
      if (t.key == task.key)
        task
      else
        t
   ];
    }
  }

