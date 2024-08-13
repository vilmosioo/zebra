import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Journey` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'journey.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
/// This class is written to hive, so it needs a type adapter.
@HiveType(typeId: 2)
class Journey {
  Journey(this.name, this.bulletType, this.icon);

  @JsonKey(required: true, name: 'text')
  @HiveField(0)
  String name;

  @JsonKey(required: true, name: 'bullet_type')
  @HiveField(1)
  int bulletType;


  @JsonKey(required: false, name: 'preferred_emoji_char')
  @HiveField(2)
  String? icon;

  /// A necessary factory constructor for creating a new Journey instance
  /// from a map. Pass the map to the generated `_$JourneyFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Journey.
  factory Journey.fromJson(Map<String, dynamic> json) => _$JourneyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$JourneyFromJson`.
  Map<String, dynamic> toJson() => _$JourneyToJson(this);
}