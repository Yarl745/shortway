import 'package:shortway/domain/entities/field_point.dart';

class Field {
  final String id;
  final List<List<FieldPoint>> fieldPoints;
  final FieldPoint start;
  final FieldPoint end;

  const Field({
    required this.id,
    required this.fieldPoints,
    required this.start,
    required this.end,
  });

  @override
  String toString() {
    return 'Field{id: $id, field: $fieldPoints, start: $start, end: $end}';
  }
}
