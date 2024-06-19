// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['date', 'isCompleted'],
  );
  return Report(
    json['date'] as String,
    json['isCompleted'] as bool,
  );
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'date': instance.date,
      'isCompleted': instance.isCompleted,
    };
