// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class hmodelAdapter extends TypeAdapter<hmodel> {
  @override
  final int typeId = 0;

  @override
  hmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return hmodel(
      hurls: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, hmodel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hurls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is hmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
