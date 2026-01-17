// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskdata.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDataAdapter extends TypeAdapter<TaskData> {
  @override
  final int typeId = 1;

  @override
  TaskData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskData(
      title: fields[0] as String,
      description: fields[1] as String,
      priority: fields[2] as int,
      duedate: fields[3] as DateTime,
      completedSubTasks: fields[4] as int,
      totalsubtasks: fields[5] as int,
      status: fields[6] as String,
      userEmail: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TaskData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.duedate)
      ..writeByte(4)
      ..write(obj.completedSubTasks)
      ..writeByte(5)
      ..write(obj.totalsubtasks)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
