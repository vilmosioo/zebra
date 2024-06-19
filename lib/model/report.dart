import 'package:json_annotation/json_annotation.dart';

/// This allows the `Report` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'report.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
class Report {
  Report(this.date, this.isCompleted);

  @JsonKey(required: true, name: 'date')
  String date;

  @JsonKey(required: true, name: 'isCompleted')
  bool isCompleted;

  /// A necessary factory constructor for creating a new Report instance
  /// from a map. Pass the map to the generated `_$ReportFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Report.
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ReportToJson`.
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}