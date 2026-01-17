import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:login_hrph/hivemodels/task/taskdata.dart';
import 'package:login_hrph/riverpod_provider/notifier/tasknotifier.dart';



final taskBoxProvider = Provider<Box<TaskData>>((ref) {
  return Hive.box<TaskData>('tasks');
});

final currentUserProvider = Provider<String?>((ref) {
  return Hive.box('auth').get('email');
});

final taskListProvider =
    StateNotifierProvider<TaskNotifier, List<TaskData>>((ref) {
  return TaskNotifier(ref);
});

// Today's tasks
final todaysTaskProvider = Provider<List<TaskData>>((ref) {
  final tasks = ref.watch(taskListProvider);
  final today = DateTime.now();

  return tasks.where((task) {
    final date = task.duedate;
   

    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }).toList();
});

// Count completed tasks
final completedTaskCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.where((t) => (t.status) == 'Done').length;
});

// Count total tasks
final totalTaskCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(taskListProvider);
  return tasks.length;
});

// Overall completion progress
final taskCompletionProgressProvider = Provider<double>((ref) {
  final total = ref.watch(totalTaskCountProvider);
  final completed = ref.watch(completedTaskCountProvider);

  if (total == 0) return 0.0;
  return completed / total;
});
