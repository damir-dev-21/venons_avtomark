// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Operations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationsAdapter extends TypeAdapter<Operations> {
  @override
  final int typeId = 3;

  @override
  Operations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operations(
      (fields[0] as List).cast<Operation>(),
    );
  }

  @override
  void write(BinaryWriter writer, Operations obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.operations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
