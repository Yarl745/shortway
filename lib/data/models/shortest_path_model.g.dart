// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortest_path_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortestPathModel _$ShortestPathModelFromJson(Map<String, dynamic> json) =>
    ShortestPathModel(
      fieldId: json['id'] as String,
      result: ShortestPathResultModel.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShortestPathModelToJson(ShortestPathModel instance) =>
    <String, dynamic>{
      'id': instance.fieldId,
      'result': ShortestPathModel._resultToJson(instance.result),
    };
