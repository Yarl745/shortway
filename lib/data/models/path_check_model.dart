import 'package:json_annotation/json_annotation.dart';

part 'path_check_model.g.dart';

@JsonSerializable()
class PathCheckModel {
  final String id;
  final bool correct;

  PathCheckModel({
    required this.id,
    required this.correct,
  });

  factory PathCheckModel.fromJson(Map<String, dynamic> json) =>
      _$PathCheckModelFromJson(json);

  Map<String, dynamic> toJson() => _$PathCheckModelToJson(this);

  factory PathCheckModel.empty() {
    return PathCheckModel(
      id: '',
      correct: false,
    );
  }

  bool get isEmpty => id.isEmpty && !correct;
}
