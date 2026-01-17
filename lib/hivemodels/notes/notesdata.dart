import 'package:hive/hive.dart';

part 'notesdata.g.dart';

@HiveType(typeId: 2)
class NotesData extends HiveObject {
  NotesData({
    required this.title,
    required this.subtitle,
    required this.content,
  });

  @HiveField(0)
  String? title;
  @HiveField(1)
  String? subtitle;
  @HiveField(2)
  String? content;
}
