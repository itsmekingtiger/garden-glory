// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plantlog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantLogAdapter extends TypeAdapter<PlantLog> {
  @override
  final int typeId = 1;

  @override
  PlantLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlantLog(
      id: fields[0] as String,
      text: fields[1] as String,
      tags: (fields[2] as List).toSet().cast<TagType>(),
      createdAt: fields[3] as DateTime,
      image: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlantLog obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.tags.toList())
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
