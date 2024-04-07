// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortest_path_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortestPathResultModel _$ShortestPathResultModelFromJson(
        Map<String, dynamic> json) =>
    ShortestPathResultModel(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => CoordinateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
    );

Map<String, dynamic> _$ShortestPathResultModelToJson(
        ShortestPathResultModel instance) =>
    <String, dynamic>{
      'steps': ShortestPathResultModel._stepsToJson(instance.steps),
      'path': instance.path,
    };
