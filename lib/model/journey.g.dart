// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JourneyAdapter extends TypeAdapter<Journey> {
  @override
  final int typeId = 2;

  @override
  Journey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Journey(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Journey obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.bulletType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JourneyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journey _$JourneyFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['text', 'bullet_type'],
  );
  return Journey(
    json['text'] as String,
    (json['bullet_type'] as num).toInt(),
  );
}

Map<String, dynamic> _$JourneyToJson(Journey instance) => <String, dynamic>{
      'text': instance.name,
      'bullet_type': instance.bulletType,
    };
