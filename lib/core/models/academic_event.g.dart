// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academic_event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AcademicEventAdapter extends TypeAdapter<AcademicEvent> {
  @override
  final typeId = 0;

  @override
  AcademicEvent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AcademicEvent()
      ..title = fields[0] as String
      ..date = fields[1] as DateTime
      ..type = fields[2] as EventType;
  }

  @override
  void write(BinaryWriter writer, AcademicEvent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AcademicEventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventTypeAdapter extends TypeAdapter<EventType> {
  @override
  final typeId = 1;

  @override
  EventType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EventType.exam;
      case 1:
        return EventType.holiday;
      case 2:
        return EventType.event;
      default:
        return EventType.exam;
    }
  }

  @override
  void write(BinaryWriter writer, EventType obj) {
    switch (obj) {
      case EventType.exam:
        writer.writeByte(0);
      case EventType.holiday:
        writer.writeByte(1);
      case EventType.event:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
