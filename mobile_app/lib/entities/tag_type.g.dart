// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagTypeAdapter extends TypeAdapter<TagType> {
  @override
  final int typeId = 2;

  @override
  TagType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TagType.today;
      case 1:
        return TagType.watering;
      case 2:
        return TagType.feeding;
      case 3:
        return TagType.potChanging;
      case 4:
        return TagType.newLeaf;
      case 5:
        return TagType.flower;
      case 6:
        return TagType.suffering;
      case 7:
        return TagType.pesticide;
      case 8:
        return TagType.germinated;
      case 9:
        return TagType.seeding;
      default:
        return TagType.today;
    }
  }

  @override
  void write(BinaryWriter writer, TagType obj) {
    switch (obj) {
      case TagType.today:
        writer.writeByte(0);
        break;
      case TagType.watering:
        writer.writeByte(1);
        break;
      case TagType.feeding:
        writer.writeByte(2);
        break;
      case TagType.potChanging:
        writer.writeByte(3);
        break;
      case TagType.newLeaf:
        writer.writeByte(4);
        break;
      case TagType.flower:
        writer.writeByte(5);
        break;
      case TagType.suffering:
        writer.writeByte(6);
        break;
      case TagType.pesticide:
        writer.writeByte(7);
        break;
      case TagType.germinated:
        writer.writeByte(8);
        break;
      case TagType.seeding:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
