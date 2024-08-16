// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

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
