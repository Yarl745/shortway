import 'package:json_annotation/json_annotation.dart';
import 'package:shortway/data/models/coordinate_model.dart';

part 'shortest_path_result_model.g.dart';

@JsonSerializable()
class ShortestPathResultModel {
  @JsonKey(toJson: _stepsToJson)
  final List<CoordinateModel> steps;
  final String path;

  const ShortestPathResultModel({
    required this.steps,
    required this.path,
  });

  static List<Map<String, dynamic>> _stepsToJson(List<CoordinateModel> steps) {
    return steps.map((step) => step.toJson()).toList();
  }

  factory ShortestPathResultModel.fromJson(Map<String, dynamic> json) =>
      _$ShortestPathResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShortestPathResultModelToJson(this);

  factory ShortestPathResultModel.empty() {
    return const ShortestPathResultModel(
      steps: [],
      path: '',
    );
  }

  bool get isEmpty => steps.isEmpty && path.isEmpty;

  @override
  String toString() {
    return 'ShortestPathResultModel{steps: $steps, path: $path}';
  }
}
