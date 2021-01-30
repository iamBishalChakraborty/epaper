// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newspaper_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewspaperModelAdapter extends TypeAdapter<NewspaperModel> {
  @override
  final int typeId = 0;

  @override
  NewspaperModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewspaperModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewspaperModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.displayDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewspaperModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
