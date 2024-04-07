import 'package:dio/dio.dart';

const List<DioExceptionType> timeoutExceptionTypes = [
  DioExceptionType.connectionTimeout,
  DioExceptionType.receiveTimeout,
  DioExceptionType.sendTimeout,
  DioExceptionType.cancel,
  DioExceptionType.connectionError,
];

class _BaseException implements Exception {
  final String? message;
  final Object? error;

  _BaseException({this.error, this.message});

  @override
  String toString() {
    if (error != null) {
      return '$runtimeType{error: ${error.runtimeType} - ${error.toString()}}';
    } else if (message != null) {
      return '$runtimeType{message: $message}';
    } else {
      return '$runtimeType';
    }
  }
}

class SerializationException extends _BaseException {
  SerializationException({super.error});
}

class ServerException extends _BaseException {
  ServerException({super.message});
}

class CacheException extends _BaseException {}

class TokenException extends _BaseException {}

class NoFieldException extends _BaseException {}

class NoPathException extends _BaseException {}

class NotCorrectUrlException extends _BaseException {}
