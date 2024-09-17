import "package:json_annotation/json_annotation.dart";

/// This allows the `Cadence` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part "cadence.g.dart";

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class Cadence {
  Cadence(this.periodFrequency);

  @JsonKey(required: false, name: "period_frequency")
  int? periodFrequency;

  /// A necessary factory constructor for creating a new Cadence instance
  /// from a map. Pass the map to the generated `_$CadenceFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Cadence.
  factory Cadence.fromJson(Map<String, dynamic> json) => _$CadenceFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CadenceToJson`.
  Map<String, dynamic> toJson() => _$CadenceToJson(this);
}