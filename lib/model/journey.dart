import 'package:json_annotation/json_annotation.dart';

/// This allows the `Journey` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'journey.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class Journey {
  Journey(this.name, this.bulletType);

  @JsonKey(required: true, name: 'text')
  String name;

  @JsonKey(required: true, name: 'bullet_type')
  int bulletType;

  /// A necessary factory constructor for creating a new Journey instance
  /// from a map. Pass the map to the generated `_$JourneyFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Journey.
  factory Journey.fromJson(Map<String, dynamic> json) => _$JourneyFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$JourneyFromJson`.
  Map<String, dynamic> toJson() => _$JourneyToJson(this);
}