import 'package:json_annotation/json_annotation.dart';
import 'package:shortway/domain/entities/coordinate.dart';
import 'package:shortway/domain/entities/field_point.dart';

part 'coordinate_model.g.dart';

@JsonSerializable()
class CoordinateModel {
  final int x;
  final int y;

  const CoordinateModel(this.x, this.y);

  FieldPoint toFieldPoint() {
    return FieldPoint(
      coord: Coordinate(x, y),
    );
  }

  factory CoordinateModel.fromCoordinate(Coordinate entity) =>
      CoordinateModel(entity.x, entity.y);

  factory CoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);

  factory CoordinateModel.empty() {
    return const CoordinateModel(-1, -1);
  }

  bool get isEmpty => x == -1 && y == -1;

  @override
  String toString() {
    return 'FieldPointModel{x: $x, y: $y}';
  }
}
