import 'package:shortway/core/helper/type_aliases.dart';
import 'package:shortway/domain/entities/field.dart';

/// Defines the interface for a repository managing field data.
///
/// This abstract class outlines the methods for fetching field data from a remote source,
/// retrieving fetched fields, and obtaining a specific field by ID.
abstract class FieldBrainRepository {
  FutureFailable<List<Field>> fetchFieldsFrom({required String url});
  List<Field> getFetchedFields();
  Failable<Field> getFieldBy({required String id});
}
