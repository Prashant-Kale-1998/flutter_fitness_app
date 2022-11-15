// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProgressClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************
@override
class ProgressClassAdapter extends TypeAdapter<ProgressClass> {
  @override
  ProgressClass read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProgressClass()
      ..calories = fields[0] as String
      ..workOuts = fields[1] as String
      ..seconds = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, ProgressClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.calories)
      ..writeByte(1)
      ..write(obj.workOuts)
      ..writeByte(2)
      ..write(obj.seconds);
  }

  @override
  // TODO: implement typeId
  int get typeId => 1;
}
