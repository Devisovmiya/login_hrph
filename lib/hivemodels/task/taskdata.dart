import 'package:hive/hive.dart';
part  'taskdata.g.dart';

@HiveType(typeId: 1)
class TaskData extends HiveObject {
  TaskData({
    required this.title,
    required this.description,
    required this.priority,
    required this.duedate,
    required this.completedSubTasks,
    required this.totalsubtasks,
    required this.status,
    required this.userEmail,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  int priority; //0=low , 1=medium , 2=high
  @HiveField(3)
  DateTime duedate;
  @HiveField(4)
 int completedSubTasks;
  @HiveField(5)
  int totalsubtasks;
  @HiveField(6)
  String status;
  //To Do , InProgress , Done
   @HiveField(7)
  String userEmail;

 
}
extension TaskDataX on TaskData {
  bool get isCompleted =>
      completedSubTasks >= totalsubtasks || status == 'Done';
}

