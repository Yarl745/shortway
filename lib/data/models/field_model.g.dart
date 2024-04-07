// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldModel _$FieldModelFromJson(Map<String, dynamic> json) => FieldModel(
      id: json['id'] as String,
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
      start: CoordinateModel.fromJson(json['start'] as Map<String, dynamic>),
      end: CoordinateModel.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FieldModelToJson(FieldModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'start': FieldModel._fieldPointToJson(instance.start),
      'end': FieldModel._fieldPointToJson(instance.end),
    };
