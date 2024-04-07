import 'package:dio/dio.dart';
import 'package:shortway/core/error/exceptions.dart';
import 'package:shortway/core/helper/type_aliases.dart';
import 'package:shortway/data/models/field_model.dart';
import 'package:shortway/data/models/path_check_model.dart';
import 'package:shortway/data/models/shortest_path_model.dart';
import 'package:shortway/domain/entities/field.dart';
import 'package:shortway/domain/entities/shortest_path.dart';

/// Provides remote data source APIs for fetching and validating field data.
///
/// This abstract class defines the interface for remote data source implementations,
/// detailing the methods for fetching field data from a remote source and checking
/// the validity of shortest paths.
abstract class ApiRemoteDataSource {
  Future<List<Field>> fetchFieldsFrom({required String url});
  Future<bool> checkShortestPaths({
    required String url,
    required List<ShortestPath> paths,
  });
}

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  final Dio _httpDataSource;

  ApiRemoteDataSourceImpl({
    required Dio httpDataSource,
  }) : _httpDataSource = httpDataSource;

  @override
  Future<List<Field>> fetchFieldsFrom({required String url}) async {
    if (url.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 200));
      throw NotCorrectUrlException();
    }

    final response = await _httpDataSource.get(url);
    try {
      final List<dynamic> listData = Json.castFrom(response.data)["data"];

      return listData
          .map(
            (data) => FieldModel.fromJson(Json.castFrom(data)).toField(),
          )
          .toList();
    } catch (error) {
      throw SerializationException(error: error);
    }
  }

  @override
  Future<bool> checkShortestPaths({
    required String url,
    required List<ShortestPath> paths,
  }) async {
    final jsonList = paths
        .map(
          (path) => ShortestPathModel.fromShortestPath(path).toJson(),
        )
        .toList();

    final response = await _httpDataSource.post(url, data: jsonList);

    try {
      final List<dynamic> listData = Json.castFrom(response.data)["data"];
      for (final data in listData) {
        final checkModel = PathCheckModel.fromJson(Json.castFrom(data));
        if (checkModel.correct == false) {
          return false;
        }
      }
    } catch (error) {
      throw SerializationException(error: error);
    }

    return true;
  }
}
