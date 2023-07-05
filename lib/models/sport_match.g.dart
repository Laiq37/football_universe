// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_match.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SportMatchAdapter extends TypeAdapter<SportMatch> {
  @override
  final int typeId = 2;

  @override
  SportMatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SportMatch(
      id: fields[0] as String,
      home: fields[1] as String,
      away: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SportMatch obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.home)
      ..writeByte(2)
      ..write(obj.away)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SportMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
