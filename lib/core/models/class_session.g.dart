// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassSessionAdapter extends TypeAdapter<ClassSession> {
  @override
  final typeId = 2;

  @override
  ClassSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClassSession()
      ..title = fields[0] as String
      ..room = fields[1] as String
      ..lecturer = fields[2] as String
      ..startTime = fields[3] as DateTime
      ..endTime = fields[4] as DateTime
      ..dayOfWeek = (fields[5] as num).toInt();
  }

  @override
  void write(BinaryWriter writer, ClassSession obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.room)
      ..writeByte(2)
      ..write(obj.lecturer)
      ..writeByte(3)
      ..write(obj.startTime)
      ..writeByte(4)
      ..write(obj.endTime)
      ..writeByte(5)
      ..write(obj.dayOfWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
