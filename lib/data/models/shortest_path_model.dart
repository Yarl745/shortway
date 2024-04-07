import 'package:json_annotation/json_annotation.dart';
import 'package:shortway/data/models/coordinate_model.dart';
import 'package:shortway/data/models/shortest_path_result_model.dart';
import 'package:shortway/domain/entities/shortest_path.dart';

part 'shortest_path_model.g.dart';

@JsonSerializable()
class ShortestPathModel {
  @JsonKey(name: 'id')
  final String fieldId;
  @JsonKey(toJson: _resultToJson)
  final ShortestPathResultModel result;

  const ShortestPathModel({
    required this.fieldId,
    required this.result,
  });

  factory ShortestPathModel.fromShortestPath(ShortestPath entity) =>
      ShortestPathModel(
        fieldId: entity.fieldId,
        result: ShortestPathResultModel(
          steps: entity.steps
              .map(
                (coord) => CoordinateModel.fromCoordinate(coord),
              )
              .toList(),
          path: entity.path,
        ),
      );

  static Map<String, dynamic> _resultToJson(ShortestPathResultModel result) {
    return result.toJson();
  }

  factory ShortestPathModel.fromJson(Map<String, dynamic> json) =>
      _$ShortestPathModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShortestPathModelToJson(this);

  factory ShortestPathModel.empty() {
    return ShortestPathModel(
      fieldId: '',
      result: ShortestPathResultModel.empty(),
    );
  }

  bool get isEmpty => fieldId.isEmpty && result.isEmpty;

  @override
  String toString() {
    return 'ShortestPathModel{fieldId: $fieldId, result: $result}';
  }
}
