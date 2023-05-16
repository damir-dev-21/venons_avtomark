// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Operation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OperationAdapter extends TypeAdapter<Operation> {
  @override
  final int typeId = 0;

  @override
  Operation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Operation(
      fields[0] as int,
      fields[1] as int,
      fields[2] as int,
      (fields[3] as Map).cast<String, dynamic>(),
      (fields[4] as Map).cast<String, dynamic>(),
      fields[5] as String,
      (fields[6] as List).cast<Item>(),
      fields[7] as String,
      fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Operation obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.warehouse)
      ..writeByte(4)
      ..write(obj.client)
      ..writeByte(5)
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.items)
      ..writeByte(7)
      ..write(obj.date)
      ..writeByte(8)
      ..write(obj.success);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
