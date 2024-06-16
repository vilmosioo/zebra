// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['text', 'dt', 'completed_time', 'bullet_type'],
  );
  return Goal(
    json['text'] as String,
    json['dt'] as String,
    json['completed_time'] as String,
    (json['bullet_type'] as num).toInt(),
  );
}

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'text': instance.name,
      'dt': instance.date,
      'completed_time': instance.completedTime,
      'bullet_type': instance.bulletType,
    };
