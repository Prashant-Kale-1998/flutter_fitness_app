// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomWorkoutsClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomWorkoutsClassAdapter extends TypeAdapter<CustomWorkoutsClass> {
  @override
  CustomWorkoutsClass read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomWorkoutsClass()
      ..name = fields[0] as String
      ..repeatCount = fields[1] as String
      ..intervalTime = fields[2] as String
      ..totalCalories = fields[3] as String
      ..totaltime = fields[4] as String
      ..list = (fields[5] as List)?.cast<CustomWorkoutCreateClass>();
  }

  @override
  void write(BinaryWriter writer, CustomWorkoutsClass obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.repeatCount)
      ..writeByte(2)
      ..write(obj.intervalTime)
      ..writeByte(3)
      ..write(obj.totalCalories)
      ..writeByte(4)
      ..write(obj.totaltime)
      ..writeByte(5)
      ..write(obj.list);
  }

  @override
  // TODO: implement typeId
  int get typeId => 3;
}
