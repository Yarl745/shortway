import 'package:dartz/dartz.dart';
import 'package:shortway/core/error/error_handler.dart';
import 'package:shortway/core/error/exceptions.dart';
import 'package:shortway/core/error/failure.dart';
import 'package:shortway/core/helper/type_aliases.dart';
import 'package:shortway/data/datasources/api_remote_data_source.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/repositories/field_brain_repository.dart';

class FieldBrainRepositoryImpl implements FieldBrainRepository {
  final ApiRemoteDataSource _apiRemoteDataSource;

  List<Field> _fields = [];

  FieldBrainRepositoryImpl({
    required ApiRemoteDataSource apiRemoteDataSource,
  }) : _apiRemoteDataSource = apiRemoteDataSource;

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

  @override
  List<Field> getFetchedFields() {
    return _fields;
  }
}
