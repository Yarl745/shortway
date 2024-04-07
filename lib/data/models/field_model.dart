import 'package:json_annotation/json_annotation.dart';
import 'package:shortway/data/models/coordinate_model.dart';
import 'package:shortway/domain/entities/coordinate.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/entities/field_point.dart';

part 'field_model.g.dart';

@JsonSerializable()
class FieldModel {
  final String id;
  final List<String> field;
  @JsonKey(toJson: _fieldPointToJson)
  final CoordinateModel start;
  @JsonKey(toJson: _fieldPointToJson)
  final CoordinateModel end;

  FieldModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  Field toField() {
    return Field(
      id: id,
      fieldPoints: transformField(),
      start: start.toFieldPoint(),
      end: end.toFieldPoint(),
    );
  }

  /// Transforms the field representation to a matrix of FieldPoint.
  List<List<FieldPoint>> transformField() {
    final List<List<FieldPoint>> transformedField = [];

    for (var i = 0; i < field.first.length; i++) {
      final List<FieldPoint> newRow = [];

      for (var j = 0; j < field.length; j++) {
        final strBlockValue = field[j][i];

        newRow.add(FieldPoint(
          coord: Coordinate(i, j),
          isBlocked: strBlockValue == 'X',
        ));
      }
      transformedField.add(newRow);
    }

    return transformedField;
  }

  factory FieldModel.fromJson(Map<String, dynamic> json) =>
      _$FieldModelFromJson(json);

  Map<String, dynamic> toJson() => _$FieldModelToJson(this);

  static Map<String, dynamic> _fieldPointToJson(CoordinateModel model) =>
      model.toJson();

  factory FieldModel.empty() {
    return FieldModel(
      id: '',
      field: [],
      start: CoordinateModel.empty(),
      end: CoordinateModel.empty(),
    );
  }

  bool get isEmpty =>
      id.isEmpty && field.isEmpty && start.isEmpty && end.isEmpty;

  @override
  String toString() {
    return 'FieldModel{id: $id, field: $field, start: $start, end: $end}';
  }
}
