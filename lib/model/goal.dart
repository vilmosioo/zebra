import 'package:json_annotation/json_annotation.dart';

/// This allows the `Goal` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'goal.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Goal {
  Goal(this.name, this.date, this.completedTime);

  @JsonKey(required: true, name: 'text')
  String name;

  @JsonKey(required: true, name: 'dt')
  String date;

  @JsonKey(required: true, name: 'completed_time')
  String completedTime;

  /// A necessary factory constructor for creating a new Goal instance
  /// from a map. Pass the map to the generated `_$GoalFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Goal.
  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$GoalToJson`.
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}