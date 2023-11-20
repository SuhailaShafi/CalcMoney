// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usernew_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNewModelAdapter extends TypeAdapter<UserNewModel> {
  @override
  final int typeId = 6;

  @override
  UserNewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNewModel(
      name: fields[0] as String,
      images: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserNewModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
