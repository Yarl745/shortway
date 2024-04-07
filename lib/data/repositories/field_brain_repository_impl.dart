import 'package:dartz/dartz.dart';
import 'package:shortway/core/error/error_handler.dart';
import 'package:shortway/core/error/exceptions.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/core/helper/type_aliases.dart';
import 'package:shortway/data/datasources/api_remote_data_source.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';

/// An implementation of the FieldBrainRepository interface for managing field data.
class FieldBrainRepositoryImpl implements FieldBrainRepository {
  final ApiRemoteDataSource _apiRemoteDataSource;

  List<Field> _fields = [];

  FieldBrainRepositoryImpl({
    required ApiRemoteDataSource apiRemoteDataSource,
  }) : _apiRemoteDataSource = apiRemoteDataSource;

  /// Fetches a list of fields from a remote source using the given URL.
  ///
  /// If the fetch operation is successful, the fetched fields are cached and
  /// the list of fields is returned. If there's an error, a Failure is returned.
  @override
  FutureFailable<List<Field>> fetchFieldsFrom({required String url}) async {
    try {
      _fields = await _apiRemoteDataSource.fetchFieldsFrom(url: url);

      return right(_fields);
    } catch (error) {
      final failure = handleError(
        error,
        defaultFailure: const NotCorrectUrlFailure(),
      );

      return left(failure);
    }
  }

  /// Retrieves a field by its ID from the cache of fetched fields.
  ///
  /// If a field with the specified ID exists in the cache, it is returned.
  /// Otherwise, a Failure is returned indicating that the field could not be found.
  @override
  Failable<Field> getFieldBy({required String id}) {
    try {
      try {
        final field = _fields.firstWhere((element) => element.id == id);

        return right(field);
      } on StateError {
        throw NoFieldException();
      }
    } catch (error) {
      final failure = handleError(error);

      return left(failure);
    }
  }

  /// Returns all fields that have been fetched and cached.
  @override
  List<Field> getFetchedFields() {
    return _fields;
  }
}
